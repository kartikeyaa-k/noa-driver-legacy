class OrderDetails {
  int? invoiceMasterId;
  int? customerId;
  String? refNumber;
  String? invoiceDate;
  double? totalAmount;
  double? receivedAmt;
  double? courierCharge;
  double? carryingCost;
  int? paymentMethod;
  String? remark;
  String? discountCode;
  double? discountValue;
  int? paymentStatus;
  String? status;
  String? currency;
  String? createdAt;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic driverId;
  int? totalRecords;
  BillingAddressViewModels? billingAddressViewModels;
  ShippingAddressViewModels? shippingAddressViewModels;
  List<InvoiceViewModels>? invoiceViewModels;
  List<StatusLogViewModels>? statusLogViewModels;
  List<PaymentViewModels>? paymentViewModels;
  CustomerViewModel? customerViewModel;
  List<InvoiceDetailsViewModels>? invoiceDetailsViewModels;
  CountryViewModel? countryViewModel;
  StateViewModel? stateViewModel;
  CityViewModel? cityViewModel;
  CompanyProfileViewModel? companyProfileViewModel;
  List<dynamic>? invoiceInputFieldValueViewModel;
  List<CustomInputDataRequestModels>? customInputDataRequestModels;

  OrderDetails({
    this.invoiceMasterId,
    this.customerId,
    this.refNumber,
    this.invoiceDate,
    this.totalAmount,
    this.receivedAmt,
    this.courierCharge,
    this.carryingCost,
    this.paymentMethod,
    this.remark,
    this.discountCode,
    this.discountValue,
    this.paymentStatus,
    this.status,
    this.currency,
    this.createdAt,
    this.countryId,
    this.stateId,
    this.cityId,
    this.driverId,
    this.totalRecords,
    this.billingAddressViewModels,
    this.shippingAddressViewModels,
    this.invoiceViewModels,
    this.statusLogViewModels,
    this.paymentViewModels,
    this.customerViewModel,
    this.invoiceDetailsViewModels,
    this.countryViewModel,
    this.stateViewModel,
    this.cityViewModel,
    this.companyProfileViewModel,
    this.invoiceInputFieldValueViewModel,
    this.customInputDataRequestModels,
  });

  OrderDetails.fromJson(Map<String, dynamic> json)
      : invoiceMasterId = json['invoiceMasterId'] as int?,
        customerId = json['customerId'] as int?,
        refNumber = json['refNumber'] as String?,
        invoiceDate = json['invoiceDate'] as String?,
        totalAmount = json['totalAmount'] as double?,
        receivedAmt = json['receivedAmt'] as double?,
        courierCharge = json['courierCharge'] as double?,
        carryingCost = json['carryingCost'] as double?,
        paymentMethod = json['paymentMethod'] as int?,
        remark = json['remark'] as String?,
        discountCode = json['discountCode'] as String?,
        discountValue = json['discountValue'] as double?,
        paymentStatus = json['paymentStatus'] as int?,
        status = json['status'] as String?,
        currency = json['currency'] as String?,
        createdAt = json['createdAt'] as String?,
        countryId = json['countryId'],
        stateId = json['stateId'],
        cityId = json['cityId'],
        driverId = json['driverId'],
        totalRecords = json['totalRecords'] as int?,
        billingAddressViewModels =
            (json['billingAddressViewModels'] as Map<String, dynamic>?) != null
                ? BillingAddressViewModels.fromJson(
                    json['billingAddressViewModels'] as Map<String, dynamic>)
                : null,
        shippingAddressViewModels =
            (json['shippingAddressViewModels'] as Map<String, dynamic>?) != null
                ? ShippingAddressViewModels.fromJson(
                    json['shippingAddressViewModels'] as Map<String, dynamic>)
                : null,
        invoiceViewModels = (json['invoiceViewModels'] as List?)
            ?.map((dynamic e) =>
                InvoiceViewModels.fromJson(e as Map<String, dynamic>))
            .toList(),
        statusLogViewModels = (json['statusLogViewModels'] as List?)
            ?.map((dynamic e) =>
                StatusLogViewModels.fromJson(e as Map<String, dynamic>))
            .toList(),
        paymentViewModels = (json['paymentViewModels'] as List?)
            ?.map((dynamic e) =>
                PaymentViewModels.fromJson(e as Map<String, dynamic>))
            .toList(),
        customerViewModel =
            (json['customerViewModel'] as Map<String, dynamic>?) != null
                ? CustomerViewModel.fromJson(
                    json['customerViewModel'] as Map<String, dynamic>)
                : null,
        invoiceDetailsViewModels = (json['invoiceDetailsViewModels'] as List?)
            ?.map((dynamic e) =>
                InvoiceDetailsViewModels.fromJson(e as Map<String, dynamic>))
            .toList(),
        countryViewModel =
            (json['countryViewModel'] as Map<String, dynamic>?) != null
                ? CountryViewModel.fromJson(
                    json['countryViewModel'] as Map<String, dynamic>)
                : null,
        stateViewModel =
            (json['stateViewModel'] as Map<String, dynamic>?) != null
                ? StateViewModel.fromJson(
                    json['stateViewModel'] as Map<String, dynamic>)
                : null,
        cityViewModel = (json['cityViewModel'] as Map<String, dynamic>?) != null
            ? CityViewModel.fromJson(
                json['cityViewModel'] as Map<String, dynamic>)
            : null,
        companyProfileViewModel =
            (json['companyProfileViewModel'] as Map<String, dynamic>?) != null
                ? CompanyProfileViewModel.fromJson(
                    json['companyProfileViewModel'] as Map<String, dynamic>)
                : null,
        invoiceInputFieldValueViewModel =
            json['invoiceInputFieldValueViewModel'] as List?,
        customInputDataRequestModels =
            (json['customInputDataRequestModels'] as List?)
                ?.map((dynamic e) => CustomInputDataRequestModels.fromJson(
                    e as Map<String, dynamic>))
                .toList();

  Map<String, dynamic> toJson() => {
        'invoiceMasterId': invoiceMasterId,
        'customerId': customerId,
        'refNumber': refNumber,
        'invoiceDate': invoiceDate,
        'totalAmount': totalAmount,
        'receivedAmt': receivedAmt,
        'courierCharge': courierCharge,
        'carryingCost': carryingCost,
        'paymentMethod': paymentMethod,
        'remark': remark,
        'discountCode': discountCode,
        'discountValue': discountValue,
        'paymentStatus': paymentStatus,
        'status': status,
        'currency': currency,
        'createdAt': createdAt,
        'countryId': countryId,
        'stateId': stateId,
        'cityId': cityId,
        'driverId': driverId,
        'totalRecords': totalRecords,
        'billingAddressViewModels': billingAddressViewModels?.toJson(),
        'shippingAddressViewModels': shippingAddressViewModels?.toJson(),
        'invoiceViewModels': invoiceViewModels?.map((e) => e.toJson()).toList(),
        'statusLogViewModels':
            statusLogViewModels?.map((e) => e.toJson()).toList(),
        'paymentViewModels': paymentViewModels?.map((e) => e.toJson()).toList(),
        'customerViewModel': customerViewModel?.toJson(),
        'invoiceDetailsViewModels':
            invoiceDetailsViewModels?.map((e) => e.toJson()).toList(),
        'countryViewModel': countryViewModel?.toJson(),
        'stateViewModel': stateViewModel?.toJson(),
        'cityViewModel': cityViewModel?.toJson(),
        'companyProfileViewModel': companyProfileViewModel?.toJson(),
        'invoiceInputFieldValueViewModel': invoiceInputFieldValueViewModel,
        'customInputDataRequestModels': customInputDataRequestModels
      };
}

class BillingAddressViewModels {
  int? billingShippingAddressId;
  dynamic invoiceMasterId;
  dynamic customerId;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic name;
  dynamic stateName;
  dynamic cityName;
  dynamic countryName;
  dynamic addressLine;
  dynamic addressLine2;
  dynamic zipCode;
  dynamic phoneNumber;
  dynamic landMark;
  dynamic deleveryNote;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isDefault;
  dynamic latitued;
  dynamic longitued;
  dynamic deleveryTime;
  dynamic isBilingAddress;
  dynamic isShippingAddress;

  BillingAddressViewModels({
    this.billingShippingAddressId,
    this.invoiceMasterId,
    this.customerId,
    this.countryId,
    this.stateId,
    this.cityId,
    this.name,
    this.stateName,
    this.cityName,
    this.countryName,
    this.addressLine,
    this.addressLine2,
    this.zipCode,
    this.phoneNumber,
    this.landMark,
    this.deleveryNote,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
    this.latitued,
    this.longitued,
    this.deleveryTime,
    this.isBilingAddress,
    this.isShippingAddress,
  });

  BillingAddressViewModels.fromJson(Map<String, dynamic> json)
      : billingShippingAddressId = json['billingShippingAddressId'] as int?,
        invoiceMasterId = json['invoiceMasterId'],
        customerId = json['customerId'],
        countryId = json['countryId'],
        stateId = json['stateId'],
        cityId = json['cityId'],
        name = json['name'],
        stateName = json['stateName'],
        cityName = json['cityName'],
        countryName = json['countryName'],
        addressLine = json['addressLine'],
        addressLine2 = json['addressLine2'],
        zipCode = json['zipCode'],
        phoneNumber = json['phoneNumber'],
        landMark = json['landMark'],
        deleveryNote = json['deleveryNote'],
        status = json['status'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        isDefault = json['isDefault'],
        latitued = json['latitued'],
        longitued = json['longitued'],
        deleveryTime = json['deleveryTime'],
        isBilingAddress = json['isBilingAddress'],
        isShippingAddress = json['isShippingAddress'];

  Map<String, dynamic> toJson() => {
        'billingShippingAddressId': billingShippingAddressId,
        'invoiceMasterId': invoiceMasterId,
        'customerId': customerId,
        'countryId': countryId,
        'stateId': stateId,
        'cityId': cityId,
        'name': name,
        'stateName': stateName,
        'cityName': cityName,
        'countryName': countryName,
        'addressLine': addressLine,
        'addressLine2': addressLine2,
        'zipCode': zipCode,
        'phoneNumber': phoneNumber,
        'landMark': landMark,
        'deleveryNote': deleveryNote,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'isDefault': isDefault,
        'latitued': latitued,
        'longitued': longitued,
        'deleveryTime': deleveryTime,
        'isBilingAddress': isBilingAddress,
        'isShippingAddress': isShippingAddress
      };
}

class ShippingAddressViewModels {
  int? billingShippingAddressId;
  dynamic invoiceMasterId;
  dynamic customerId;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic name;
  dynamic stateName;
  dynamic cityName;
  dynamic countryName;
  dynamic addressLine;
  dynamic addressLine2;
  dynamic zipCode;
  dynamic phoneNumber;
  dynamic landMark;
  dynamic deleveryNote;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isDefault;
  dynamic latitued;
  dynamic longitued;
  dynamic deleveryTime;
  dynamic isBilingAddress;
  dynamic isShippingAddress;

  ShippingAddressViewModels({
    this.billingShippingAddressId,
    this.invoiceMasterId,
    this.customerId,
    this.countryId,
    this.stateId,
    this.cityId,
    this.name,
    this.stateName,
    this.cityName,
    this.countryName,
    this.addressLine,
    this.addressLine2,
    this.zipCode,
    this.phoneNumber,
    this.landMark,
    this.deleveryNote,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
    this.latitued,
    this.longitued,
    this.deleveryTime,
    this.isBilingAddress,
    this.isShippingAddress,
  });

  ShippingAddressViewModels.fromJson(Map<String, dynamic> json)
      : billingShippingAddressId = json['billingShippingAddressId'] as int?,
        invoiceMasterId = json['invoiceMasterId'],
        customerId = json['customerId'],
        countryId = json['countryId'],
        stateId = json['stateId'],
        cityId = json['cityId'],
        name = json['name'],
        stateName = json['stateName'],
        cityName = json['cityName'],
        countryName = json['countryName'],
        addressLine = json['addressLine'],
        addressLine2 = json['addressLine2'],
        zipCode = json['zipCode'],
        phoneNumber = json['phoneNumber'],
        landMark = json['landMark'],
        deleveryNote = json['deleveryNote'],
        status = json['status'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        isDefault = json['isDefault'],
        latitued = json['latitued'],
        longitued = json['longitued'],
        deleveryTime = json['deleveryTime'],
        isBilingAddress = json['isBilingAddress'],
        isShippingAddress = json['isShippingAddress'];

  Map<String, dynamic> toJson() => {
        'billingShippingAddressId': billingShippingAddressId,
        'invoiceMasterId': invoiceMasterId,
        'customerId': customerId,
        'countryId': countryId,
        'stateId': stateId,
        'cityId': cityId,
        'name': name,
        'stateName': stateName,
        'cityName': cityName,
        'countryName': countryName,
        'addressLine': addressLine,
        'addressLine2': addressLine2,
        'zipCode': zipCode,
        'phoneNumber': phoneNumber,
        'landMark': landMark,
        'deleveryNote': deleveryNote,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'isDefault': isDefault,
        'latitued': latitued,
        'longitued': longitued,
        'deleveryTime': deleveryTime,
        'isBilingAddress': isBilingAddress,
        'isShippingAddress': isShippingAddress
      };
}

class InvoiceViewModels {
  int? invoiceId;
  int? invoiceMasterId;
  String? refNumber;
  String? invoiceDate;
  double? totalAmount;
  double? receivedAmt;
  double? carryingCost;
  double? courierCharge;
  int? paymentMethod;
  int? paymentStatus;
  dynamic supplierId;
  String? remark;
  String? discountCode;
  double? discountValue;
  int? storeId;
  String? status;
  String? createdAt;
  int? invoiceStatusId;
  double? amountToSupplier;
  double? amountToAdmin;
  int? supplierCommissionId;
  dynamic methodName;
  dynamic isService;
  dynamic serviceDate;
  int? totalProduct;
  String? supplierName;
  String? supplierMobile;
  String? supplierEmail;
  StoreViewModel? storeViewModel;
  InvoiceStatusViewModel? invoiceStatusViewModel;

  InvoiceViewModels({
    this.invoiceId,
    this.invoiceMasterId,
    this.refNumber,
    this.invoiceDate,
    this.totalAmount,
    this.receivedAmt,
    this.carryingCost,
    this.courierCharge,
    this.paymentMethod,
    this.paymentStatus,
    this.supplierId,
    this.remark,
    this.discountCode,
    this.discountValue,
    this.storeId,
    this.status,
    this.createdAt,
    this.invoiceStatusId,
    this.amountToSupplier,
    this.amountToAdmin,
    this.supplierCommissionId,
    this.methodName,
    this.isService,
    this.serviceDate,
    this.totalProduct,
    this.supplierName,
    this.supplierMobile,
    this.supplierEmail,
    this.storeViewModel,
    this.invoiceStatusViewModel,
  });

  InvoiceViewModels.fromJson(Map<String, dynamic> json)
      : invoiceId = json['invoiceId'] as int?,
        invoiceMasterId = json['invoiceMasterId'] as int?,
        refNumber = json['refNumber'] as String?,
        invoiceDate = json['invoiceDate'] as String?,
        totalAmount = json['totalAmount'] as double?,
        receivedAmt = json['receivedAmt'] as double?,
        carryingCost = json['carryingCost'] as double?,
        courierCharge = json['courierCharge'] as double?,
        paymentMethod = json['paymentMethod'] as int?,
        paymentStatus = json['paymentStatus'] as int?,
        supplierId = json['supplierId'],
        remark = json['remark'] as String?,
        discountCode = json['discountCode'] as String?,
        discountValue = json['discountValue'] as double?,
        storeId = json['storeId'] as int?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        invoiceStatusId = json['invoiceStatusId'] as int?,
        amountToSupplier = json['amountToSupplier'] as double?,
        amountToAdmin = json['amountToAdmin'] as double?,
        supplierCommissionId = json['supplierCommissionId'] as int?,
        methodName = json['methodName'],
        isService = json['isService'],
        serviceDate = json['serviceDate'],
        totalProduct = json['totalProduct'] as int?,
        supplierName = json['supplierName'] as String?,
        supplierMobile = json['supplierMobile'] as String?,
        supplierEmail = json['supplierEmail'] as String?,
        storeViewModel =
            (json['storeViewModel'] as Map<String, dynamic>?) != null
                ? StoreViewModel.fromJson(
                    json['storeViewModel'] as Map<String, dynamic>)
                : null,
        invoiceStatusViewModel =
            (json['invoiceStatusViewModel'] as Map<String, dynamic>?) != null
                ? InvoiceStatusViewModel.fromJson(
                    json['invoiceStatusViewModel'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
        'invoiceId': invoiceId,
        'invoiceMasterId': invoiceMasterId,
        'refNumber': refNumber,
        'invoiceDate': invoiceDate,
        'totalAmount': totalAmount,
        'receivedAmt': receivedAmt,
        'carryingCost': carryingCost,
        'courierCharge': courierCharge,
        'paymentMethod': paymentMethod,
        'paymentStatus': paymentStatus,
        'supplierId': supplierId,
        'remark': remark,
        'discountCode': discountCode,
        'discountValue': discountValue,
        'storeId': storeId,
        'status': status,
        'createdAt': createdAt,
        'invoiceStatusId': invoiceStatusId,
        'amountToSupplier': amountToSupplier,
        'amountToAdmin': amountToAdmin,
        'supplierCommissionId': supplierCommissionId,
        'methodName': methodName,
        'isService': isService,
        'serviceDate': serviceDate,
        'totalProduct': totalProduct,
        'supplierName': supplierName,
        'supplierMobile': supplierMobile,
        'supplierEmail': supplierEmail,
        'storeViewModel': storeViewModel?.toJson(),
        'invoiceStatusViewModel': invoiceStatusViewModel?.toJson()
      };
}

class StoreViewModel {
  int? storeId;
  dynamic supplierId;
  String? shopName;
  dynamic mobile;
  dynamic landPhone;
  dynamic email;
  dynamic address;
  dynamic largeImage;
  dynamic mediumImage;
  dynamic smallImage;
  dynamic parentId;
  int? parentStoreId;
  dynamic latitued;
  dynamic longitued;
  dynamic description;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic status;
  String? createdAt;
  dynamic updatedAt;
  dynamic guidId;
  dynamic currencyId;
  dynamic countryName;
  dynamic mapUrl;
  int? manualStoreId;
  int? manualParentStoreId;
  dynamic supplierName;
  bool? isManagedWareHouse;
  List<dynamic>? breadcrumb;
  List<dynamic>? childStores;
  List<dynamic>? storeOperationViewModels;
  dynamic storeSummaryViewModels;
  List<dynamic>? storeParentViewModels;

  StoreViewModel({
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
    this.parentStoreId,
    this.latitued,
    this.longitued,
    this.description,
    this.countryId,
    this.stateId,
    this.cityId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.guidId,
    this.currencyId,
    this.countryName,
    this.mapUrl,
    this.manualStoreId,
    this.manualParentStoreId,
    this.supplierName,
    this.isManagedWareHouse,
    this.breadcrumb,
    this.childStores,
    this.storeOperationViewModels,
    this.storeSummaryViewModels,
    this.storeParentViewModels,
  });

  StoreViewModel.fromJson(Map<String, dynamic> json)
      : storeId = json['storeId'] as int?,
        supplierId = json['supplierId'],
        shopName = json['shopName'] as String?,
        mobile = json['mobile'],
        landPhone = json['landPhone'],
        email = json['email'],
        address = json['address'],
        largeImage = json['largeImage'],
        mediumImage = json['mediumImage'],
        smallImage = json['smallImage'],
        parentId = json['parentId'],
        parentStoreId = json['parentStoreId'] as int?,
        latitued = json['latitued'],
        longitued = json['longitued'],
        description = json['description'],
        countryId = json['countryId'],
        stateId = json['stateId'],
        cityId = json['cityId'],
        status = json['status'],
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'],
        guidId = json['guidId'],
        currencyId = json['currencyId'],
        countryName = json['countryName'],
        mapUrl = json['mapUrl'],
        manualStoreId = json['manualStoreId'] as int?,
        manualParentStoreId = json['manualParentStoreId'] as int?,
        supplierName = json['supplierName'],
        isManagedWareHouse = json['isManagedWareHouse'] as bool?,
        breadcrumb = json['breadcrumb'] as List?,
        childStores = json['childStores'] as List?,
        storeOperationViewModels = json['storeOperationViewModels'] as List?,
        storeSummaryViewModels = json['storeSummaryViewModels'],
        storeParentViewModels = json['storeParentViewModels'] as List?;

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
        'parentStoreId': parentStoreId,
        'latitued': latitued,
        'longitued': longitued,
        'description': description,
        'countryId': countryId,
        'stateId': stateId,
        'cityId': cityId,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'guidId': guidId,
        'currencyId': currencyId,
        'countryName': countryName,
        'mapUrl': mapUrl,
        'manualStoreId': manualStoreId,
        'manualParentStoreId': manualParentStoreId,
        'supplierName': supplierName,
        'isManagedWareHouse': isManagedWareHouse,
        'breadcrumb': breadcrumb,
        'childStores': childStores,
        'storeOperationViewModels': storeOperationViewModels,
        'storeSummaryViewModels': storeSummaryViewModels,
        'storeParentViewModels': storeParentViewModels
      };
}

class InvoiceStatusViewModel {
  int? invoiceStatusId;
  String? name;
  bool? active;
  String? createDate;
  dynamic isPublic;
  dynamic isInternal;
  dynamic isDelete;
  int? label;
  dynamic settingName;
  int? invoiceStatusSettingId;
  dynamic isService;
  dynamic isEmail;
  dynamic isSmS;
  dynamic isPushNotification;
  dynamic isCustomer;
  dynamic isAdmin;
  dynamic smSTemplateId;
  dynamic smSTemplateTitle;
  dynamic emailTemplateId;
  dynamic emailTemplateTitle;
  dynamic pushNotificationId;
  dynamic pushNotificationTitle;

  InvoiceStatusViewModel({
    this.invoiceStatusId,
    this.name,
    this.active,
    this.createDate,
    this.isPublic,
    this.isInternal,
    this.isDelete,
    this.label,
    this.settingName,
    this.invoiceStatusSettingId,
    this.isService,
    this.isEmail,
    this.isSmS,
    this.isPushNotification,
    this.isCustomer,
    this.isAdmin,
    this.smSTemplateId,
    this.smSTemplateTitle,
    this.emailTemplateId,
    this.emailTemplateTitle,
    this.pushNotificationId,
    this.pushNotificationTitle,
  });

  InvoiceStatusViewModel.fromJson(Map<String, dynamic> json)
      : invoiceStatusId = json['invoiceStatusId'] as int?,
        name = json['name'] as String?,
        active = json['active'] as bool?,
        createDate = json['createDate'] as String?,
        isPublic = json['isPublic'],
        isInternal = json['isInternal'],
        isDelete = json['isDelete'],
        label = json['label'] as int?,
        settingName = json['settingName'],
        invoiceStatusSettingId = json['invoiceStatusSettingId'] as int?,
        isService = json['isService'],
        isEmail = json['isEmail'],
        isSmS = json['isSmS'],
        isPushNotification = json['isPushNotification'],
        isCustomer = json['isCustomer'],
        isAdmin = json['isAdmin'],
        smSTemplateId = json['smSTemplateId'],
        smSTemplateTitle = json['smSTemplateTitle'],
        emailTemplateId = json['emailTemplateId'],
        emailTemplateTitle = json['emailTemplateTitle'],
        pushNotificationId = json['pushNotificationId'],
        pushNotificationTitle = json['pushNotificationTitle'];

  Map<String, dynamic> toJson() => {
        'invoiceStatusId': invoiceStatusId,
        'name': name,
        'active': active,
        'createDate': createDate,
        'isPublic': isPublic,
        'isInternal': isInternal,
        'isDelete': isDelete,
        'label': label,
        'settingName': settingName,
        'invoiceStatusSettingId': invoiceStatusSettingId,
        'isService': isService,
        'isEmail': isEmail,
        'isSmS': isSmS,
        'isPushNotification': isPushNotification,
        'isCustomer': isCustomer,
        'isAdmin': isAdmin,
        'smSTemplateId': smSTemplateId,
        'smSTemplateTitle': smSTemplateTitle,
        'emailTemplateId': emailTemplateId,
        'emailTemplateTitle': emailTemplateTitle,
        'pushNotificationId': pushNotificationId,
        'pushNotificationTitle': pushNotificationTitle
      };
}

class StatusLogViewModels {
  int? statusLogId;
  int? invoiceId;
  int? currentInvoiceStatusId;
  int? nextInvoiceStatusId;
  String? dateTime;
  String? duration;
  dynamic note;
  dynamic createBy;
  String? currentInvoiceStatus;
  String? previousInvoiceStatus;
  dynamic durationTime;

  StatusLogViewModels({
    this.statusLogId,
    this.invoiceId,
    this.currentInvoiceStatusId,
    this.nextInvoiceStatusId,
    this.dateTime,
    this.duration,
    this.note,
    this.createBy,
    this.currentInvoiceStatus,
    this.previousInvoiceStatus,
    this.durationTime,
  });

  StatusLogViewModels.fromJson(Map<String, dynamic> json)
      : statusLogId = json['statusLogId'] as int?,
        invoiceId = json['invoiceId'] as int?,
        currentInvoiceStatusId = json['currentInvoiceStatusId'] as int?,
        nextInvoiceStatusId = json['nextInvoiceStatusId'] as int?,
        dateTime = json['dateTime'] as String?,
        duration = json['duration'] as String?,
        note = json['note'],
        createBy = json['createBy'],
        currentInvoiceStatus = json['currentInvoiceStatus'] as String?,
        previousInvoiceStatus = json['previousInvoiceStatus'] as String?,
        durationTime = json['durationTime'];

  Map<String, dynamic> toJson() => {
        'statusLogId': statusLogId,
        'invoiceId': invoiceId,
        'currentInvoiceStatusId': currentInvoiceStatusId,
        'nextInvoiceStatusId': nextInvoiceStatusId,
        'dateTime': dateTime,
        'duration': duration,
        'note': note,
        'createBy': createBy,
        'currentInvoiceStatus': currentInvoiceStatus,
        'previousInvoiceStatus': previousInvoiceStatus,
        'durationTime': durationTime
      };
}

class PaymentViewModels {
  int? paymentId;
  int? invoiceMasterId;
  int? currencyId;
  double? amount;
  double? courierCharge;
  double? discountAmount;
  double? carryingCost;
  int? paymentMethod;
  dynamic courierAgencyId;
  String? payDate;
  String? note;
  String? transactionNo;
  String? status;
  String? createdAt;
  int? couponId;
  dynamic currencyName;
  dynamic symbol;
  String? methodName;
  String? statusName;
  CurrencyViewModel? currencyViewModel;

  PaymentViewModels({
    this.paymentId,
    this.invoiceMasterId,
    this.currencyId,
    this.amount,
    this.courierCharge,
    this.discountAmount,
    this.carryingCost,
    this.paymentMethod,
    this.courierAgencyId,
    this.payDate,
    this.note,
    this.transactionNo,
    this.status,
    this.createdAt,
    this.couponId,
    this.currencyName,
    this.symbol,
    this.methodName,
    this.statusName,
    this.currencyViewModel,
  });

  PaymentViewModels.fromJson(Map<String, dynamic> json)
      : paymentId = json['paymentId'] as int?,
        invoiceMasterId = json['invoiceMasterId'] as int?,
        currencyId = json['currencyId'] as int?,
        amount = json['amount'] as double?,
        courierCharge = json['courierCharge'] as double?,
        discountAmount = json['discountAmount'] as double?,
        carryingCost = json['carryingCost'] as double?,
        paymentMethod = json['paymentMethod'] as int?,
        courierAgencyId = json['courierAgencyId'],
        payDate = json['payDate'] as String?,
        note = json['note'] as String?,
        transactionNo = json['transactionNo'] as String?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        couponId = json['couponId'] as int?,
        currencyName = json['currencyName'],
        symbol = json['symbol'],
        methodName = json['methodName'] as String?,
        statusName = json['statusName'] as String?,
        currencyViewModel =
            (json['currencyViewModel'] as Map<String, dynamic>?) != null
                ? CurrencyViewModel.fromJson(
                    json['currencyViewModel'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
        'paymentId': paymentId,
        'invoiceMasterId': invoiceMasterId,
        'currencyId': currencyId,
        'amount': amount,
        'courierCharge': courierCharge,
        'discountAmount': discountAmount,
        'carryingCost': carryingCost,
        'paymentMethod': paymentMethod,
        'courierAgencyId': courierAgencyId,
        'payDate': payDate,
        'note': note,
        'transactionNo': transactionNo,
        'status': status,
        'createdAt': createdAt,
        'couponId': couponId,
        'currencyName': currencyName,
        'symbol': symbol,
        'methodName': methodName,
        'statusName': statusName,
        'currencyViewModel': currencyViewModel?.toJson()
      };
}

class CurrencyViewModel {
  int? currencyId;
  dynamic name;
  String? code;
  String? symbol;
  dynamic isDelete;
  dynamic isBaseCurrency;
  int? convertionRate;
  dynamic convertionPrice;
  dynamic createDate;

  CurrencyViewModel({
    this.currencyId,
    this.name,
    this.code,
    this.symbol,
    this.isDelete,
    this.isBaseCurrency,
    this.convertionRate,
    this.convertionPrice,
    this.createDate,
  });

  CurrencyViewModel.fromJson(Map<String, dynamic> json)
      : currencyId = json['currencyId'] as int?,
        name = json['name'],
        code = json['code'] as String?,
        symbol = json['symbol'] as String?,
        isDelete = json['isDelete'],
        isBaseCurrency = json['isBaseCurrency'],
        convertionRate = json['convertionRate'] as int?,
        convertionPrice = json['convertionPrice'],
        createDate = json['createDate'];

  Map<String, dynamic> toJson() => {
        'currencyId': currencyId,
        'name': name,
        'code': code,
        'symbol': symbol,
        'isDelete': isDelete,
        'isBaseCurrency': isBaseCurrency,
        'convertionRate': convertionRate,
        'convertionPrice': convertionPrice,
        'createDate': createDate
      };
}

class CustomerViewModel {
  int? customerId;
  dynamic userName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  dynamic email2;
  String? phoneNo;
  dynamic phoneNo2;
  dynamic phoneNo3;
  int? gender;
  dynamic dateOfBirth;
  dynamic points;
  dynamic pointInValue;
  dynamic ratings;
  dynamic totalOrders;
  dynamic isBlacklisted;
  dynamic isCorporate;
  dynamic isNewsletterSub;
  dynamic isReviewEnable;
  dynamic isUpdatePassword;
  dynamic isUpdateAddress;
  dynamic password;
  dynamic accountType;
  dynamic customerTypeId;
  dynamic token;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isDeleted;
  int? customerGroupId;
  dynamic taxorVatNumber;
  int? totalOrder;
  dynamic walletBalance;
  int? totalRecords;
  dynamic image;
  CustomerGroupViewModel? customerGroupViewModel;
  List<dynamic>? customerAddressViewModels;
  CustomerAddressViewModel? customerAddressViewModel;
  List<dynamic>? walletTransactionViewModels;
  dynamic invoiceMasterViewModel;
  List<dynamic>? invoiceMasterViewModels;
  dynamic cartResponseModels;
  String? firstLastName;

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
        userName = json['userName'],
        firstName = json['firstName'] as String?,
        middleName = json['middleName'] as String?,
        lastName = json['lastName'] as String?,
        email = json['email'] as String?,
        email2 = json['email2'],
        phoneNo = json['phoneNo'] as String?,
        phoneNo2 = json['phoneNo2'],
        phoneNo3 = json['phoneNo3'],
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
        password = json['password'],
        accountType = json['accountType'],
        customerTypeId = json['customerTypeId'],
        token = json['token'],
        status = json['status'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        isDeleted = json['isDeleted'],
        customerGroupId = json['customerGroupId'] as int?,
        taxorVatNumber = json['taxorVatNumber'],
        totalOrder = json['totalOrder'] as int?,
        walletBalance = json['walletBalance'],
        totalRecords = json['totalRecords'] as int?,
        image = json['image'],
        customerGroupViewModel =
            (json['customerGroupViewModel'] as Map<String, dynamic>?) != null
                ? CustomerGroupViewModel.fromJson(
                    json['customerGroupViewModel'] as Map<String, dynamic>)
                : null,
        customerAddressViewModels = json['customerAddressViewModels'] as List?,
        customerAddressViewModel =
            (json['customerAddressViewModel'] as Map<String, dynamic>?) != null
                ? CustomerAddressViewModel.fromJson(
                    json['customerAddressViewModel'] as Map<String, dynamic>)
                : null,
        walletTransactionViewModels =
            json['walletTransactionViewModels'] as List?,
        invoiceMasterViewModel = json['invoiceMasterViewModel'],
        invoiceMasterViewModels = json['invoiceMasterViewModels'] as List?,
        cartResponseModels = json['cartResponseModels'],
        firstLastName = json['firstLastName'] as String?;

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'userName': userName,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'email': email,
        'email2': email2,
        'phoneNo': phoneNo,
        'phoneNo2': phoneNo2,
        'phoneNo3': phoneNo3,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'points': points,
        'pointInValue': pointInValue,
        'ratings': ratings,
        'totalOrders': totalOrders,
        'isBlacklisted': isBlacklisted,
        'isCorporate': isCorporate,
        'isNewsletterSub': isNewsletterSub,
        'isReviewEnable': isReviewEnable,
        'isUpdatePassword': isUpdatePassword,
        'isUpdateAddress': isUpdateAddress,
        'password': password,
        'accountType': accountType,
        'customerTypeId': customerTypeId,
        'token': token,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'isDeleted': isDeleted,
        'customerGroupId': customerGroupId,
        'taxorVatNumber': taxorVatNumber,
        'totalOrder': totalOrder,
        'walletBalance': walletBalance,
        'totalRecords': totalRecords,
        'image': image,
        'customerGroupViewModel': customerGroupViewModel?.toJson(),
        'customerAddressViewModels': customerAddressViewModels,
        'customerAddressViewModel': customerAddressViewModel?.toJson(),
        'walletTransactionViewModels': walletTransactionViewModels,
        'invoiceMasterViewModel': invoiceMasterViewModel,
        'invoiceMasterViewModels': invoiceMasterViewModels,
        'cartResponseModels': cartResponseModels,
        'firstLastName': firstLastName
      };
}

class CustomerGroupViewModel {
  int? customerGroupId;
  String? groupName;
  dynamic taxClass;
  dynamic isDeleted;
  String? createdAt;
  dynamic updatedAt;

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
        'customerGroupId': customerGroupId,
        'groupName': groupName,
        'taxClass': taxClass,
        'isDeleted': isDeleted,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}

class CustomerAddressViewModel {
  int? customerAddressId;
  int? customerId;
  dynamic addressType;
  int? countryId;
  int? stateId;
  int? cityId;
  dynamic address;
  dynamic buildingName;
  dynamic flatNo;
  dynamic latitude;
  dynamic longitude;
  dynamic nearByLocation;
  dynamic isDefault;
  dynamic status;
  String? createdAt;
  dynamic updatedAt;
  dynamic countryName;
  dynamic stateName;
  dynamic cityName;
  dynamic addressLine2;
  dynamic zipCode;
  dynamic phoneNumber;
  dynamic customerViewModel;

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
        'customerAddressId': customerAddressId,
        'customerId': customerId,
        'addressType': addressType,
        'countryId': countryId,
        'stateId': stateId,
        'cityId': cityId,
        'address': address,
        'buildingName': buildingName,
        'flatNo': flatNo,
        'latitude': latitude,
        'longitude': longitude,
        'nearByLocation': nearByLocation,
        'isDefault': isDefault,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'countryName': countryName,
        'stateName': stateName,
        'cityName': cityName,
        'addressLine2': addressLine2,
        'zipCode': zipCode,
        'phoneNumber': phoneNumber,
        'customerViewModel': customerViewModel
      };
}

class InvoiceDetailsViewModels {
  int? invoiceDetailsId;
  int? invoiceId;
  int? productMasterId;
  double? quantity;
  double? price;
  String? status;
  String? createdAt;
  int? productTypeId;
  dynamic storeId;
  dynamic supplierId;
  String? supplierName;
  String? supplierMobile;
  String? productName;
  dynamic invoiceMasterId;
  int? productSkuId;
  String? subSku;
  String? largeImage;
  String? mediumImage;
  dynamic smallImage;
  String? fileLocation;
  String? digitalProductGuid;
  String? digitalProductUrl;
  dynamic serviceDate;
  dynamic brandName;
  List<dynamic>? productSubSKUViewModels;

  InvoiceDetailsViewModels({
    this.invoiceDetailsId,
    this.invoiceId,
    this.productMasterId,
    this.quantity,
    this.price,
    this.status,
    this.createdAt,
    this.productTypeId,
    this.storeId,
    this.supplierId,
    this.supplierName,
    this.supplierMobile,
    this.productName,
    this.invoiceMasterId,
    this.productSkuId,
    this.subSku,
    this.largeImage,
    this.mediumImage,
    this.smallImage,
    this.fileLocation,
    this.digitalProductGuid,
    this.digitalProductUrl,
    this.serviceDate,
    this.brandName,
    this.productSubSKUViewModels,
  });

  InvoiceDetailsViewModels.fromJson(Map<String, dynamic> json)
      : invoiceDetailsId = json['invoiceDetailsId'] as int?,
        invoiceId = json['invoiceId'] as int?,
        productMasterId = json['productMasterId'] as int?,
        quantity = json['quantity'] as double?,
        price = json['price'] as double?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        productTypeId = json['productTypeId'] as int?,
        storeId = json['storeId'],
        supplierId = json['supplierId'],
        supplierName = json['supplierName'] as String?,
        supplierMobile = json['supplierMobile'] as String?,
        productName = json['productName'] as String?,
        invoiceMasterId = json['invoiceMasterId'],
        productSkuId = json['productSkuId'] as int?,
        subSku = json['subSku'] as String?,
        largeImage = json['largeImage'] as String?,
        mediumImage = json['mediumImage'] as String?,
        smallImage = json['smallImage'],
        fileLocation = (json['fileLocation'] as String).contains('noa.market')
            ? json['fileLocation'] as String
            : 'https://admin.noa.market/' + json['fileLocation'] as String,
        digitalProductGuid = json['digitalProductGuid'] as String?,
        digitalProductUrl = json['digitalProductUrl'] as String?,
        serviceDate = json['serviceDate'],
        brandName = json['brandName'],
        productSubSKUViewModels = json['productSubSKUViewModels'] as List?;

  Map<String, dynamic> toJson() => {
        'invoiceDetailsId': invoiceDetailsId,
        'invoiceId': invoiceId,
        'productMasterId': productMasterId,
        'quantity': quantity,
        'price': price,
        'status': status,
        'createdAt': createdAt,
        'productTypeId': productTypeId,
        'storeId': storeId,
        'supplierId': supplierId,
        'supplierName': supplierName,
        'supplierMobile': supplierMobile,
        'productName': productName,
        'invoiceMasterId': invoiceMasterId,
        'productSkuId': productSkuId,
        'subSku': subSku,
        'largeImage': largeImage,
        'mediumImage': mediumImage,
        'smallImage': smallImage,
        'fileLocation': fileLocation,
        'digitalProductGuid': digitalProductGuid,
        'digitalProductUrl': digitalProductUrl,
        'serviceDate': serviceDate,
        'brandName': brandName,
        'productSubSKUViewModels': productSubSKUViewModels
      };
}

class CountryViewModel {
  int? countryId;
  dynamic iso;
  String? countryName;
  dynamic longCountryName;
  dynamic iso3;
  dynamic countryCode;
  dynamic unMemberState;
  dynamic callingCode;
  dynamic ccTld;
  dynamic status;
  dynamic lastModified;
  dynamic isDeleted;
  dynamic guidId;
  dynamic manualStoreId;
  dynamic image;
  List<dynamic>? countryWiseStoreViewModels;

  CountryViewModel({
    this.countryId,
    this.iso,
    this.countryName,
    this.longCountryName,
    this.iso3,
    this.countryCode,
    this.unMemberState,
    this.callingCode,
    this.ccTld,
    this.status,
    this.lastModified,
    this.isDeleted,
    this.guidId,
    this.manualStoreId,
    this.image,
    this.countryWiseStoreViewModels,
  });

  CountryViewModel.fromJson(Map<String, dynamic> json)
      : countryId = json['countryId'] as int?,
        iso = json['iso'],
        countryName = json['countryName'] as String?,
        longCountryName = json['longCountryName'],
        iso3 = json['iso3'],
        countryCode = json['countryCode'],
        unMemberState = json['unMemberState'],
        callingCode = json['callingCode'],
        ccTld = json['ccTld'],
        status = json['status'],
        lastModified = json['lastModified'],
        isDeleted = json['isDeleted'],
        guidId = json['guidId'],
        manualStoreId = json['manualStoreId'],
        image = json['image'],
        countryWiseStoreViewModels =
            json['countryWiseStoreViewModels'] as List?;

  Map<String, dynamic> toJson() => {
        'countryId': countryId,
        'iso': iso,
        'countryName': countryName,
        'longCountryName': longCountryName,
        'iso3': iso3,
        'countryCode': countryCode,
        'unMemberState': unMemberState,
        'callingCode': callingCode,
        'ccTld': ccTld,
        'status': status,
        'lastModified': lastModified,
        'isDeleted': isDeleted,
        'guidId': guidId,
        'manualStoreId': manualStoreId,
        'image': image,
        'countryWiseStoreViewModels': countryWiseStoreViewModels
      };
}

class StateViewModel {
  int? stateId;
  int? countryId;
  dynamic countryName;
  String? stateName;
  dynamic isDeleted;
  dynamic guidId;

  StateViewModel({
    this.stateId,
    this.countryId,
    this.countryName,
    this.stateName,
    this.isDeleted,
    this.guidId,
  });

  StateViewModel.fromJson(Map<String, dynamic> json)
      : stateId = json['stateId'] as int?,
        countryId = json['countryId'] as int?,
        countryName = json['countryName'],
        stateName = json['stateName'] as String?,
        isDeleted = json['isDeleted'],
        guidId = json['guidId'];

  Map<String, dynamic> toJson() => {
        'stateId': stateId,
        'countryId': countryId,
        'countryName': countryName,
        'stateName': stateName,
        'isDeleted': isDeleted,
        'guidId': guidId
      };
}

class CityViewModel {
  int? cityId;
  int? stateId;
  String? cityName;
  dynamic status;
  dynamic lastModified;
  dynamic isDeleted;
  dynamic stateName;
  dynamic guidId;

  CityViewModel({
    this.cityId,
    this.stateId,
    this.cityName,
    this.status,
    this.lastModified,
    this.isDeleted,
    this.stateName,
    this.guidId,
  });

  CityViewModel.fromJson(Map<String, dynamic> json)
      : cityId = json['cityId'] as int?,
        stateId = json['stateId'] as int?,
        cityName = json['cityName'] as String?,
        status = json['status'],
        lastModified = json['lastModified'],
        isDeleted = json['isDeleted'],
        stateName = json['stateName'],
        guidId = json['guidId'];

  Map<String, dynamic> toJson() => {
        'cityId': cityId,
        'stateId': stateId,
        'cityName': cityName,
        'status': status,
        'lastModified': lastModified,
        'isDeleted': isDeleted,
        'stateName': stateName,
        'guidId': guidId
      };
}

class CompanyProfileViewModel {
  int? companyProfileId;
  String? companyName;
  String? vatNo;
  String? phone;
  String? email;
  String? address;
  String? logo;
  dynamic status;
  dynamic lastModified;
  dynamic isDeleted;

  CompanyProfileViewModel({
    this.companyProfileId,
    this.companyName,
    this.vatNo,
    this.phone,
    this.email,
    this.address,
    this.logo,
    this.status,
    this.lastModified,
    this.isDeleted,
  });

  CompanyProfileViewModel.fromJson(Map<String, dynamic> json)
      : companyProfileId = json['companyProfileId'] as int?,
        companyName = json['companyName'] as String?,
        vatNo = json['vatNo'] as String?,
        phone = json['phone'] as String?,
        email = json['email'] as String?,
        address = json['address'] as String?,
        logo = json['logo'] as String?,
        status = json['status'],
        lastModified = json['lastModified'],
        isDeleted = json['isDeleted'];

  Map<String, dynamic> toJson() => {
        'companyProfileId': companyProfileId,
        'companyName': companyName,
        'vatNo': vatNo,
        'phone': phone,
        'email': email,
        'address': address,
        'logo': logo,
        'status': status,
        'lastModified': lastModified,
        'isDeleted': isDeleted
      };
}

class CustomInputDataRequestModels {
  int? customInputDataId;
  dynamic cartId;
  int? invoiceMasterId;
  int? invoiceDetailsId;
  dynamic customInputId;
  String? value;
  int? customerId;
  String? name;
  String? tempId;
  dynamic values;
  List<String>? images;

  CustomInputDataRequestModels(
      {this.customInputDataId,
      this.cartId,
      this.invoiceMasterId,
      this.invoiceDetailsId,
      this.customInputId,
      this.value,
      this.customerId,
      this.name,
      this.tempId,
      this.values,
      this.images});

  CustomInputDataRequestModels.fromJson(Map<String, dynamic> json) {
    List<String> imagesFormatted = [];
    if (json['images'] != null) {
      List<String> allImages = json['images'].cast<String>();
      allImages.forEach((element) {
        var imageLocation = '';
        if (element.contains('admin.noa.market')) {
          imageLocation = element;
        } else {
          imageLocation = 'https://admin.noa.market/' + element;
        }
        imagesFormatted.add(imageLocation);
      });
    }
    customInputDataId = json['customInputDataId'];
    cartId = json['cartId'];
    invoiceMasterId = json['invoiceMasterId'];
    invoiceDetailsId = json['invoiceDetailsId'];
    customInputId = json['customInputId'];
    value = json['value'];
    customerId = json['customerId'];
    name = json['name'];
    tempId = json['tempId'];
    values = json['values'];
    images = imagesFormatted;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['customInputDataId'] = this.customInputDataId;
    data['cartId'] = this.cartId;
    data['invoiceMasterId'] = this.invoiceMasterId;
    data['invoiceDetailsId'] = this.invoiceDetailsId;
    data['customInputId'] = this.customInputId;
    data['value'] = this.value;
    data['customerId'] = this.customerId;
    data['name'] = this.name;
    data['tempId'] = this.tempId;
    data['values'] = this.values;
    data['images'] = this.images;
    return data;
  }
}
