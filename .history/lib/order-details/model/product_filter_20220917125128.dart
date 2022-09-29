class ProductFilter {
  dynamic productMasterId;
  dynamic quickSearch;
  int? page;
  int? pageSize;
  dynamic productShortingTypeId;
  int? languageId;
  dynamic countryId;
  dynamic currencyId;
  dynamic customerId;
  int? supplierId;
  bool? priceHighToLow;
  List<dynamic>? categoryIds;
  List<dynamic>? categorySubIds;
  List<dynamic>? brandIds;
  int? totalRecord;
  String? viewType;
  dynamic sortBy;
  double? maxPrice;
  double? minPrice;
  List<ProductListRequestModels>? productListRequestModels;

  ProductFilter(
      {this.productMasterId,
      this.quickSearch,
      this.page,
      this.pageSize,
      this.productShortingTypeId,
      this.languageId,
      this.countryId,
      this.currencyId,
      this.customerId,
      this.supplierId,
      this.priceHighToLow,
      this.categoryIds,
      this.categorySubIds,
      this.brandIds,
      this.totalRecord,
      this.viewType,
      this.sortBy,
      this.maxPrice,
      this.minPrice,
      this.productListRequestModels});

  ProductFilter.fromJson(Map<String, dynamic> json) {
    productMasterId = json['productMasterId'];
    quickSearch = json['quickSearch'];
    page = json['page'];
    pageSize = json['pageSize'];
    productShortingTypeId = json['productShortingTypeId'];
    languageId = json['languageId'];
    countryId = json['countryId'];
    currencyId = json['currencyId'];
    customerId = json['customerId'];
    supplierId = json['supplierId'];
    priceHighToLow = json['priceHighToLow'];
    if (json['categoryIds'] != dynamic) {
      categoryIds = <dynamic>[];
      json['categoryIds'].forEach((v) {
        categoryIds!.add(v);
      });
    }
    if (json['categorySubIds'] != dynamic) {
      categorySubIds = <dynamic>[];
      json['categorySubIds'].forEach((v) {
        categorySubIds!.add((v));
      });
    }
    if (json['brandIds'] != dynamic) {
      brandIds = <dynamic>[];
      json['brandIds'].forEach((v) {
        brandIds!.add(v);
      });
    }
    totalRecord = json['totalRecord'];
    viewType = json['viewType'];
    sortBy = json['sortBy'];
    maxPrice = json['maxPrice'];
    minPrice = json['minPrice'];
    if (json['productListRequestModels'] != dynamic) {
      productListRequestModels = <ProductListRequestModels>[];
      json['productListRequestModels'].forEach((v) {
        productListRequestModels!.add(new ProductListRequestModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productMasterId'] = this.productMasterId;
    data['quickSearch'] = this.quickSearch;
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['productShortingTypeId'] = this.productShortingTypeId;
    data['languageId'] = this.languageId;
    data['countryId'] = this.countryId;
    data['currencyId'] = this.currencyId;
    data['customerId'] = this.customerId;
    data['supplierId'] = this.supplierId;
    data['priceHighToLow'] = this.priceHighToLow;
    if (this.categoryIds != dynamic) {
      data['categoryIds'] = this.categoryIds!.map((v) => v.toJson()).toList();
    }
    if (this.categorySubIds != dynamic) {
      data['categorySubIds'] =
          this.categorySubIds!.map((v) => v.toJson()).toList();
    }
    if (this.brandIds != dynamic) {
      data['brandIds'] = this.brandIds!.map((v) => v.toJson()).toList();
    }
    data['totalRecord'] = this.totalRecord;
    data['viewType'] = this.viewType;
    data['sortBy'] = this.sortBy;
    data['maxPrice'] = this.maxPrice;
    data['minPrice'] = this.minPrice;
    if (this.productListRequestModels != dynamic) {
      data['productListRequestModels'] =
          this.productListRequestModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductListRequestModels {
  int? productMasterId;
  String? productName;
  int? productTypeId;
  dynamic productType;
  double? productDecimal;
  double? totalRating;
  double? totalReview;
  int? storeId;
  int? supplierId;
  bool? isWished;
  String? urlKey;
  String? metaTitle;
  String? metaKeyword;
  String? metaDesceiption;
  String? guidId;
  List<ProductMasterMediaViewModels>? productMasterMediaViewModels;
  List<ProductSubSkuRequestModels>? productSubSkuRequestModels;

  ProductListRequestModels(
      {this.productMasterId,
      this.productName,
      this.productTypeId,
      this.productType,
      this.productDecimal,
      this.totalRating,
      this.totalReview,
      this.storeId,
      this.supplierId,
      this.isWished,
      this.urlKey,
      this.metaTitle,
      this.metaKeyword,
      this.metaDesceiption,
      this.guidId,
      this.productMasterMediaViewModels,
      this.productSubSkuRequestModels});

  ProductListRequestModels.fromJson(Map<String, dynamic> json) {
    productMasterId = json['productMasterId'];
    productName = json['productName'];
    productTypeId = json['productTypeId'];
    productType = json['productType'];
    productDecimal = json['productDecimal'];
    totalRating = json['totalRating'];
    totalReview = json['totalReview'];
    storeId = json['storeId'];
    supplierId = json['supplierId'];
    isWished = json['isWished'];
    urlKey = json['urlKey'];
    metaTitle = json['metaTitle'];
    metaKeyword = json['metaKeyword'];
    metaDesceiption = json['metaDesceiption'];
    guidId = json['guidId'];
    if (json['productMasterMediaViewModels'] != dynamic) {
      productMasterMediaViewModels = <ProductMasterMediaViewModels>[];
      json['productMasterMediaViewModels'].forEach((v) {
        productMasterMediaViewModels!
            .add(new ProductMasterMediaViewModels.fromJson(v));
      });
    }
    if (json['productSubSkuRequestModels'] != dynamic) {
      productSubSkuRequestModels = <ProductSubSkuRequestModels>[];
      json['productSubSkuRequestModels'].forEach((v) {
        productSubSkuRequestModels!
            .add(new ProductSubSkuRequestModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productMasterId'] = this.productMasterId;
    data['productName'] = this.productName;
    data['productTypeId'] = this.productTypeId;
    data['productType'] = this.productType;
    data['productDecimal'] = this.productDecimal;
    data['totalRating'] = this.totalRating;
    data['totalReview'] = this.totalReview;
    data['storeId'] = this.storeId;
    data['supplierId'] = this.supplierId;
    data['isWished'] = this.isWished;
    data['urlKey'] = this.urlKey;
    data['metaTitle'] = this.metaTitle;
    data['metaKeyword'] = this.metaKeyword;
    data['metaDesceiption'] = this.metaDesceiption;
    data['guidId'] = this.guidId;
    if (this.productMasterMediaViewModels != dynamic) {
      data['productMasterMediaViewModels'] =
          this.productMasterMediaViewModels!.map((v) => v.toJson()).toList();
    }
    if (this.productSubSkuRequestModels != dynamic) {
      data['productSubSkuRequestModels'] =
          this.productSubSkuRequestModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductMasterMediaViewModels {
  int? productMasterMediaId;
  int? productMasterId;
  String? fileType;
  String? fileName;
  String? fileLocation;
  String? videoEmbade;
  String? fileKey;
  dynamic mediumImage;
  dynamic smallImage;
  dynamic productSubSKUId;
  bool? isFeatureImage;

  ProductMasterMediaViewModels(
      {this.productMasterMediaId,
      this.productMasterId,
      this.fileType,
      this.fileName,
      this.fileLocation,
      this.videoEmbade,
      this.fileKey,
      this.mediumImage,
      this.smallImage,
      this.productSubSKUId,
      this.isFeatureImage});

  ProductMasterMediaViewModels.fromJson(Map<String, dynamic> json) {
    productMasterMediaId = json['productMasterMediaId'];
    productMasterId = json['productMasterId'];
    fileType = json['fileType'];
    fileName = json['fileName'];
    fileLocation = (json['fileLocation'] as String).contains('noa.market')
        ? json['fileLocation'] as String
        : 'https://admin.noa.market/' + json['fileLocation'];
    videoEmbade = json['videoEmbade'];
    fileKey = json['fileKey'];
    mediumImage = json['mediumImage'];
    smallImage = json['smallImage'];
    productSubSKUId = json['productSubSKUId'];
    isFeatureImage = json['isFeatureImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productMasterMediaId'] = this.productMasterMediaId;
    data['productMasterId'] = this.productMasterId;
    data['fileType'] = this.fileType;
    data['fileName'] = this.fileName;
    data['fileLocation'] = this.fileLocation;
    data['videoEmbade'] = this.videoEmbade;
    data['fileKey'] = this.fileKey;
    data['mediumImage'] = this.mediumImage;
    data['smallImage'] = this.smallImage;
    data['productSubSKUId'] = this.productSubSKUId;
    data['isFeatureImage'] = this.isFeatureImage;
    return data;
  }
}

class ProductSubSkuRequestModels {
  int? productSubSKUId;
  int? productMasterId;
  int? storeId;
  String? subSKU;
  dynamic previousPrice;
  double? price;
  double? quantity;
  String? attributeCombination;
  int? attributeSetId;
  String? largeImage;
  String? mediumImage;
  String? smallImage;
  String? videoEmbade;
  String? symbol;
  List<dynamic>? productSubSkuDetailsRequestModels;

  ProductSubSkuRequestModels(
      {this.productSubSKUId,
      this.productMasterId,
      this.storeId,
      this.subSKU,
      this.previousPrice,
      this.price,
      this.quantity,
      this.attributeCombination,
      this.attributeSetId,
      this.largeImage,
      this.mediumImage,
      this.smallImage,
      this.videoEmbade,
      this.symbol,
      this.productSubSkuDetailsRequestModels});

  ProductSubSkuRequestModels.fromJson(Map<String, dynamic> json) {
    productSubSKUId = json['productSubSKUId'];
    productMasterId = json['productMasterId'];
    storeId = json['storeId'];
    subSKU = json['subSKU'];
    previousPrice = json['previousPrice'];
    price = json['price'];
    quantity = json['quantity'];
    attributeCombination = json['attributeCombination'];
    attributeSetId = json['attributeSetId'];
    largeImage = json['largeImage'];
    mediumImage = json['mediumImage'];
    smallImage = json['smallImage'];
    videoEmbade = json['videoEmbade'];
    symbol = json['symbol'];
    if (json['productSubSkuDetailsRequestModels'] != dynamic) {
      productSubSkuDetailsRequestModels = <dynamic>[];
      json['productSubSkuDetailsRequestModels'].forEach((v) {
        productSubSkuDetailsRequestModels!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productSubSKUId'] = this.productSubSKUId;
    data['productMasterId'] = this.productMasterId;
    data['storeId'] = this.storeId;
    data['subSKU'] = this.subSKU;
    data['previousPrice'] = this.previousPrice;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['attributeCombination'] = this.attributeCombination;
    data['attributeSetId'] = this.attributeSetId;
    data['largeImage'] = this.largeImage;
    data['mediumImage'] = this.mediumImage;
    data['smallImage'] = this.smallImage;
    data['videoEmbade'] = this.videoEmbade;
    data['symbol'] = this.symbol;
    if (productSubSkuDetailsRequestModels != dynamic) {
      data['productSubSkuDetailsRequestModels'] =
          productSubSkuDetailsRequestModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
