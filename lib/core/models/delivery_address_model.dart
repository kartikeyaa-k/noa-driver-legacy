class DeliveryAddressModel {
  String id;
  String villaNumber;
  String? streetName;
  String communityName;
  String subCommunityName;
  String communityId;
  String subCommunityId;
  String? lat;
  String? long;

  DeliveryAddressModel(
      {required this.id,
      required this.villaNumber,
      this.streetName,
      required this.communityId,
      required this.subCommunityId,
      required this.communityName,
      required this.subCommunityName,
      this.lat,
      this.long});
}
