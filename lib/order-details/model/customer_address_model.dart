class CustomerAddressViewModel {
  final int? customerAddressId;
  final int? customerId;
  final dynamic addressType;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final dynamic address;
  final dynamic buildingName;
  final dynamic flatNo;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic nearByLocation;
  final dynamic isDefault;
  final dynamic status;
  final String? createdAt;
  final dynamic updatedAt;
  final dynamic countryName;
  final dynamic stateName;
  final dynamic cityName;
  final dynamic addressLine2;
  final dynamic zipCode;
  final dynamic phoneNumber;
  final dynamic customerViewModel;

  CustomerAddressViewModel({
    this.customerAddressId,
    this.customerId,
    this.addressType,
    this.countryId,
    this.stateId,
    this.cityId,
    this.address,
    this.buildingName,
    this.flatNo,
    this.latitude,
    this.longitude,
    this.nearByLocation,
    this.isDefault,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.countryName,
    this.stateName,
    this.cityName,
    this.addressLine2,
    this.zipCode,
    this.phoneNumber,
    this.customerViewModel,
  });

  CustomerAddressViewModel.fromJson(Map<String, dynamic> json)
      : customerAddressId = json['customerAddressId'] as int?,
        customerId = json['customerId'] as int?,
        addressType = json['addressType'],
        countryId = json['countryId'] as int?,
        stateId = json['stateId'] as int?,
        cityId = json['cityId'] as int?,
        address = json['address'],
        buildingName = json['buildingName'],
        flatNo = json['flatNo'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        nearByLocation = json['nearByLocation'],
        isDefault = json['isDefault'],
        status = json['status'],
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'],
        countryName = json['countryName'],
        stateName = json['stateName'],
        cityName = json['cityName'],
        addressLine2 = json['addressLine2'],
        zipCode = json['zipCode'],
        phoneNumber = json['phoneNumber'],
        customerViewModel = json['customerViewModel'];

  Map<String, dynamic> toJson() => {
    'customerAddressId' : customerAddressId,
    'customerId' : customerId,
    'addressType' : addressType,
    'countryId' : countryId,
    'stateId' : stateId,
    'cityId' : cityId,
    'address' : address,
    'buildingName' : buildingName,
    'flatNo' : flatNo,
    'latitude' : latitude,
    'longitude' : longitude,
    'nearByLocation' : nearByLocation,
    'isDefault' : isDefault,
    'status' : status,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'countryName' : countryName,
    'stateName' : stateName,
    'cityName' : cityName,
    'addressLine2' : addressLine2,
    'zipCode' : zipCode,
    'phoneNumber' : phoneNumber,
    'customerViewModel' : customerViewModel
  };
}