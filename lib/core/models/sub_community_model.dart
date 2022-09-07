class SubCommunityModel {
  String id;
  String name;
  String communityId;

  SubCommunityModel(
      {required this.id, required this.name, required this.communityId});

  static SubCommunityModel fromJson(Map<String, dynamic> json) {
    return SubCommunityModel(
      id: json['subCommunityId'].toString(),
      name: json['subCommunityName'],
      communityId: json['communityId'].toString(),
    );
  }
}
