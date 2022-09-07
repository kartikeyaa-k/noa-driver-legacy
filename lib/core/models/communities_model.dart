class CommunityModel {
  String id;
  String name;

  CommunityModel({required this.id, required this.name});

  static CommunityModel fromJson(dynamic json) {
    return CommunityModel(
        id: json['communityId'].toString(), name: json['communityName']);
  }
}
