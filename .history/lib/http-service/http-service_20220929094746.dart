import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:noa_driver/core/environments/base_config.dart';
import 'package:noa_driver/core/environments/server_config.dart';

import 'api_response.dart';

class HttpService {
  //late Dio _dio;
  var _dio;
  var logger = Logger();

  final _serverConfig = ServerConfig(
    isHttps: Environment().config.isSecure,
    baseUrl: Environment().config.baseUrl,
  );

  Dio _getDio() {
    if (_dio == null) {
      _dio = Dio();

      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            options.headers = {
              "Content-Type": "application/json",
              //"Authorization": "Bearer  $token",
            };

            return handler.next(options); //continue
          },
          onResponse:
              (Response response, ResponseInterceptorHandler handler) async {
            return handler.next(response); // continue
          },
          onError: (DioError e, ErrorInterceptorHandler handler) async {
            return handler.next(e); //continue
          },
        ),
      );
      // _dio.interceptors.add(LogInterceptor(responseBody: true));
    }

    return _dio;
  }

  Future<ApiResponse<Response>> specialDio(
    String route, {
    FormData? data,
    String? jsonData,
    bool isurlEncoded = false,
    Function(int sent, int total)? onProgress,
  }) async {
    try {
      _getDio().options.contentType = Headers.formUrlEncodedContentType;
      /* _getDio().options.headers= {"Content-Type":"application/json","Authorization":"Token ${ApiConst.WORKSPACETOKEN_LIVE}"};*/

      Response response = await _getDio().post(
        route,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        onSendProgress: (int sent, int total) {
          // print("onSendProgress $total $sent");
          if (onProgress != null) onProgress(sent, total);
        },
      );
      // print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            data: response,
            message: '');
      } else {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            message: "Connection error. ${response.statusCode}",
            data: response);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // print(e.response!.data);
        // print(e.response!.statusCode);
        return ApiResponse(
            httpCode: int.parse(e.response!.statusCode.toString()),
            message: "${e.response!.statusMessage}",
            data: e.response!.data);
      } else {
        // print(e.message);
        return ApiResponse(
            httpCode: -1,
            message: "Connection error. ${e.message}",
            data: e.response!.data);
      }
    }
  }

  Future<ApiResponse<Response>> getRequest(String route,
      {Map<String, String>? qp}) async {
    try {
      // REQUEST :
      route = route.replaceAll('https://admin.noa.market/', '');

      logger.wtf('REQUEST GET : --------');
      logger.wtf('Path : ${_serverConfig.baseUrl + route}');
      logger.wtf('Request : $qp');

      Response response = await _getDio().get(
        route,
        queryParameters: qp,
      );
      logger.wtf('Response GET : --------');
      logger.wtf('Status Code GET : ${response.statusCode}');
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            data: response,
            message: '');
      } else {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            message: "Connection error. ${response.statusCode}",
            data: response.data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // print(e.response!.data);
        // print(e.response!.statusCode);
        return ApiResponse(
            httpCode: e.response!.statusCode!,
            message: "${e.response!.statusMessage}",
            data: e.response!);
      } else {
        // print(e.message);
        return ApiResponse(
            httpCode: -1,
            message: "Connection error. ${e.message}",
            data: e.response!.data);
      }
    }
  }

  Future<ApiResponse<Response>> postRequest(
    String route, {
    Map<String, dynamic>? data,
    String? jsonData,
    bool isFormData = false,
    Function(int sent, int total)? onProgress,
  }) async {
    _getDio().options.headers = {
      "Content-Type": "multipart/form-data",
      "accept": "*/*",
    };

    try {
      String jsondata = jsonEncode(data);
      // print("the body data is ------------${jsondata}");
      print(data);
      Response response = await _getDio().post(
        route,
        data: isFormData
            ? FormData.fromMap(data!)
            : (jsonData ?? jsonEncode(data)),
        onSendProgress: (int sent, int total) {
          // print("onSendProgress $total $sent");
          if (onProgress != null) onProgress(sent, total);
        },
      );
      // print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            data: response,
            message: '');
      } else {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            message: "Connection error. ${response.statusCode}",
            data: response.data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // print(e.response!.data);
        // print(e.response!.statusCode);
        return ApiResponse(
            httpCode: int.parse(e.response!.statusCode.toString()),
            message: "${e.response!.statusMessage}",
            data: e.response!);
      } else {
        // print(e.message);
        return ApiResponse(
            httpCode: -1,
            message: "Connection error. ${e.message}",
            data: e.response!.data);
      }
    }
  }

  Future<ApiResponse<Response>> postRequesturlencoded(
    String route, {
    FormData? data,
    String? jsonData,
    bool isurlEncoded = false,
    Function(int sent, int total)? onProgress,
  }) async {
    try {
      _getDio().options.contentType = Headers.formUrlEncodedContentType;
      /* _getDio().options.headers= {"Content-Type":"application/json","Authorization":"Token ${ApiConst.WORKSPACETOKEN_LIVE}"};*/

      Response response = await _getDio().post(
        route,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        onSendProgress: (int sent, int total) {
          // print("onSendProgress $total $sent");
          if (onProgress != null) onProgress(sent, total);
        },
      );
      // print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            data: response,
            message: '');
      } else {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            message: "Connection error. ${response.statusCode}",
            data: response);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // print(e.response!.data);
        // print(e.response!.statusCode);
        return ApiResponse(
            httpCode: int.parse(e.response!.statusCode.toString()),
            message: "${e.response!.statusMessage}",
            data: e.response!.data);
      } else {
        // print(e.message);
        return ApiResponse(
            httpCode: -1,
            message: "Connection error. ${e.message}",
            data: e.response!.data);
      }
    }
  }

  Future<ApiResponse<Response>> puttRequest(String route,
      {required Map<String, dynamic> data}) async {
    try {
      Response response = await _getDio().put(
        route,
        data: jsonEncode(data),
      );
      // print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            data: response,
            message: '');
      } else {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            message: "Connection error. ${response.statusCode}",
            data: response.data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // print(e.response!.data);
        // print(e.response!.statusCode);
        return ApiResponse(
            httpCode: int.parse(e.response!.statusCode.toString()),
            message: "${e.response!.statusMessage}",
            data: e.response!.data);
      } else {
        // print(e.message);
        return ApiResponse(
            httpCode: -1,
            message: "Connection error. ${e.message}",
            data: e.response!.data);
      }
    }
  }

  Future<ApiResponse<Response>> deleteRequest(String route,
      {required Map<String, dynamic> data}) async {
    try {
      Response response = await _getDio().delete(route, queryParameters: data);
      // print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            data: response,
            message: '');
      } else {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            message: "Connection error. ${response.statusCode}",
            data: response.data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // print(e.response!.data);
        // print(e.response!.statusCode);
        return ApiResponse(
            httpCode: int.parse(e.response!.statusCode.toString()),
            message: "${e.response!.statusMessage}",
            data: e.response!.data);
      } else {
        // print(e.message);
        return ApiResponse(
            httpCode: -1,
            message: "Connection error. ${e.message}",
            data: e.response!.data);
      }
    }
  }

  Future<ApiResponse<Response>> uploadImage(
      String route, FormData formData) async {
    /*  _getDio().options.headers= {"Content-Type":"application/json","Authorization":"Token ${ApiConst.WORKSPACETOKEN_LIVE}"};*/
    try {
      Response response = await _getDio().post(
        route,
        data: formData,
      );
      // print("$route : $response");

      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            data: response,
            message: '');
      } else {
        return ApiResponse(
            httpCode: int.parse(response.statusCode.toString()),
            message: "Connection error. ${response.statusCode}",
            data: response.data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // print(e.response!.data);
        // print(e.response!.statusCode);
        return ApiResponse(
            httpCode: int.parse(e.response!.statusCode.toString()),
            message: "${e.response!.statusMessage}",
            data: e.response!.data);
      } else {
        // print(e.message);
        return ApiResponse(
            httpCode: -1,
            message: "Connection error. ${e.message}",
            data: e.response!.data);
      }
    }
  }
}



// {"invoiceMasterId":31451,"customerId":10286,"refNumber":"ORD-2208284461201","invoiceDate":"2022-08-28T20:48:31.2740734","totalAmount":49.0,"receivedAmt":0,"courierCharge":0,"carryingCost":0,"paymentMethod":0,"remark":"confirmed","discountCode":"string","discountValue":0,"paymentStatus":0,"status":"string","createdAt":"2022-08-28T16:42:37.69911Z","countryId":0,"stateId":0,"cityId":0,"invoiceStatusId":0,"supplierId":10205,"eventId":0,"invoiceRequestModels":[{"invoiceId":31925,"invoiceMasterId":31443,"refNumber":"INV-2208282126100","invoiceDate":"2022-08-28T04:41:28.468Z","totalAmount":49.0,"receivedAmt":0,"carryingCost":0,"courierCharge":0,"paymentMethod":0,"paymentStatus":0,"remark":"confirmed","discountCode":"string","discountValue":0,"storeId":null,"status":"string","createdAt":"2022-08-28T16:42:37.699125Z","supplierId":10205,"supplierName":null,"shopName":"shopName","invoiceStatusId":0,"amountToSupplier":74,"amountToAdmin":0,"supplierCommissionId":0,"isService":true,"shopLogo":"string","isDigitalProduct":true,"isQuotationProduct":true,"serviceDate":"2022-08-28T16:42:37.699137Z","serviceDateTime":"2022-08-28T16:42:37.699145Z","serviceTime":"2022-08-28T16:42:37.699152Z","serviceTimeString":"string","parentInvoiceId":0,"ticketBuyForCustomerId":0,"customerId":10280,"invoiceDetailsRequestModels":[{"invoiceDetailsId":34344,"invoiceId":31925,"productMasterId":11481,"quantity":2,"price":37,"status":"string","createdAt":"2022-08-28T15:58:48","productSubSKUId":0,"qrCodeNo":"String","pdfUrl":"string","qrCodeImage":"string"}],"invoiceDetailsViewModels":[{"invoiceDetailsId":34344,"invoiceId":31925,"productMasterId":11481,"quantity":1.2,"price":42,"status":"string","createdAt":"2022-08-28T15:58:48","productTypeId":0,"storeId":null,"supplierId":0,"supplierName":"string","supplierMobile":"string","productName":"Test Product Updated","invoiceMasterId":31443,"productSkuId":11616,"subSku":"123Test","largeImage":"http://admin.noa.market/","mediumImage":"http://admin.noa.market/","smallImage":null,"fileLocation":null,"digitalProductGuid":null,"digitalProductUrl":null,"serviceDate":null,"qrCodeNo":"string","pdfUrl":"string","qrCodeImage":"string","brandName":null,"productSubSKUViewModels":[]}],"eventPetDetailsRequestModels":[{"profileId":0,"customerId":10280,"name":null,"petTypeId":0,"profileBreedGroupId":0,"microchipNumber":0,"dateOfBirth":null,"gender":"0","status":null,"about":"string","isYourVaccinated":true,"isYourCastrated":true,"createBy":0,"updateDate":null,"invoiceMasterId":31443,"invoiceId":31925}]}],"paymentRequestModels":[{"paymentId":31435,"invoiceMasterId":31443,"currencyId":1,"amount":23,"courierCharge":0,"discountAmount":0,"carryingCost":0,"paymentMethod":1,"courierAgencyId":null,"payDate":"2022-08-28T15:58:45","note":"","transactionNo":"string","status":"","createdAt":"2022-08-28T15:58:45","couponId":0}],"billingShippingAddressRequestModels":[{"billingShippingAddressId":11418,"invoiceMasterId":31443,"customerId":10280,"countryId":0,"stateId":0,"cityId":0,"name":"","addressLine":"333","addressLine2":"","landMark":"","deleveryNote":"","status":"","createdAt":"2022-08-28T15:58:45","updatedAt":"2022-08-28T15:58:45","zipCode":"","phoneNumber":"","isDefault":false,"latitued":"","longitued":"","deleveryTime":"2022-08-28T15:58:45","isBilingAddress":false,"isShippingAddress":false,"customerAddressId":11418}],"inputFieldValueRequestModels":[],"orderFrom":"string","orderSource":"string"}