class OrderUpdateRequestModel {
  final int? invoiceMasterId;
  final int? customerId;
  final String? refNumber;
  final String? invoiceDate;
  final int? totalAmount;
  final int? receivedAmt;
  final int? courierCharge;
  final int? carryingCost;
  final int? paymentMethod;
  final String? remark;
  final String? discountCode;
  final int? discountValue;
  final int? paymentStatus;
  final String? status;
  final String? createdAt;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final int? invoiceStatusId;
  final List<InvoiceRequestModels>? invoiceRequestModels;
  final List<PaymentRequestModels>? paymentRequestModels;
  final List<BillingShippingAddressRequestModels>?
      billingShippingAddressRequestModels;
  final List<dynamic>? inputFieldValueRequestModels;

  OrderUpdateRequestModel({
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
    this.createdAt,
    this.countryId,
    this.stateId,
    this.cityId,
    this.invoiceStatusId,
    this.invoiceRequestModels,
    this.paymentRequestModels,
    this.billingShippingAddressRequestModels,
    this.inputFieldValueRequestModels,
  });

  OrderUpdateRequestModel.fromJson(Map<String, dynamic> json)
      : invoiceMasterId = json['invoiceMasterId'] as int?,
        customerId = json['customerId'] as int?,
        refNumber = json['refNumber'] as String?,
        invoiceDate = json['invoiceDate'] as String?,
        totalAmount = json['totalAmount'] as int?,
        receivedAmt = json['receivedAmt'] as int?,
        courierCharge = json['courierCharge'] as int?,
        carryingCost = json['carryingCost'] as int?,
        paymentMethod = json['paymentMethod'] as int?,
        remark = json['remark'] as String?,
        discountCode = json['discountCode'] as String?,
        discountValue = json['discountValue'] as int?,
        paymentStatus = json['paymentStatus'] as int?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        countryId = json['countryId'] as int?,
        stateId = json['stateId'] as int?,
        cityId = json['cityId'] as int?,
        invoiceStatusId = json['invoiceStatusId'] as int?,
        invoiceRequestModels = (json['invoiceRequestModels'] as List?)
            ?.map((dynamic e) =>
                InvoiceRequestModels.fromJson(e as Map<String, dynamic>))
            .toList(),
        paymentRequestModels = (json['paymentRequestModels'] as List?)
            ?.map((dynamic e) =>
                PaymentRequestModels.fromJson(e as Map<String, dynamic>))
            .toList(),
        billingShippingAddressRequestModels =
            (json['billingShippingAddressRequestModels'] as List?)
                ?.map((dynamic e) =>
                    BillingShippingAddressRequestModels.fromJson(
                        e as Map<String, dynamic>))
                .toList(),
        inputFieldValueRequestModels =
            json['inputFieldValueRequestModels'] as List?;

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
        'createdAt': createdAt,
        'countryId': countryId,
        'stateId': stateId,
        'cityId': cityId,
        'invoiceStatusId': invoiceStatusId,
        'invoiceRequestModels':
            invoiceRequestModels?.map((e) => e.toJson()).toList(),
        'paymentRequestModels':
            paymentRequestModels?.map((e) => e.toJson()).toList(),
        'billingShippingAddressRequestModels':
            billingShippingAddressRequestModels
                ?.map((e) => e.toJson())
                .toList(),
        'inputFieldValueRequestModels': inputFieldValueRequestModels
      };
}

class InvoiceRequestModels {
  final int? invoiceId;
  final int? invoiceMasterId;
  final String? refNumber;
  final String? invoiceDate;
  final int? totalAmount;
  final int? receivedAmt;
  final int? carryingCost;
  final int? courierCharge;
  final int? paymentMethod;
  final int? paymentStatus;
  final String? remark;
  final String? discountCode;
  final int? discountValue;
  final int? storeId;
  final String? status;
  final String? createdAt;
  final int? supplierId;
  final int? invoiceStatusId;
  final int? amountToSupplier;
  final int? amountToAdmin;
  final int? supplierCommissionId;
  final bool? isService;
  final bool? isDigitalProduct;
  final bool? isQuotationProduct;
  final String? serviceDate;
  final String? serviceDateTime;
  final String? serviceTime;
  final List<InvoiceDetailsRequestModels>? invoiceDetailsRequestModels;
  final List<InvoiceDetailsViewModels>? invoiceDetailsViewModels;

  InvoiceRequestModels({
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
    this.remark,
    this.discountCode,
    this.discountValue,
    this.storeId,
    this.status,
    this.createdAt,
    this.supplierId,
    this.invoiceStatusId,
    this.amountToSupplier,
    this.amountToAdmin,
    this.supplierCommissionId,
    this.isService,
    this.isDigitalProduct,
    this.isQuotationProduct,
    this.serviceDate,
    this.serviceDateTime,
    this.serviceTime,
    this.invoiceDetailsRequestModels,
    this.invoiceDetailsViewModels,
  });

  InvoiceRequestModels.fromJson(Map<String, dynamic> json)
      : invoiceId = json['invoiceId'] as int?,
        invoiceMasterId = json['invoiceMasterId'] as int?,
        refNumber = json['refNumber'] as String?,
        invoiceDate = json['invoiceDate'] as String?,
        totalAmount = json['totalAmount'] as int?,
        receivedAmt = json['receivedAmt'] as int?,
        carryingCost = json['carryingCost'] as int?,
        courierCharge = json['courierCharge'] as int?,
        paymentMethod = json['paymentMethod'] as int?,
        paymentStatus = json['paymentStatus'] as int?,
        remark = json['remark'] as String?,
        discountCode = json['discountCode'] as String?,
        discountValue = json['discountValue'] as int?,
        storeId = json['storeId'] as int?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        supplierId = json['supplierId'] as int?,
        invoiceStatusId = json['invoiceStatusId'] as int?,
        amountToSupplier = json['amountToSupplier'] as int?,
        amountToAdmin = json['amountToAdmin'] as int?,
        supplierCommissionId = json['supplierCommissionId'] as int?,
        isService = json['isService'] as bool?,
        isDigitalProduct = json['isDigitalProduct'] as bool?,
        isQuotationProduct = json['isQuotationProduct'] as bool?,
        serviceDate = json['serviceDate'] as String?,
        serviceDateTime = json['serviceDateTime'] as String?,
        serviceTime = json['serviceTime'] as String?,
        invoiceDetailsRequestModels = (json['invoiceDetailsRequestModels']
                as List?)
            ?.map((dynamic e) =>
                InvoiceDetailsRequestModels.fromJson(e as Map<String, dynamic>))
            .toList(),
        invoiceDetailsViewModels = (json['invoiceDetailsViewModels'] as List?)
            ?.map((dynamic e) =>
                InvoiceDetailsViewModels.fromJson(e as Map<String, dynamic>))
            .toList();

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
        'remark': remark,
        'discountCode': discountCode,
        'discountValue': discountValue,
        'storeId': storeId,
        'status': status,
        'createdAt': createdAt,
        'supplierId': supplierId,
        'invoiceStatusId': invoiceStatusId,
        'amountToSupplier': amountToSupplier,
        'amountToAdmin': amountToAdmin,
        'supplierCommissionId': supplierCommissionId,
        'isService': isService,
        'isDigitalProduct': isDigitalProduct,
        'isQuotationProduct': isQuotationProduct,
        'serviceDate': serviceDate,
        'serviceDateTime': serviceDateTime,
        'serviceTime': serviceTime,
        'invoiceDetailsRequestModels':
            invoiceDetailsRequestModels?.map((e) => e.toJson()).toList(),
        'invoiceDetailsViewModels':
            invoiceDetailsViewModels?.map((e) => e.toJson()).toList()
      };
}

class InvoiceDetailsRequestModels {
  final int? invoiceDetailsId;
  final int? invoiceId;
  final int? productMasterId;
  final int? quantity;
  final int? price;
  final String? status;
  final String? createdAt;
  final int? productSubSKUId;

  InvoiceDetailsRequestModels({
    this.invoiceDetailsId,
    this.invoiceId,
    this.productMasterId,
    this.quantity,
    this.price,
    this.status,
    this.createdAt,
    this.productSubSKUId,
  });

  InvoiceDetailsRequestModels.fromJson(Map<String, dynamic> json)
      : invoiceDetailsId = json['invoiceDetailsId'] as int?,
        invoiceId = json['invoiceId'] as int?,
        productMasterId = json['productMasterId'] as int?,
        quantity = json['quantity'] as int?,
        price = json['price'] as int?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        productSubSKUId = json['productSubSKUId'] as int?;

  Map<String, dynamic> toJson() => {
        'invoiceDetailsId': invoiceDetailsId,
        'invoiceId': invoiceId,
        'productMasterId': productMasterId,
        'quantity': quantity,
        'price': price,
        'status': status,
        'createdAt': createdAt,
        'productSubSKUId': productSubSKUId
      };
}

class InvoiceDetailsViewModels {
  final int? invoiceDetailsId;
  final int? invoiceId;
  final int? productMasterId;
  final int? quantity;
  final int? price;
  final String? status;
  final String? createdAt;
  final int? productTypeId;
  final int? storeId;
  final int? supplierId;
  final String? supplierName;
  final String? supplierMobile;
  final String? productName;
  final int? invoiceMasterId;
  final int? productSkuId;
  final String? subSku;
  final String? largeImage;
  final String? mediumImage;
  final String? smallImage;
  final String? fileLocation;
  final String? digitalProductGuid;
  final String? digitalProductUrl;
  final String? serviceDate;
  final String? brandName;
  final List<ProductSubSKUViewModels>? productSubSKUViewModels;

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
        quantity = json['quantity'] as int?,
        price = json['price'] as int?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        productTypeId = json['productTypeId'] as int?,
        storeId = json['storeId'] as int?,
        supplierId = json['supplierId'] as int?,
        supplierName = json['supplierName'] as String?,
        supplierMobile = json['supplierMobile'] as String?,
        productName = json['productName'] as String?,
        invoiceMasterId = json['invoiceMasterId'] as int?,
        productSkuId = json['productSkuId'] as int?,
        subSku = json['subSku'] as String?,
        largeImage = json['largeImage'] as String?,
        mediumImage = json['mediumImage'] as String?,
        smallImage = json['smallImage'] as String?,
        fileLocation = json['fileLocation'] as String?,
        digitalProductGuid = json['digitalProductGuid'] as String?,
        digitalProductUrl = json['digitalProductUrl'] as String?,
        serviceDate = json['serviceDate'] as String?,
        brandName = json['brandName'] as String?,
        productSubSKUViewModels = (json['productSubSKUViewModels'] as List?)
            ?.map((dynamic e) =>
                ProductSubSKUViewModels.fromJson(e as Map<String, dynamic>))
            .toList();

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
        'productSubSKUViewModels':
            productSubSKUViewModels?.map((e) => e.toJson()).toList()
      };
}

class ProductSubSKUViewModels {
  final int? productSubSKUId;
  final int? productMasterId;
  final String? subSKU;
  final int? price;
  final int? quantity;
  final String? barcode;
  final String? status;
  final int? createBy;
  final String? createDate;
  final String? skuImage;
  final String? attributeCombination;
  final int? productAttributeDetailsId;
  final bool? isDelete;
  final String? attributesIds;
  final int? attributeSetId;
  final String? largeImage;
  final String? mediumImage;
  final String? smallImage;
  final String? videoEmbade;
  final int? productDetailsId;
  final int? wareHouseProductMasterInfoId;
  final int? wareHouseId;
  final int? wareHouseAttributeDetailId;
  final int? wareHouseShelfAttributeDetailId;
  final int? wareHouseShelfRowAttributeDetailId;
  final int? wareHouseShelfColumnAttributeDetailId;
  final int? purchaseRate;
  final int? saleRate;
  final List<ProductSubSkuDetailsViewModels>? productSubSkuDetailsViewModels;

  ProductSubSKUViewModels({
    this.productSubSKUId,
    this.productMasterId,
    this.subSKU,
    this.price,
    this.quantity,
    this.barcode,
    this.status,
    this.createBy,
    this.createDate,
    this.skuImage,
    this.attributeCombination,
    this.productAttributeDetailsId,
    this.isDelete,
    this.attributesIds,
    this.attributeSetId,
    this.largeImage,
    this.mediumImage,
    this.smallImage,
    this.videoEmbade,
    this.productDetailsId,
    this.wareHouseProductMasterInfoId,
    this.wareHouseId,
    this.wareHouseAttributeDetailId,
    this.wareHouseShelfAttributeDetailId,
    this.wareHouseShelfRowAttributeDetailId,
    this.wareHouseShelfColumnAttributeDetailId,
    this.purchaseRate,
    this.saleRate,
    this.productSubSkuDetailsViewModels,
  });

  ProductSubSKUViewModels.fromJson(Map<String, dynamic> json)
      : productSubSKUId = json['productSubSKUId'] as int?,
        productMasterId = json['productMasterId'] as int?,
        subSKU = json['subSKU'] as String?,
        price = json['price'] as int?,
        quantity = json['quantity'] as int?,
        barcode = json['barcode'] as String?,
        status = json['status'] as String?,
        createBy = json['createBy'] as int?,
        createDate = json['createDate'] as String?,
        skuImage = json['skuImage'] as String?,
        attributeCombination = json['attributeCombination'] as String?,
        productAttributeDetailsId = json['productAttributeDetailsId'] as int?,
        isDelete = json['isDelete'] as bool?,
        attributesIds = json['attributesIds'] as String?,
        attributeSetId = json['attributeSetId'] as int?,
        largeImage = json['largeImage'] as String?,
        mediumImage = json['mediumImage'] as String?,
        smallImage = json['smallImage'] as String?,
        videoEmbade = json['videoEmbade'] as String?,
        productDetailsId = json['productDetailsId'] as int?,
        wareHouseProductMasterInfoId =
            json['wareHouseProductMasterInfoId'] as int?,
        wareHouseId = json['wareHouseId'] as int?,
        wareHouseAttributeDetailId = json['wareHouseAttributeDetailId'] as int?,
        wareHouseShelfAttributeDetailId =
            json['wareHouseShelfAttributeDetailId'] as int?,
        wareHouseShelfRowAttributeDetailId =
            json['wareHouseShelfRowAttributeDetailId'] as int?,
        wareHouseShelfColumnAttributeDetailId =
            json['wareHouseShelfColumnAttributeDetailId'] as int?,
        purchaseRate = json['purchaseRate'] as int?,
        saleRate = json['saleRate'] as int?,
        productSubSkuDetailsViewModels =
            (json['productSubSkuDetailsViewModels'] as List?)
                ?.map((dynamic e) => ProductSubSkuDetailsViewModels.fromJson(
                    e as Map<String, dynamic>))
                .toList();

  Map<String, dynamic> toJson() => {
        'productSubSKUId': productSubSKUId,
        'productMasterId': productMasterId,
        'subSKU': subSKU,
        'price': price,
        'quantity': quantity,
        'barcode': barcode,
        'status': status,
        'createBy': createBy,
        'createDate': createDate,
        'skuImage': skuImage,
        'attributeCombination': attributeCombination,
        'productAttributeDetailsId': productAttributeDetailsId,
        'isDelete': isDelete,
        'attributesIds': attributesIds,
        'attributeSetId': attributeSetId,
        'largeImage': largeImage,
        'mediumImage': mediumImage,
        'smallImage': smallImage,
        'videoEmbade': videoEmbade,
        'productDetailsId': productDetailsId,
        'wareHouseProductMasterInfoId': wareHouseProductMasterInfoId,
        'wareHouseId': wareHouseId,
        'wareHouseAttributeDetailId': wareHouseAttributeDetailId,
        'wareHouseShelfAttributeDetailId': wareHouseShelfAttributeDetailId,
        'wareHouseShelfRowAttributeDetailId':
            wareHouseShelfRowAttributeDetailId,
        'wareHouseShelfColumnAttributeDetailId':
            wareHouseShelfColumnAttributeDetailId,
        'purchaseRate': purchaseRate,
        'saleRate': saleRate,
        'productSubSkuDetailsViewModels':
            productSubSkuDetailsViewModels?.map((e) => e.toJson()).toList()
      };
}

class ProductSubSkuDetailsViewModels {
  final int? productSubSKUDetailsId;
  final int? productSubSKUId;
  final int? attributeDetailId;

  ProductSubSkuDetailsViewModels({
    this.productSubSKUDetailsId,
    this.productSubSKUId,
    this.attributeDetailId,
  });

  ProductSubSkuDetailsViewModels.fromJson(Map<String, dynamic> json)
      : productSubSKUDetailsId = json['productSubSKUDetailsId'] as int?,
        productSubSKUId = json['productSubSKUId'] as int?,
        attributeDetailId = json['attributeDetailId'] as int?;

  Map<String, dynamic> toJson() => {
        'productSubSKUDetailsId': productSubSKUDetailsId,
        'productSubSKUId': productSubSKUId,
        'attributeDetailId': attributeDetailId
      };
}

class PaymentRequestModels {
  final int? paymentId;
  final int? invoiceMasterId;
  final int? currencyId;
  final int? amount;
  final int? courierCharge;
  final int? discountAmount;
  final int? carryingCost;
  final int? paymentMethod;
  final int? courierAgencyId;
  final String? payDate;
  final String? note;
  final String? transactionNo;
  final String? status;
  final String? createdAt;
  final int? couponId;

  PaymentRequestModels({
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
  });

  PaymentRequestModels.fromJson(Map<String, dynamic> json)
      : paymentId = json['paymentId'] as int?,
        invoiceMasterId = json['invoiceMasterId'] as int?,
        currencyId = json['currencyId'] as int?,
        amount = json['amount'] as int?,
        courierCharge = json['courierCharge'] as int?,
        discountAmount = json['discountAmount'] as int?,
        carryingCost = json['carryingCost'] as int?,
        paymentMethod = json['paymentMethod'] as int?,
        courierAgencyId = json['courierAgencyId'] as int?,
        payDate = json['payDate'] as String?,
        note = json['note'] as String?,
        transactionNo = json['transactionNo'] as String?,
        status = json['status'] as String?,
        createdAt = json['createdAt'] as String?,
        couponId = json['couponId'] as int?;

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
        'couponId': couponId
      };
}

class BillingShippingAddressRequestModels {
  final int? billingShippingAddressId;
  final int? invoiceMasterId;
  final int? customerId;
  final int? customerAddressId;

  BillingShippingAddressRequestModels({
    this.billingShippingAddressId,
    this.invoiceMasterId,
    this.customerId,
    this.customerAddressId,
  });

  BillingShippingAddressRequestModels.fromJson(Map<String, dynamic> json)
      : billingShippingAddressId = json['billingShippingAddressId'] as int?,
        invoiceMasterId = json['invoiceMasterId'] as int?,
        customerId = json['customerId'] as int?,
        customerAddressId = json['customerAddressId'] as int?;

  Map<String, dynamic> toJson() => {
        'billingShippingAddressId': billingShippingAddressId,
        'invoiceMasterId': invoiceMasterId,
        'customerId': customerId,
        'customerAddressId': customerAddressId
      };
}
