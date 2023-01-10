import 'package:noa_driver/core/models/order_model/order_update_request_model.dart';
import 'package:noa_driver/core/models/primary_order_models/primary_order_model.dart';
import 'package:noa_driver/core/models/store/store_model.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/http-service/api_response.dart';
import 'package:noa_driver/http-service/http-service.dart';
import 'package:noa_driver/locator/locator.dart';
import 'package:noa_driver/order-details/model/product_filter.dart';
import 'package:noa_driver/order-details/model/product_response_data.dart';
import 'package:noa_driver/utils/api-constant.dart';

import 'model/body/driver-location-input.dart';
import 'model/body/filter_input.dart';
import 'model/current-orrder-responssedata.dart';
import 'model/driver-location-status.dart';
import 'model/driver-profile-response-data.dart';
import 'model/order-details-response-data.dart';
import 'model/previous-order-responsedata.dart';

class OrderRepository {
  final _httpService = locator<HttpService>();

  Future<ApiResponse<List<StoreListResponseData?>>> getAllStores() async {
    var apiResponse = await _httpService.getRequest(
      ApiConstant.SERVER + ApiConstant.GET_ALL_STORES,
    );

    List<StoreListResponseData?> list = List.empty(growable: true);

    if (apiResponse.httpCode == 200 && apiResponse.data.data is List) {
      for (var element in (apiResponse.data.data as List)) {
        list.add(
          StoreListResponseData.fromJson(element),
        );
      }
    }

    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: list);
  }

  Future<ApiResponse<List<CurrentOrderResponseData?>>> getCourrentOrder(
    int driverId,
  ) async {
    var apiResponse = await _httpService.getRequest(
      ApiConstant.SERVER + ApiConstant.DRIVER_CURRENT_ORDER,
      qp: {
        "StoreId": driverId.toString(),
      },
    );

    List<CurrentOrderResponseData?> list = List.empty(growable: true);

    if (apiResponse.httpCode == 200 && apiResponse.data.data is List) {
      for (var element in (apiResponse.data.data as List)) {
        list.add(
          CurrentOrderResponseData.fromJson(element),
        );
      }
    }

    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: list);
  }

  Future<ApiResponse<List<SubCommunityModel>>> getSubCommunities() async {
    var apiResponse = await _httpService.getRequest(
      ApiConstant.SERVER + ApiConstant.GET_SUBCOMMUNITIES,
    );

    return ApiResponse(
      httpCode: apiResponse.httpCode,
      message: apiResponse.message,
      data: List<SubCommunityModel>.from(
        apiResponse.data.data.map(
          (model) => SubCommunityModel.fromJson(model),
        ),
      ),
    );
  }

  Future<ApiResponse<OrderDetails?>?> getOrderDetails(
      String invoiceMasterId, String invoiceId) async {
    try {
      var apiResponse = await _httpService.getRequest(
          ApiConstant.SERVER + ApiConstant.ORDER_DETAILS,
          qp: {"invoiceMasterId": invoiceMasterId, "invoiceId": invoiceId});
      return ApiResponse(
          httpCode: apiResponse.httpCode,
          message: apiResponse.message,
          data: OrderDetails.fromJson(apiResponse.data.data));
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse<DriverProfile?>> getProfileUser(int driverId) async {
    var apiResponse = await _httpService.getRequest(
        ApiConstant.SERVER + ApiConstant.DRIVER_PROFILE,
        qp: {"supplierId": driverId.toString()});

    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: DriverProfile.fromJson(apiResponse.data.data));
  }

  Future<ApiResponse<dynamic>> upDateOrderStatus(
      int inVoiceId, int statusId) async {
    var apiResponse = await _httpService
        .getRequest(ApiConstant.SERVER + ApiConstant.UPDATE_ORDER_STATUS, qp: {
      "invoiceId": inVoiceId.toString(),
      "invoiceStatusId": statusId.toString(),
    });

    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: DriverProfile.fromJson(apiResponse.data.data));
  }

  Future<ApiResponse<List<PreviousOrderResponseData?>>> getPreviousOrderItems(
      int driverId) async {
    var apiResponse = await _httpService.getRequest(
      ApiConstant.SERVER + ApiConstant.PREVIOUS_ORDEREDITEMS,
      qp: {
        "StoreId": driverId.toString(),
      },
    );

    List<PreviousOrderResponseData> list = List.empty(growable: true);

    if (apiResponse.httpCode == 200 && apiResponse.data.data is List) {
      for (var element in (apiResponse.data.data as List)) {
        list.add(
          PreviousOrderResponseData.fromJson(element),
        );
      }
    }

    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: list);
  }

  Future<ApiResponse<DriverLocationStatus>> driverUpdateLocation(
      BodyDriverLocationInput data) async {
    var apiResponse = await _httpService.postRequest(
        ApiConstant.SERVER + ApiConstant.DRIVER_LOCATIONINPUT,
        data: data.toJson());

    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: DriverLocationStatus.fromJson(apiResponse.data.data));
  }

  Future<ApiResponse<List<ProductResponseData?>>> getProductsByStoreId(
      int storeid) async {
    var apiResponse = await _httpService.getRequest(
        ApiConstant.SERVER +
            ApiConstant.PRODUCT_LIST +
            "/4" +
            "/1" +
            "/1" +
            "/1",
        qp: {"shopId": storeid.toString()});

    List<ProductResponseData> list = List.empty(growable: true);

    if (apiResponse.httpCode == 200 && apiResponse.data.data is List) {
      for (var element in (apiResponse.data.data as List)) {
        list.add(
          ProductResponseData.fromJson(element),
        );
      }
    }

    list.removeWhere((e) => e.mobileAppVisibility == false);
    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: list);
  }

  Future<ApiResponse> updateLocationNotify(
      String pickuplat, String pickupLongitude, int supplierId) async {
    var apiResponse = await _httpService
        .getRequest(ApiConstant.SERVER + ApiConstant.DRIVER_NOTIFICATION, qp: {
      "pickupLatitude": pickuplat,
      "pickupLongitude": pickupLongitude,
      "driverId": supplierId.toString()
    });

    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: apiResponse);
  }

  // LATEST K
  // GOD FORGIVE ME FOR CODING SO PORELY
  // HAVE TO FOLLOW LEGACY FOR SOME TIME

  Future<ApiResponse<List<OrderDetails>>> getAllOrdersForCustomer(
      String customerID) async {
    var apiResponse = await _httpService.getRequest(
        ApiConstant.SERVER + ApiConstant.GET_ALL_ORDERS_FOR_CUSTOMER,
        qp: {"userId": customerID});

    //print(apiResponse.toString());
    List<OrderDetails> list = List.empty(growable: true);

    if (apiResponse.httpCode == 200 && apiResponse.data.data is List) {
      for (var element in (apiResponse.data.data as List)) {
        list.add(
          OrderDetails.fromJson(element),
        );
      }
    }

    return ApiResponse(
        httpCode: apiResponse.httpCode,
        message: apiResponse.message,
        data: list);
  }

  Future<bool> updateOrder({required Map<String, dynamic> requestModel}) async {
    try {
      var apiResponse = await _httpService.postRequest(
          ApiConstant.SERVER + ApiConstant.UPDATE_ORDER,
          data: requestModel);

      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> tempUpdateOrder({required PrimaryBodyOrder requestModel}) async {
    try {
      var apiResponse = await _httpService.postRequest(
          ApiConstant.SERVER + ApiConstant.UPDATE_ORDER,
          data: requestModel.toJson());

      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> sendNotificationToCustomer(
      {required Map<String, dynamic> requestModel}) async {
    var apiResponse = await _httpService.postRequest(
        ApiConstant.SERVER + ApiConstant.SEND_NOTIFICATION_TO_CUSTOMER,
        data: requestModel);

    var temp = apiResponse;
    return true;
  }
}
