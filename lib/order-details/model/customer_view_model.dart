import 'customer_address_model.dart';
import 'customer_address_viewmodels.dart';
import 'customer_group_view_model.dart';

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