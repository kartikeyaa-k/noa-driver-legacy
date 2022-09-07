import 'customer_view_model.dart';

class PreviousOrderResponseData {
  final int? invoiceId;
  final int? driverId;
  final String? refNumber;
  final dynamic productName;
  final String? productImage;
  final int? driverShipmentId;
  final double? totalAmount;
  final String? invoiceDate;
  final dynamic deliveryDate;
  final int? invoiceStatusId;
  final String? invoiceStatusName;
  final int? paymentStatus;
  final int? customerId;
  final int? storeId;
  final CustomerViewModel? customerViewModel;

  PreviousOrderResponseData({
    this.invoiceId,
    this.driverId,
    this.refNumber,
    this.productName,
    this.productImage,
    this.driverShipmentId,
    this.totalAmount,
    this.invoiceDate,
    this.deliveryDate,
    this.invoiceStatusId,
    this.invoiceStatusName,
    this.paymentStatus,
    this.customerId,
    this.storeId,
    this.customerViewModel,
  });

  PreviousOrderResponseData.fromJson(Map<String, dynamic> json)
      : invoiceId = json['invoiceId'] as int?,
        driverId = json['driverId'] as int?,
        refNumber = json['refNumber'] as String?,
        productName = json['productName'],
        productImage = json['productImage'] as String?,
        driverShipmentId = json['driverShipmentId'] as int?,
        totalAmount = json['totalAmount'] as double?,
        invoiceDate = json['invoiceDate'] as String?,
        deliveryDate = json['deliveryDate'],
        invoiceStatusId = json['invoiceStatusId'] as int?,
        invoiceStatusName = json['invoiceStatusName'] as String?,
        paymentStatus = json['paymentStatus'] as int?,
        customerId = json['customerId'] as int?,
        storeId = json['storeId'] as int?,
        customerViewModel = (json['customerViewModel'] as Map<String,dynamic>?) != null ? CustomerViewModel.fromJson(json['customerViewModel'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'invoiceId' : invoiceId,
    'driverId' : driverId,
    'refNumber' : refNumber,
    'productName' : productName,
    'productImage' : productImage,
    'driverShipmentId' : driverShipmentId,
    'totalAmount' : totalAmount,
    'invoiceDate' : invoiceDate,
    'deliveryDate' : deliveryDate,
    'invoiceStatusId' : invoiceStatusId,
    'invoiceStatusName' : invoiceStatusName,
    'paymentStatus' : paymentStatus,
    'customerId' : customerId,
    'storeId' : storeId,
    'customerViewModel' : customerViewModel?.toJson()
  };
}

/*
class CustomerViewModel {
  final int? customerId;
  final String? userName;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? email2;
  final String? phoneNo;
  final String? phoneNo2;
  final String? phoneNo3;
  final int? gender;
  final dynamic dateOfBirth;
  final dynamic points;
  final dynamic pointInValue;
  final dynamic ratings;
  final dynamic totalOrders;
  final dynamic isBlacklisted;
  final dynamic isCorporate;
  final dynamic isNewsletterSub;
  final dynamic isReviewEnable;
  final dynamic isUpdatePassword;
  final dynamic isUpdateAddress;
  final dynamic age;
  final dynamic kids;
  final dynamic pet;
  final String? password;
  final String? accountType;
  final dynamic customerTypeId;
  final String? token;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic isDeleted;
  final int? customerGroupId;
  final String? taxorVatNumber;
  final int? totalOrder;
  final dynamic walletBalance;
  final int? totalRecords;
  final String? image;
  final int? otp;
  final dynamic otpDateTime;
  final dynamic thirdPartyKey;
  final dynamic latitued;
  final dynamic longitued;
  final dynamic sessionId;
  final CustomerGroupViewModel? customerGroupViewModel;
  final List<CustomerAddressViewModels>? customerAddressViewModels;
  final CustomerAddressViewModel? customerAddressViewModel;
  final List<dynamic>? walletTransactionViewModels;
  final dynamic invoiceMasterViewModel;
  final List<dynamic>? invoiceMasterViewModels;
  final dynamic cartResponseModels;
  final String? firstLastName;

  CustomerViewModel({
    this.customerId,
    this.userName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.email2,
    this.phoneNo,
    this.phoneNo2,
    this.phoneNo3,
    this.gender,
    this.dateOfBirth,
    this.points,
    this.pointInValue,
    this.ratings,
    this.totalOrders,
    this.isBlacklisted,
    this.isCorporate,
    this.isNewsletterSub,
    this.isReviewEnable,
    this.isUpdatePassword,
    this.isUpdateAddress,
    this.age,
    this.kids,
    this.pet,
    this.password,
    this.accountType,
    this.customerTypeId,
    this.token,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.customerGroupId,
    this.taxorVatNumber,
    this.totalOrder,
    this.walletBalance,
    this.totalRecords,
    this.image,
    this.otp,
    this.otpDateTime,
    this.thirdPartyKey,
    this.latitued,
    this.longitued,
    this.sessionId,
    this.customerGroupViewModel,
    this.customerAddressViewModels,
    this.customerAddressViewModel,
    this.walletTransactionViewModels,
    this.invoiceMasterViewModel,
    this.invoiceMasterViewModels,
    this.cartResponseModels,
    this.firstLastName,
  });

  CustomerViewModel.fromJson(Map<String, dynamic> json)
      : customerId = json['customerId'] as int?,
        userName = json['userName'] as String?,
        firstName = json['firstName'] as String?,
        middleName = json['middleName'] as String?,
        lastName = json['lastName'] as String?,
        email = json['email'] as String?,
        email2 = json['email2'] as String?,
        phoneNo = json['phoneNo'] as String?,
        phoneNo2 = json['phoneNo2'] as String?,
        phoneNo3 = json['phoneNo3'] as String?,
        gender = json['gender'] as int?,
        dateOfBirth = json['dateOfBirth'],
        points = json['points'],
        pointInValue = json['pointInValue'],
        ratings = json['ratings'],
        totalOrders = json['totalOrders'],
        isBlacklisted = json['isBlacklisted'],
        isCorporate = json['isCorporate'],
        isNewsletterSub = json['isNewsletterSub'],
        isReviewEnable = json['isReviewEnable'],
        isUpdatePassword = json['isUpdatePassword'],
        isUpdateAddress = json['isUpdateAddress'],
        age = json['age'],
        kids = json['kids'],
        pet = json['pet'],
        password = json['password'] as String?,
        accountType = json['accountType'] as String?,
        customerTypeId = json['customerTypeId'],
        token = json['token'] as String?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        isDeleted = json['isDeleted'],
        customerGroupId = json['customerGroupId'] as int?,
        taxorVatNumber = json['taxorVatNumber'] as String?,
        totalOrder = json['totalOrder'] as int?,
        walletBalance = json['walletBalance'],
        totalRecords = json['totalRecords'] as int?,
        image = json['image'] as String?,
        otp = json['otp'] as int?,
        otpDateTime = json['otpDateTime'],
        thirdPartyKey = json['thirdPartyKey'],
        latitued = json['latitued'],
        longitued = json['longitued'],
        sessionId = json['sessionId'],
        customerGroupViewModel = (json['customerGroupViewModel'] as Map<String,dynamic>?) != null ? CustomerGroupViewModel.fromJson(json['customerGroupViewModel'] as Map<String,dynamic>) : null,
        customerAddressViewModels = (json['customerAddressViewModels'] as List?)?.map((dynamic e) => CustomerAddressViewModels.fromJson(e as Map<String,dynamic>)).toList(),
        customerAddressViewModel = (json['customerAddressViewModel'] as Map<String,dynamic>?) != null ? CustomerAddressViewModel.fromJson(json['customerAddressViewModel'] as Map<String,dynamic>) : null,
        walletTransactionViewModels = json['walletTransactionViewModels'] as List?,
        invoiceMasterViewModel = json['invoiceMasterViewModel'],
        invoiceMasterViewModels = json['invoiceMasterViewModels'] as List?,
        cartResponseModels = json['cartResponseModels'],
        firstLastName = json['firstLastName'] as String?;

  Map<String, dynamic> toJson() => {
    'customerId' : customerId,
    'userName' : userName,
    'firstName' : firstName,
    'middleName' : middleName,
    'lastName' : lastName,
    'email' : email,
    'email2' : email2,
    'phoneNo' : phoneNo,
    'phoneNo2' : phoneNo2,
    'phoneNo3' : phoneNo3,
    'gender' : gender,
    'dateOfBirth' : dateOfBirth,
    'points' : points,
    'pointInValue' : pointInValue,
    'ratings' : ratings,
    'totalOrders' : totalOrders,
    'isBlacklisted' : isBlacklisted,
    'isCorporate' : isCorporate,
    'isNewsletterSub' : isNewsletterSub,
    'isReviewEnable' : isReviewEnable,
    'isUpdatePassword' : isUpdatePassword,
    'isUpdateAddress' : isUpdateAddress,
    'age' : age,
    'kids' : kids,
    'pet' : pet,
    'password' : password,
    'accountType' : accountType,
    'customerTypeId' : customerTypeId,
    'token' : token,
    'status' : status,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'isDeleted' : isDeleted,
    'customerGroupId' : customerGroupId,
    'taxorVatNumber' : taxorVatNumber,
    'totalOrder' : totalOrder,
    'walletBalance' : walletBalance,
    'totalRecords' : totalRecords,
    'image' : image,
    'otp' : otp,
    'otpDateTime' : otpDateTime,
    'thirdPartyKey' : thirdPartyKey,
    'latitued' : latitued,
    'longitued' : longitued,
    'sessionId' : sessionId,
    'customerGroupViewModel' : customerGroupViewModel?.toJson(),
    'customerAddressViewModels' : customerAddressViewModels?.map((e) => e.toJson()).toList(),
    'customerAddressViewModel' : customerAddressViewModel?.toJson(),
    'walletTransactionViewModels' : walletTransactionViewModels,
    'invoiceMasterViewModel' : invoiceMasterViewModel,
    'invoiceMasterViewModels' : invoiceMasterViewModels,
    'cartResponseModels' : cartResponseModels,
    'firstLastName' : firstLastName
  };
}

class CustomerGroupViewModel {
  final int? customerGroupId;
  final String? groupName;
  final dynamic taxClass;
  final dynamic isDeleted;
  final String? createdAt;
  final dynamic updatedAt;

  CustomerGroupViewModel({
    this.customerGroupId,
    this.groupName,
    this.taxClass,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  CustomerGroupViewModel.fromJson(Map<String, dynamic> json)
      : customerGroupId = json['customerGroupId'] as int?,
        groupName = json['groupName'] as String?,
        taxClass = json['taxClass'],
        isDeleted = json['isDeleted'],
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
    'customerGroupId' : customerGroupId,
    'groupName' : groupName,
    'taxClass' : taxClass,
    'isDeleted' : isDeleted,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}

class CustomerAddressViewModels {
  final int? customerAddressId;
  final int? customerId;
  final String? addressType;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final String? address;
  final dynamic buildingName;
  final dynamic flatNo;
  final double? latitude;
  final double? longitude;
  final dynamic nearByLocation;
  final bool? isDefault;
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

  CustomerAddressViewModels({
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

  CustomerAddressViewModels.fromJson(Map<String, dynamic> json)
      : customerAddressId = json['customerAddressId'] as int?,
        customerId = json['customerId'] as int?,
        addressType = json['addressType'] as String?,
        countryId = json['countryId'] as int?,
        stateId = json['stateId'] as int?,
        cityId = json['cityId'] as int?,
        address = json['address'] as String?,
        buildingName = json['buildingName'],
        flatNo = json['flatNo'],
        latitude = json['latitude'] as double?,
        longitude = json['longitude'] as double?,
        nearByLocation = json['nearByLocation'],
        isDefault = json['isDefault'] as bool?,
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
}*/
