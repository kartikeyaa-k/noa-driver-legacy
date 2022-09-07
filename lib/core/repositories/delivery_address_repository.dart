import 'package:noa_driver/core/models/communities_model.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/http-service/api_response.dart';
import 'package:noa_driver/http-service/http-service.dart';
import 'package:noa_driver/locator/locator.dart';
import 'package:noa_driver/utils/api-constant.dart';

class DeliveryAddressRepository {
  final _httpService = locator<HttpService>();

  Future<ApiResponse<List<CommunityModel>>> getCommunities() async {
    var apiResponse = await _httpService.getRequest(
      ApiConstant.SERVER + ApiConstant.GET_COMMUNITIES,
    );

    return ApiResponse(
      httpCode: apiResponse.httpCode,
      message: apiResponse.message,
      data: List<CommunityModel>.from(
        apiResponse.data.data.map(
          (model) => CommunityModel.fromJson(model),
        ),
      ),
    );
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

  Future<bool> sendNotificationToEntireSubCommunity({
    required String driverId,
    required int subCommunityId,
  }) async {
    var apiResponse = await _httpService.getRequest(
        ApiConstant.SERVER + ApiConstant.SENT_NOTITIFICATION_ALL_SUBCOMMUNITIES,
        qp: {
          'subCommunityId': subCommunityId.toString(),
          'driverId': driverId,
        });

    if (apiResponse.httpCode == 200) {
      return true;
    }
    return false;
  }
}
