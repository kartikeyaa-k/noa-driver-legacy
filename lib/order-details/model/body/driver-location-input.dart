class BodyDriverLocationInput {
  final int? storeId;
  final String? previousLatitued;
  final String? previousLongitued;
  final String? latitued;
  final String? longitued;
  final String? subCommunityId;
  final List<int> onlineAtSubCommunities;

  BodyDriverLocationInput(
      {this.storeId,
      this.previousLatitued,
      this.previousLongitued,
      this.latitued,
      this.longitued,
      this.subCommunityId,
      this.onlineAtSubCommunities = const []});

  BodyDriverLocationInput.fromJson(Map<String, dynamic> json)
      : storeId = json['storeId'] as int?,
        previousLatitued = json['previousLatitued'] as String?,
        previousLongitued = json['previousLongitued'] as String?,
        latitued = json['latitued'] as String?,
        longitued = json['longitued'] as String?,
        subCommunityId = json['subCommunityId'] as String?,
        onlineAtSubCommunities = [];

  Map<String, dynamic> toJson() => {
        'storeId': storeId,
        'previousLatitued': previousLatitued,
        'previousLongitued': previousLongitued,
        'latitued': latitued,
        'longitued': longitued,
        'subCommunityId': subCommunityId,
        'onlineAtSubCommunities': onlineAtSubCommunities,
      };
}
