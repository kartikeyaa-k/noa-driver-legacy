class DriverProfile {
  final int? driverId;
  final int? supplierId;
  final String? name;
  final String? phoneNo;
  final String? phoneNo1;
  final String? phoneNo3;
  final String? email;
  final String? address;
  final String? licenceNo;
  final String? licenceExpireDate;
  final int? licenceCountryId;
  final String? vehicleNo;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final String? username;
  final double? commission;

  DriverProfile({
    this.driverId,
    this.supplierId,
    this.name,
    this.phoneNo,
    this.phoneNo1,
    this.phoneNo3,
    this.email,
    this.address,
    this.licenceNo,
    this.licenceExpireDate,
    this.licenceCountryId,
    this.vehicleNo,
    this.countryId,
    this.stateId,
    this.cityId,
    this.username,
    this.commission,
  });

  DriverProfile.fromJson(Map<String, dynamic> json)
      : driverId = json['driverId'] as int?,
        supplierId = json['supplierId'] as int?,
        name = json['name'] as String?,
        phoneNo = json['phoneNo'] as String?,
        phoneNo1 = json['phoneNo1'] as String?,
        phoneNo3 = json['phoneNo3'] as String?,
        email = json['email'] as String?,
        address = json['address'] as String?,
        licenceNo = json['licenceNo'] as String?,
        licenceExpireDate = json['licenceExpireDate'] as String?,
        licenceCountryId = json['licenceCountryId'] as int?,
        vehicleNo = json['vehicleNo'] as String?,
        countryId = json['countryId'] as int?,
        stateId = json['stateId'] as int?,
        cityId = json['cityId'] as int?,
        username = json['username'] as String?,
        commission = json['commission'] as double?;

  Map<String, dynamic> toJson() => {
    'driverId' : driverId,
    'supplierId' : supplierId,
    'name' : name,
    'phoneNo' : phoneNo,
    'phoneNo1' : phoneNo1,
    'phoneNo3' : phoneNo3,
    'email' : email,
    'address' : address,
    'licenceNo' : licenceNo,
    'licenceExpireDate' : licenceExpireDate,
    'licenceCountryId' : licenceCountryId,
    'vehicleNo' : vehicleNo,
    'countryId' : countryId,
    'stateId' : stateId,
    'cityId' : cityId,
    'username' : username,
    'commission' : commission
  };
}