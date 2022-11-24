import 'package:noa_driver/core/environments/base_config.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';

class StoreListResponseData {
  final int? storeId;
  final int? supplierId;
  final String? shopName;
  final String? mobile;
  final String? landPhone;
  final String? email;
  final String? address;
  final String? largeImage;
  final String? mediumImage;
  final String? smallImage;
  final dynamic parentId;
  final String? latitued;
  final String? longitued;
  final String? description;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final String? countryImage;
  final bool? isService;
  final String? previousLatitued;
  final String? previousLongitued;
  final String? distance;
  final String? distanceTime;
  final int? subCommunityId;
  final List<String> onlineAtSubCommunities;

  List<SubCommunityModel>? subCommunitiesOnlineList;
  String communityName;
  bool isOnline;

  StoreListResponseData({
    this.storeId,
    this.supplierId,
    this.shopName,
    this.mobile,
    this.landPhone,
    this.email,
    this.address,
    this.largeImage,
    this.mediumImage,
    this.smallImage,
    this.parentId,
    this.latitued,
    this.longitued,
    this.description,
    this.countryId,
    this.stateId,
    this.cityId,
    this.countryImage,
    this.isService,
    this.previousLatitued,
    this.previousLongitued,
    this.distance,
    this.distanceTime,
    this.subCommunityId,
    this.onlineAtSubCommunities = const [],
    this.communityName = '',
    this.isOnline = false,
    this.subCommunitiesOnlineList,
  });

  factory StoreListResponseData.fromJson(Map<String, dynamic> json) {
    String fileLocation = '';
    if (json.containsKey("mediumImage") && json["mediumImage"] != null) {
      fileLocation = json["mediumImage"];
      if (fileLocation.toString().contains('admin.noa.market') ||
          fileLocation.toString().contains('staging.noa.market')) {
      } else {
        var env = Environment().config.envType;
        if (env == EnvironmentType.dev) {
          fileLocation = 'https://staging.noa.market/' + fileLocation;
        } else {
          fileLocation = 'https://admin.noa.market/' + fileLocation;
        }
      }
    }

    String fileLocationForLargeImage = '';
    if (json.containsKey("largeImage") && json["largeImage"] != null) {
      fileLocationForLargeImage = json["largeImage"];
      if (fileLocationForLargeImage.toString().contains('admin.noa.market') ||
          fileLocationForLargeImage.toString().contains('staging.noa.market')) {
      } else {
        var env = Environment().config.envType;
        if (env == EnvironmentType.dev) {
          fileLocationForLargeImage =
              'https://staging.noa.market/' + fileLocationForLargeImage;
        } else {
          fileLocationForLargeImage =
              'https://admin.noa.market/' + fileLocationForLargeImage;
        }
      }
    }

    return StoreListResponseData(
      storeId: json['storeId'],
      supplierId: json['supplierId'] as int?,
      shopName: json['shopName'] as String?,
      mobile: json['mobile'] as String?,
      landPhone: json['landPhone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      largeImage: fileLocationForLargeImage,
      mediumImage: fileLocation,
      smallImage: json['smallImage'] as String?,
      parentId: json['parentId'],
      latitued: json['latitued'] as String?,
      longitued: json['longitued'] as String?,
      description: json['description'] as String?,
      countryId: json['countryId'] as int?,
      stateId: json['stateId'] as int?,
      cityId: json['cityId'] as int?,
      countryImage: json['countryImage'] as String?,
      isService: json['isService'] as bool?,
      previousLatitued: json['previousLatitued'] as String?,
      previousLongitued: json['previousLongitued'] as String?,
      distance: json['distance'] as String?,
      distanceTime: json['distanceTime'] as String?,
      subCommunityId: json['subCommunityId'] as int?,
      onlineAtSubCommunities: json['onlineAtSubCommunities'] == null
          ? []
          : (json['onlineAtSubCommunities'].toString().split(',')),
    );
  }

  Map<String, dynamic> toJson() => {
        'storeId': storeId,
        'supplierId': supplierId,
        'shopName': shopName,
        'mobile': mobile,
        'landPhone': landPhone,
        'email': email,
        'address': address,
        'largeImage': largeImage,
        'mediumImage': mediumImage,
        'smallImage': smallImage,
        'parentId': parentId,
        'latitued': latitued,
        'longitued': longitued,
        'description': description,
        'countryId': countryId,
        'stateId': stateId,
        'cityId': cityId,
        'countryImage': countryImage,
        'isService': isService,
        'previousLatitued': previousLatitued,
        'previousLongitued': previousLongitued,
        'distance': distance,
        'distanceTime': distanceTime,
        'onlineAtSubCommunities': onlineAtSubCommunities,
      };
}
