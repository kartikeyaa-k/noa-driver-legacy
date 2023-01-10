// To parse this JSON data, do
//
//     final productResponseData = productResponseDataFromJson(jsonString);

import 'dart:convert';

import 'package:noa_driver/core/environments/base_config.dart';

List<ProductResponseData> productResponseDataFromJson(String str) =>
    List<ProductResponseData>.from(
        json.decode(str).map((x) => ProductResponseData.fromJson(x)));

String productResponseDataToJson(List<ProductResponseData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResponseData {
  ProductResponseData({
    required this.productMasterId,
    required this.productName,
    required this.productTypeId,
    required this.productType,
    required this.productDecimal,
    required this.totalRating,
    required this.totalReview,
    this.storeId,
    this.supplierId,
    required this.customquantity,
    required this.selectedService,
    required this.isWished,
    required this.urlKey,
    required this.metaTitle,
    required this.metaKeyword,
    required this.metaDesceiption,
    required this.guidId,
    required this.mobileAppVisibility,
    required this.description,
    required this.shortDescription,
    required this.productMasterMediaViewModels,
    required this.productSubSkuRequestModels,
  });

  int productMasterId;
  String productName;
  int productTypeId;
  dynamic productType;
  double productDecimal;
  double totalRating;
  double totalReview;
  dynamic storeId;
  dynamic supplierId;
  int customquantity;
  bool selectedService;
  bool isWished;
  String urlKey;
  String metaTitle;
  String metaKeyword;
  String metaDesceiption;
  String guidId;
  bool mobileAppVisibility;
  String description;
  String shortDescription;
  List<ProductMasterMediaViewModel> productMasterMediaViewModels;
  List<ProductSubSkuRequestModel> productSubSkuRequestModels;

  factory ProductResponseData.fromJson(Map<String, dynamic> json) =>
      ProductResponseData(
        productMasterId: json["productMasterId"],
        productName: json["productName"],
        productTypeId: json["productTypeId"],
        productType: json["productType"],
        productDecimal: json["productDecimal"],
        totalRating: json["totalRating"],
        totalReview: json["totalReview"],
        storeId: json["storeId"]!,
        supplierId: json["supplierId"],
        customquantity: 0,
        selectedService: false,
        isWished: json["isWished"],
        urlKey: json["urlKey"],
        metaTitle: json["metaTitle"],
        metaKeyword: json["metaKeyword"],
        metaDesceiption: json["metaDesceiption"],
        guidId: json["guidId"],
        mobileAppVisibility: json['mobileAppVisibility'],
        description: json["description"] ?? '',
        shortDescription: json["shortDescription"] ?? '',
        productMasterMediaViewModels: List<ProductMasterMediaViewModel>.from(
            json["productMasterMediaViewModels"]
                .map((x) => ProductMasterMediaViewModel.fromJson(x))),
        productSubSkuRequestModels: List<ProductSubSkuRequestModel>.from(
            json["productSubSkuRequestModels"]
                .map((x) => ProductSubSkuRequestModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productMasterId": productMasterId,
        "productName": productName,
        "productTypeId": productTypeId,
        "productType": productType,
        "productDecimal": productDecimal,
        "totalRating": totalRating,
        "totalReview": totalReview,
        "storeId": storeId,
        "supplierId": supplierId,
        "isWished": isWished,
        "urlKey": urlKey,
        "metaTitle": metaTitle,
        "metaKeyword": metaKeyword,
        "metaDesceiption": metaDesceiption,
        "guidId": guidId,
        'mobileAppVisibility': mobileAppVisibility,
        "productMasterMediaViewModels": List<dynamic>.from(
            productMasterMediaViewModels.map((x) => x.toJson())),
        "productSubSkuRequestModels": List<dynamic>.from(
            productSubSkuRequestModels.map((x) => x.toJson())),
      };
}

class ProductMasterMediaViewModel {
  ProductMasterMediaViewModel({
    required this.productMasterMediaId,
    required this.productMasterId,
    required this.fileType,
    required this.fileName,
    required this.fileLocation,
    required this.videoEmbade,
    required this.fileKey,
    this.mediumImage,
    this.smallImage,
    this.productSubSkuId,
  });

  int productMasterMediaId;
  int productMasterId;
  String fileType;
  String fileName;
  String fileLocation;
  String videoEmbade;
  String fileKey;
  dynamic mediumImage;
  dynamic smallImage;
  dynamic productSubSkuId;

  factory ProductMasterMediaViewModel.fromJson(Map<String, dynamic> json) {
    String fileLocation = '';
    if (json.containsKey("fileLocation") && json["fileLocation"] != null) {
      fileLocation = json["fileLocation"];
      if (fileLocation.toString().contains('admin.noa.market') ||
          fileLocation.toString().contains('staging.noa.market')) {
      } else {
        var env = Environment().config.envType;
        if (env == EnvironmentType.dev) {
          fileLocation = 'https://staging.noa.market/' + fileLocation;
        } else {
          fileLocation = 'https://admin.noa.market/' + fileLocation;
        }
      }
    }
    return ProductMasterMediaViewModel(
      productMasterMediaId: json["productMasterMediaId"],
      productMasterId: json["productMasterId"],
      fileType: json["fileType"],
      fileName: json["fileName"],
      fileLocation: fileLocation,
      videoEmbade: json["videoEmbade"],
      fileKey: json["fileKey"],
      mediumImage: json["mediumImage"],
      smallImage: json["smallImage"],
      productSubSkuId: json["productSubSKUId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "productMasterMediaId": productMasterMediaId,
        "productMasterId": productMasterId,
        "fileType": fileType,
        "fileName": fileName,
        "fileLocation": fileLocation,
        "videoEmbade": videoEmbade,
        "fileKey": fileKey,
        "mediumImage": mediumImage,
        "smallImage": smallImage,
        "productSubSKUId": productSubSkuId,
      };
}

class ProductSubSkuRequestModel {
  ProductSubSkuRequestModel({
    required this.productSubSkuId,
    required this.productMasterId,
    required this.storeId,
    required this.subSku,
    this.previousPrice,
    required this.price,
    required this.quantity,
    required this.attributeCombination,
    required this.attributeSetId,
    required this.largeImage,
    required this.mediumImage,
    required this.smallImage,
    required this.videoEmbade,
    required this.symbol,
    required this.productSubSkuDetailsRequestModels,
  });

  int productSubSkuId;
  int productMasterId;
  int storeId;
  String subSku;
  dynamic previousPrice;
  double price;
  double quantity;
  String attributeCombination;
  int attributeSetId;
  String largeImage;
  String mediumImage;
  String smallImage;
  String videoEmbade;
  String symbol;
  List<dynamic> productSubSkuDetailsRequestModels;

  factory ProductSubSkuRequestModel.fromJson(Map<String, dynamic> json) =>
      ProductSubSkuRequestModel(
        productSubSkuId: json["productSubSKUId"],
        productMasterId: json["productMasterId"],
        storeId: json["storeId"],
        subSku: json["subSKU"],
        previousPrice: json["previousPrice"],
        price: json["price"].toDouble(),
        quantity: json["quantity"] == null ? 0.0 : json["quantity"],
        attributeCombination: json["attributeCombination"],
        attributeSetId: json["attributeSetId"],
        largeImage: json["largeImage"],
        mediumImage: json["mediumImage"],
        smallImage: json["smallImage"],
        videoEmbade: json["videoEmbade"],
        symbol: json["symbol"],
        productSubSkuDetailsRequestModels: List<dynamic>.from(
            json["productSubSkuDetailsRequestModels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "productSubSKUId": productSubSkuId,
        "productMasterId": productMasterId,
        "storeId": storeId,
        "subSKU": subSku,
        "previousPrice": previousPrice,
        "price": price,
        "quantity": quantity == null ? null : quantity,
        "attributeCombination": attributeCombination,
        "attributeSetId": attributeSetId,
        "largeImage": largeImage,
        "mediumImage": mediumImage,
        "smallImage": smallImage,
        "videoEmbade": videoEmbade,
        "symbol": symbol,
        "productSubSkuDetailsRequestModels":
            List<dynamic>.from(productSubSkuDetailsRequestModels.map((x) => x)),
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
