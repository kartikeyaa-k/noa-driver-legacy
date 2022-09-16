import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noa_driver/core/helpers/app_helpers.dart';
import 'package:noa_driver/core/models/order_model/order_update_request_model.dart';
import 'package:noa_driver/core/models/primary_order_models/primary_order_model.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/locator/locator.dart';
import 'package:noa_driver/login-registration/model/custommer-login.dart';
import 'package:noa_driver/main.dart';
import 'package:noa_driver/order-details/model/body/filter_input.dart';
import 'package:noa_driver/order-details/model/product_filter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/body/driver-location-input.dart';
import 'model/current-orrder-responssedata.dart';
import 'model/driver-location-status.dart';
import 'model/driver-profile-response-data.dart';
import 'model/order-details-response-data.dart';
import 'model/previous-order-responsedata.dart';
import 'order-repository.dart';

class OrderController extends ChangeNotifier {
  final _orderRepo = locator<OrderRepository>();

  DriverLogin? custommerLogin;
  DriverProfile? driverProfiledata;

  bool _isLocationon = true;

  bool get isLocationon => _isLocationon;

  set isLocationon(bool value) {
    _isLocationon = value;
    notifyListeners();
  }

  List<CurrentOrderResponseData?> currentOrderList = [];
  List<PreviousOrderResponseData?> previousList = [];
  List<SubCommunityModel> subCommunityList = [];
  OrderDetails? orderDetailsList;
  DriverLocationStatus? driverLocationStatus;
  ProductFilter? productFilter;
  int previousOrderCount = 0;
  int currentOrderCount = 0;
  Position? currentPosition;

  getCourrentOrder(int driverId,
      {bool isFirstTime = false, String? subCommunityName}) async {
    var apiresponse = await _orderRepo.getCourrentOrder(driverId);

    if (apiresponse.httpCode == 200) {
      currentOrderList.clear();
      var reveresedResponse = apiresponse.data.reversed;
      currentOrderList.addAll(reveresedResponse);

      // Notification if length increased
      if (isFirstTime) {
        previousOrderCount = currentOrderList.length;
        currentOrderCount = currentOrderList.length;
      } else {
        currentOrderCount = currentOrderList.length;
        if (currentOrderCount > previousOrderCount) {
          // Received new orders, send notification
          previousOrderCount = currentOrderCount;
          sendNotificationToDriverForNewOrder(currentOrderList.last!);
        }
      }
    }

    notifyListeners();
  }

  Future<void> sendNotificationToDriverForNewOrder(
      CurrentOrderResponseData orderData) async {
    String? firebaseToken = await messaging.getToken();
    var subCommunityId = orderData
        .customerViewModel?.customerAddressViewModels?.first.buildingName;

    List<SubCommunityModel> list = [];
    if (subCommunityList.isNotEmpty) {
      list.addAll(subCommunityList);
    } else {
      list = await getAllSubCommunitiesForMapping();
    }

    String name = AppHelper.getSubCommunityNameFromId(list, subCommunityId);

    if (firebaseToken != null) {
      if (subCommunityList.isNotEmpty ||
          subCommunityId != null ||
          name.isNotEmpty) {
        sendPushMessageToIndividual(
            '', 'Alert! New Order placed in $name', firebaseToken);
      } else {
        sendPushMessageToIndividual(
            '', 'Alert! New Order placed.', firebaseToken);
      }
    }
  }

  Future<List<SubCommunityModel>> getAllSubCommunitiesForMapping() async {
    try {
      var response = await _orderRepo.getSubCommunities();
      subCommunityList.clear();
      subCommunityList.addAll(response.data);

      return response.data;
    } catch (e) {
      // ignore: avoid_print

      print(
          'ERROR WHILE GETTING SUB-COMMMUNITIES========================================');
      // ignore: avoid_print
      print('ERROR : ' + e.toString());
      print('END========================================');
      return [];
    }
  }

  Future<OrderDetails?> getOrderDetails(
      String invoiceMasterId, String invoiceId) async {
    var apiresponse =
        await _orderRepo.getOrderDetails(invoiceMasterId, invoiceId);

    if (apiresponse?.httpCode == 200) {
      orderDetailsList = apiresponse?.data;
      return orderDetailsList;
    }
    notifyListeners();
    return null;
  }

  Future<bool> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginData = (prefs.getString('logininfo') ?? "");

    if (loginData.isNotEmpty) {
      // print("the data is ${loginData}");

      Map<String, dynamic> mapdata = jsonDecode(loginData);

      custommerLogin = DriverLogin.fromJson(mapdata);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  getUserProfile(int DriverId) async {
    var apiresponse = await _orderRepo.getProfileUser(DriverId);
    if (apiresponse.httpCode == 200) {
      driverProfiledata = apiresponse.data;
      // print("user data call success");
    }
    notifyListeners();
  }

  String orderstatus = "";
  bool progress = false;
  Future<bool> updateOrderStauts(int inViceId, int orderStatusId) async {
    var apiresponse =
        await _orderRepo.upDateOrderStatus(inViceId, orderStatusId);
    if (apiresponse.httpCode == 200) {
      print('DRIVER ORDER : COMPLETE : Response : ${apiresponse.data}');
      // driverProfiledata=apiresponse.data;
      // print("user data call success");
      orderstatus = orderStatusId == 4 ? "Complete" : "On the way";
      return true;
    } else {
      return false;
    }
  }

  getPreviousOrderedItems(int driverId) async {
    var apiresponse = await _orderRepo.getPreviousOrderItems(driverId);
    if (apiresponse.httpCode == 200) {
      previousList.clear();
      previousList.addAll(apiresponse.data);
    }
    notifyListeners();
  }

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      //throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> locatePosition(int driverId, String? subCommunityId) async {
    //Uint8List imagedata = await getMarkerMyCurrentPosition();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;
    LatLng latLng = LatLng(position.latitude, position.longitude);
    // print("lat ${latLng.latitude}  and lang ${latLng.longitude}");
    driverLocationInput(driverId, latLng, subCommunityId);

    // CameraPosition cameraPosition = CameraPosition(target:latLng,zoom: 14 );
    // controller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    //
    // setState(() {
    //   marker= Marker(
    //     markerId: MarkerId("Homee"),
    //     position: latLng,
    //     rotation: _currentPosition!.heading,
    //     draggable: false,
    //     zIndex: 3,
    //     flat: true,
    //     anchor: Offset(0.5,0.5),
    //     icon: BitmapDescriptor.fromBytes(imagedata),
    //
    //   );
    //   circle= Circle(
    //       circleId: CircleId("radius"),
    //       radius: _currentPosition!.accuracy,
    //       zIndex: 1,
    //       strokeColor: Colors.blue,
    //       center: latLng,
    //       fillColor: Colors.blue.withAlpha(70)
    //   );
    // });
  }

  driverLocationInput(
      int driverId, LatLng latLng, String? subCommunityId) async {
    var data = BodyDriverLocationInput(
        storeId: driverId,
        latitued: "${latLng.latitude != 0 ? latLng.latitude : ""}",
        longitued: "${latLng.longitude != 0 ? latLng.longitude : ""}",
        previousLatitued: "${latLng.latitude != 0 ? latLng.latitude : ""}",
        previousLongitued: "${latLng.longitude != 0 ? latLng.longitude : ""}",
        subCommunityId: subCommunityId);

    var apiresponse = await _orderRepo.driverUpdateLocation(data);
    if (apiresponse.httpCode == 200) {
      driverLocationStatus = apiresponse.data;
    }
    notifyListeners();
  }

  inventoryFilter(int storeId) async {
    var data = FilterInput(
      storeId: storeId,
    );

    var apiresponse = await _orderRepo.inventoryFilter(data);
    if (apiresponse.httpCode == 200) {
      productFilter = apiresponse.data;
    }
    notifyListeners();
  }

  Future<bool> sendNotification(
      String pickuplat, String pikuplongitude, int supplierId) async {
    var apiresponse = await _orderRepo.updateLocationNotify(
        pickuplat, pikuplongitude, supplierId);
    if (apiresponse.httpCode == 200) {
      print('NOTIF: ');
      print(apiresponse.data);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendPushMessage(
      String body, String title, String token, String subCommunityId) async {
    try {
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAADhWbTOw:APA91bGE9Zfw0Sa2xppG8-r1c6RIXklMpziMAabdnEdJN4zjC-WWlitUHKpd6CoNNmT5_kqZZN7ywVi9eobOVa6ZP_bTTAQrWXNhqcFZzzzzd3pe3vzsSCaTxKe9vTLD9W5W3Te5FDJJ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "/topics/$subCommunityId"
          },
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<OrderDetails> getOrdersForAllCustomer(
      String customerID, String invoiceID) async {
    var apiresponse = await _orderRepo.getAllOrdersForCustomer(customerID);
    print(apiresponse);
    //TODO(k) : Please find the order as per invoiceID later
    return apiresponse.data.first;
  }

  Future<bool> sendPushMessageToIndividual(
      String body, String title, String token) async {
    try {
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAADhWbTOw:APA91bGE9Zfw0Sa2xppG8-r1c6RIXklMpziMAabdnEdJN4zjC-WWlitUHKpd6CoNNmT5_kqZZN7ywVi9eobOVa6ZP_bTTAQrWXNhqcFZzzzzd3pe3vzsSCaTxKe9vTLD9W5W3Te5FDJJ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token
          },
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // UPDATE ORDER
  Future<bool> updateOrder({required OrderDetails requestToUpdateOrder}) async {
    var safestWorkingRequest = {
      "invoiceMasterId": requestToUpdateOrder.invoiceMasterId,
      "customerId": requestToUpdateOrder.customerId,
      "refNumber": requestToUpdateOrder.refNumber,
      "invoiceDate": "2022-08-28T20:48:31.2740734",
      "totalAmount": requestToUpdateOrder.totalAmount,
      "receivedAmt": requestToUpdateOrder.totalAmount,
      "courierCharge": 0,
      "carryingCost": 0,
      "paymentMethod": 0,
      "remark": "confirmed",
      "discountCode": "confirmed",
      "discountValue": 0,
      "paymentStatus": 0,
      "status": "confirmed",
      "createdAt": "2022-08-28T16:42:37.69911Z",
      "countryId": 0,
      "stateId": 0,
      "cityId": 0,
      "invoiceStatusId":
          requestToUpdateOrder.invoiceViewModels?.first.invoiceStatusId,
      "supplierId": requestToUpdateOrder.invoiceViewModels?.first.supplierId,
      "eventId": 0,
      "invoiceRequestModels": [
        {
          "invoiceId": requestToUpdateOrder.invoiceViewModels?.first.invoiceId,
          "invoiceMasterId":
              requestToUpdateOrder.invoiceViewModels?.first.invoiceMasterId,
          "refNumber": requestToUpdateOrder.invoiceViewModels?.first.supplierId,
          "invoiceDate": "2022-08-28T04:41:28.468Z",
          "totalAmount": requestToUpdateOrder.totalAmount,
          "receivedAmt": requestToUpdateOrder.totalAmount,
          "carryingCost": 0,
          "courierCharge": 0,
          "paymentMethod": 0,
          "paymentStatus": 0,
          "remark": "confirmed",
          "discountCode": "confirmed",
          "discountValue": 0,
          "storeId": requestToUpdateOrder.invoiceViewModels?.first.storeId,
          "status": requestToUpdateOrder.invoiceViewModels?.first.status,
          "createdAt": "2022-08-28T16:42:37.699125Z",
          "supplierId":
              requestToUpdateOrder.companyProfileViewModel?.companyProfileId,
          "supplierName":
              requestToUpdateOrder.companyProfileViewModel?.companyName,
          "shopName": "shopName",
          "invoiceStatusId":
              requestToUpdateOrder.invoiceViewModels?.first.invoiceStatusId,
          "amountToSupplier": requestToUpdateOrder.totalAmount,
          "amountToAdmin": 0,
          "supplierCommissionId": requestToUpdateOrder
              .invoiceViewModels?.first.supplierCommissionId,
          "isService": true,
          "shopLogo": "confirmed",
          "isDigitalProduct": true,
          "isQuotationProduct": true,
          "serviceDate": "2022-08-28T16:42:37.699137Z",
          "serviceDateTime": "2022-08-28T16:42:37.699145Z",
          "serviceTime": "2022-08-28T16:42:37.699152Z",
          "serviceTimeString": "confirmed",
          "parentInvoiceId": 0,
          "ticketBuyForCustomerId": 0,
          "customerId": requestToUpdateOrder.customerId,
          "invoiceDetailsRequestModels": [
            {
              "invoiceDetailsId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.invoiceDetailsId,
              "invoiceId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.invoiceId,
              "productMasterId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productMasterId,
              "quantity":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.quantity,
              "price":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.price,
              "status": "confirmed",
              "createdAt": "2022-08-28T15:58:48",
              "productSubSKUId": 0,
              "qrCodeNo": "confirmed",
              "pdfUrl": "confirmed",
              "qrCodeImage": "confirmed"
            }
          ],
          "invoiceDetailsViewModels": [
            {
              "invoiceDetailsId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.invoiceDetailsId,
              "invoiceId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.invoiceId,
              "productMasterId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productMasterId,
              "quantity":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.quantity,
              "price":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.price,
              "status": "confirmed",
              "createdAt": "2022-08-28T15:58:48",
              "productTypeId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productTypeId,
              "storeId":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.storeId,
              "supplierId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.supplierId,
              "supplierName": "confirmed",
              "supplierMobile": "confirmed",
              "productName": "Test Product Updated",
              "invoiceMasterId": requestToUpdateOrder.invoiceMasterId,
              "productSkuId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productSkuId,
              "subSku": "123Test",
              "largeImage": "http://admin.noa.market/",
              "mediumImage": "http://admin.noa.market/",
              "smallImage": null,
              "fileLocation": null,
              "digitalProductGuid": null,
              "digitalProductUrl": null,
              "serviceDate": null,
              "qrCodeNo": "string",
              "pdfUrl": "string",
              "qrCodeImage": "string",
              "brandName": null,
              "productSubSKUViewModels": []
            }
          ],
          "eventPetDetailsRequestModels": [
            {
              "profileId": 0,
              "customerId": 10280,
              "name": null,
              "petTypeId": 0,
              "profileBreedGroupId": 0,
              "microchipNumber": 0,
              "dateOfBirth": null,
              "gender": "0",
              "status": null,
              "about": "string",
              "isYourVaccinated": true,
              "isYourCastrated": true,
              "createBy": 0,
              "updateDate": null,
              "invoiceMasterId": 31443,
              "invoiceId": 31925
            }
          ]
        }
      ],
      "paymentRequestModels": [
        {
          "paymentId": 31435,
          "invoiceMasterId": 31443,
          "currencyId": 1,
          "amount": 23,
          "courierCharge": 0,
          "discountAmount": 0,
          "carryingCost": 0,
          "paymentMethod": 1,
          "courierAgencyId": null,
          "payDate": "2022-08-28T15:58:45",
          "note": "confirmed",
          "transactionNo": "string",
          "status": "",
          "createdAt": "2022-08-28T15:58:45",
          "couponId": 0
        }
      ],
      "billingShippingAddressRequestModels": [
        {
          "billingShippingAddressId": 11418,
          "invoiceMasterId": 31443,
          "customerId": 10280,
          "countryId": 0,
          "stateId": 0,
          "cityId": 0,
          "name": "confirmed",
          "addressLine": "333",
          "addressLine2": "",
          "landMark": "confirmed",
          "deleveryNote": "confirmed",
          "status": "confirmed",
          "createdAt": "2022-08-28T15:58:45",
          "updatedAt": "2022-08-28T15:58:45",
          "zipCode": "",
          "phoneNumber": "",
          "isDefault": false,
          "latitued": "",
          "longitued": "",
          "deleveryTime": "2022-08-28T15:58:45",
          "isBilingAddress": false,
          "isShippingAddress": false,
          "customerAddressId": 11418
        }
      ],
      "inputFieldValueRequestModels": [],
      "orderFrom": "string",
      "orderSource": "string"
    };

    var request = {
      "invoiceMasterId": requestToUpdateOrder.invoiceMasterId,
      "customerId": requestToUpdateOrder.customerId,
      "refNumber": requestToUpdateOrder.refNumber,
      "invoiceDate": "2022-08-28T20:48:31.2740734",
      "totalAmount": requestToUpdateOrder.totalAmount,
      "receivedAmt": 0,
      "courierCharge": 0,
      "carryingCost": 0,
      "paymentMethod": 0,
      "remark": "confirmed",
      "discountCode": "string",
      "discountValue": 0,
      "paymentStatus": 0,
      "status": "string",
      "createdAt": "2022-08-28T16:42:37.69911Z",
      "countryId": 0,
      "stateId": 0,
      "cityId": 0,
      "invoiceStatusId": 1,
      // "supplierId":
      //    requestToUpdateOrder
      //             .invoiceDetailsViewModels?.first.supplierId,
      // "eventId": 0,
      "invoiceRequestModels": [
        {
          "invoiceId": requestToUpdateOrder.invoiceViewModels?.first.invoiceId,
          "invoiceMasterId": requestToUpdateOrder.invoiceMasterId,
          "refNumber": requestToUpdateOrder.refNumber,
          "invoiceDate": "2022-08-28T04:41:28.468Z",
          "totalAmount": requestToUpdateOrder.totalAmount,
          "receivedAmt": 0,
          "carryingCost": 0,
          "courierCharge": 0,
          "paymentMethod": 0,
          "paymentStatus": 0,
          "remark": "confirmed",
          "discountCode": "string",
          "discountValue": 0,
          "storeId":
              requestToUpdateOrder.invoiceDetailsViewModels?.first.storeId,
          "status": "string",
          "createdAt": "2022-08-28T16:42:37.699125Z",
          "supplierId":
              requestToUpdateOrder.invoiceDetailsViewModels?.first.supplierId,
          "supplierName":
              requestToUpdateOrder.invoiceDetailsViewModels?.first.supplierName,
          "shopName":
              requestToUpdateOrder.invoiceDetailsViewModels?.first.brandName,
          "invoiceStatusId": 1,
          "amountToSupplier": requestToUpdateOrder.totalAmount,
          "amountToAdmin": 0,
          "supplierCommissionId": 0,
          "isService": true,
          "shopLogo": "string",
          "isDigitalProduct": true,
          "isQuotationProduct": true,
          "serviceDate": "2022-08-28T16:42:37.699137Z",
          "serviceDateTime": "2022-08-28T16:42:37.699145Z",
          "serviceTime": "2022-08-28T16:42:37.699152Z",
          "serviceTimeString": "string",
          "parentInvoiceId":
              requestToUpdateOrder.invoiceDetailsViewModels?.first.invoiceId,
          "ticketBuyForCustomerId": 0,
          "customerId": requestToUpdateOrder.customerId,
          "invoiceDetailsRequestModels": [
            {
              "invoiceDetailsId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.invoiceDetailsId,
              "invoiceId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.invoiceId,
              "productMasterId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productMasterId,
              "quantity":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.quantity,
              "price":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.price,
              "status": "string",
              "createdAt": "2022-08-28T15:58:48",
              "productSubSKUId":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.subSku,
              "qrCodeNo": "String",
              "pdfUrl": "string",
              "qrCodeImage": "string"
            }
          ],
          "invoiceDetailsViewModels": [
            {
              "invoiceDetailsId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.invoiceDetailsId,
              "invoiceId":
                  requestToUpdateOrder.invoiceViewModels?.first.invoiceId,
              "productMasterId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productMasterId,
              "quantity":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.quantity,
              "price":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.price,
              "status": "string",
              "createdAt": "2022-08-28T15:58:48",
              "productTypeId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productTypeId,
              "storeId":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.storeId,
              "supplierId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.supplierId,
              "supplierName": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.supplierName,
              "supplierMobile": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.supplierMobile,
              "productName": "Test Product Updated",
              "invoiceMasterId": requestToUpdateOrder.invoiceMasterId,
              "productSkuId": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productSkuId,
              "subSku":
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.subSku,
              "largeImage": "http://admin.noa.market/",
              "mediumImage": "http://admin.noa.market/",
              "smallImage": null,
              "fileLocation": null,
              "digitalProductGuid": null,
              "digitalProductUrl": null,
              "serviceDate": null,
              "qrCodeNo": "string",
              "pdfUrl": "string",
              "qrCodeImage": "string",
              "brandName": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.brandName,
              "productSubSKUViewModels": requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productSubSKUViewModels
            }
          ],
          "eventPetDetailsRequestModels": [
            {
              "profileId": 0,
              "customerId": 10280,
              "name": null,
              "petTypeId": 0,
              "profileBreedGroupId": 0,
              "microchipNumber": 0,
              "dateOfBirth": null,
              "gender": "0",
              "status": null,
              "about": "string",
              "isYourVaccinated": true,
              "isYourCastrated": true,
              "createBy": 0,
              "updateDate": null,
              "invoiceMasterId": requestToUpdateOrder.invoiceMasterId,
              "invoiceId":
                  requestToUpdateOrder.invoiceViewModels?.first.invoiceId
            }
          ]
        }
      ],
      "paymentRequestModels": [
        {
          "paymentId": requestToUpdateOrder.paymentViewModels?.first.paymentId,
          "invoiceMasterId": requestToUpdateOrder.invoiceMasterId,
          "currencyId": 1,
          "amount": requestToUpdateOrder.totalAmount,
          "courierCharge": 0,
          "discountAmount": 0,
          "carryingCost": 0,
          "paymentMethod": 1,
          "courierAgencyId": null,
          "payDate": "2022-08-28T15:58:45",
          "note": "confirmed",
          "transactionNo": "string",
          "status": "",
          "createdAt": "2022-08-28T15:58:45",
          "couponId": 0
        }
      ],
      "billingShippingAddressRequestModels": [
        {
          "billingShippingAddressId": requestToUpdateOrder
              .billingAddressViewModels?.billingShippingAddressId,
          "invoiceMasterId": requestToUpdateOrder.invoiceMasterId,
          "customerId": requestToUpdateOrder.customerId,
          "countryId": 0,
          "stateId": 0,
          "cityId": 0,
          "name": "",
          "addressLine": "333",
          "addressLine2": "",
          "landMark": "",
          "deleveryNote": "confirmed",
          "status": "",
          "createdAt": "2022-08-28T15:58:45",
          "updatedAt": "2022-08-28T15:58:45",
          "zipCode": "",
          "phoneNumber": "",
          "isDefault": false,
          "latitued": "",
          "longitued": "",
          "deleveryTime": "2022-08-28T15:58:45",
          "isBilingAddress": false,
          "isShippingAddress": false,
          "customerAddressId": 11418
        }
      ],
      "inputFieldValueRequestModels": [],
      "orderFrom": "confirmed",
      "orderSource": "confirmed"
    };

    await _orderRepo
        .updateOrder(requestModel: safestWorkingRequest)
        .then((value) {
      if (value) {
        return true;
      } else {
        return false;
      }
    });
    return false;
  }

  PrimaryBodyOrder generateRequestOrderBody(OrderDetails requestToUpdateOrder) {
    return PrimaryBodyOrder(
      invoiceMasterId: requestToUpdateOrder.invoiceMasterId,
      customerId: requestToUpdateOrder.customerId,
      refNumber: "string",
      // invoiceDate: "2022-02-01T06:29:44.380Z",
      remark: 'confirmed',
      discountCode: "string",
      status: "string",
      //createdAt:"2022-02-01T06:29:44.380Z",
      courierCharge: 0,
      carryingCost: 0,
      paymentMethod: 0,
      discountValue: 0,
      paymentStatus: 0,
      cityId: requestToUpdateOrder.billingAddressViewModels?.cityId,
      stateId: requestToUpdateOrder.billingAddressViewModels?.stateId,
      invoiceStatusId: 1,
      totalAmount: requestToUpdateOrder.totalAmount?.floor(),
      receivedAmt: 0,
      countryId: requestToUpdateOrder.billingAddressViewModels?.countryId,
      invoiceRequestModels: [
        PrinamryInvoiceRe(
          totalAmount: requestToUpdateOrder.totalAmount?.floor(),
          receivedAmt: requestToUpdateOrder.totalAmount?.floor(),
          carryingCost: 0,
          courierCharge: 0,
          paymentMethod: 1,
          paymentStatus: 0,
          discountValue: 0,
          supplierCommissionId: 0,
          isService: false,
          isDigitalProduct: false,
          isQuotationProduct: false,
          storeId: requestToUpdateOrder.invoiceDetailsViewModels?.first.storeId,
          supplierId:
              requestToUpdateOrder.invoiceDetailsViewModels?.first.supplierId,
          serviceDate: null,
          serviceDateTime: null,
          serviceTime: null,
          invoiceDetailsRequestModels: [
            PrimaryInvoiceDetailsRequestModels(
              productMasterId: requestToUpdateOrder
                  .invoiceDetailsViewModels?.first.productMasterId,
              quantity:
                  requestToUpdateOrder.invoiceDetailsViewModels?.first.quantity,
              price: requestToUpdateOrder.invoiceDetailsViewModels?.first.price,
              // createdAt: "2022-02-01T06:29:44.380Z",
              // productSubSKUId: requestToUpdateOrder.invoiceDetailsViewModels
              //     ?.first.productSubSKUViewModels?[0]['productSubSKUId']
            )
          ],
        ),
        /*invoicerequesttest,*/
      ],
      billingShippingAddressRequestModels: [
        PrimaryBillingShippingRequestModels(
            billingShippingAddressId: requestToUpdateOrder
                .billingAddressViewModels?.billingShippingAddressId,
            customerId: requestToUpdateOrder.customerId,
            customerAddressId: requestToUpdateOrder
                .customerViewModel?.customerAddressViewModel?.customerAddressId,
            invoiceMasterId: requestToUpdateOrder.invoiceMasterId)
      ],
      paymentRequestModels: [
        PrimaryPaymentRequestModels(
            paymentId: 0,
            invoiceMasterId: requestToUpdateOrder.invoiceMasterId,
            currencyId: 1,
            amount: 0,
            courierCharge: 0,
            paymentMethod: 1,
            carryingCost: 0,
            discountAmount: 0,
            courierAgencyId: 0,
            //  payDate:"2022-02-01T06:29:44.380Z",
            note: "string",
            transactionNo: "string",
            status: "string",
            // createdAt:"2022-02-01T06:29:44.380Z",
            couponId: 0)
      ],
      inputFieldValueRequestModels: [],
    );
  }

  Future<bool> sendNotificationPrimary({
    required String body,
    required String title,
    required String firebaseToken,
    required String topic,
    required bool isToSpecificCustomer,
  }) async {
    try {
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAADhWbTOw:APA91bGE9Zfw0Sa2xppG8-r1c6RIXklMpziMAabdnEdJN4zjC-WWlitUHKpd6CoNNmT5_kqZZN7ywVi9eobOVa6ZP_bTTAQrWXNhqcFZzzzzd3pe3vzsSCaTxKe9vTLD9W5W3Te5FDJJ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": isToSpecificCustomer ? firebaseToken : topic
          },
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  void sendNotificationToCustomer({
    required String firebaseToken,
    requiredint userId,
    String topic = '',
    required String title,
    required String body,
    bool isSpecificUser = true,
    String onClickAction = '',
    int subComunityId = 0,
    int userType = 0,
  }) {
    Map<String, dynamic> request = {
      "fireBaseToken": "string",
      "topic": "string",
      "title": "string",
      "body": "string",
      "userId": 0,
      "isSpecificUser": true,
      "onClickAction": "string",
      "subComunityId": 0,
      "userType": 0
    };
    var response = _orderRepo.sendNotificationToCustomer(
      requestModel: request,
    );
  }
}
