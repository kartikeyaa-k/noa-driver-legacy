class DriverLogin {
  DriverLogin({
    this.storeId,
    this.supplierId,
    this.shopName,
    this.supplierName,
    this.mobile,
    this.landPhone,
    this.email,
    this.address,
    this.largeImage,
    this.mediumImage,
    this.smallImage,
    this.parentId,
    this.latitued,
    this.longitued,
    this.description,
    this.countryId,
    this.stateId,
    this.cityId,
    this.countryImage,
    this.isService,
    this.previousLatitued,
    this.previousLongitued,
    this.distance,
    this.distanceTime,
    this.firebaseToken,
    this.token = '',
  });

  int? storeId;
  int? supplierId;
  String? shopName;
  String? supplierName;
  String? mobile;
  String? landPhone;
  String? email;
  String? address;
  String? largeImage;
  String? mediumImage;
  String? smallImage;
  int? parentId;
  String? latitued;
  String? longitued;
  String? description;
  int? countryId;
  int? stateId;
  int? cityId;
  String? countryImage;
  bool? isService;
  String? previousLatitued;
  String? previousLongitued;
  dynamic distance;
  dynamic distanceTime;
  dynamic firebaseToken;
  String token;

  factory DriverLogin.fromJson(Map<String?, dynamic> json) => DriverLogin(
        storeId: json["storeId"],
        supplierId: json["supplierId"],
        shopName: json["shopName"],
        supplierName: json["supplierName"],
        mobile: json["mobile"],
        landPhone: json["landPhone"],
        email: json["email"],
        address: json["address"],
        largeImage: json["largeImage"],
        mediumImage: json["mediumImage"],
        smallImage: json["smallImage"],
        parentId: json["parentId"],
        latitued: json["latitued"],
        longitued: json["longitued"],
        description: json["description"],
        countryId: json["countryId"],
        stateId: json["stateId"],
        cityId: json["cityId"],
        countryImage: json["countryImage"],
        isService: json["isService"],
        previousLatitued: json["previousLatitued"],
        previousLongitued: json["previousLongitued"],
        distance: json["distance"],
        distanceTime: json["distanceTime"],
        firebaseToken: json["firebaseToken"],
        token: json["token"],
      );

  Map<String?, dynamic> toJson() => {
        "storeId": storeId,
        "supplierId": supplierId,
        "shopName": shopName,
        "supplierName": supplierName,
        "mobile": mobile,
        "landPhone": landPhone,
        "email": email,
        "address": address,
        "largeImage": largeImage,
        "mediumImage": mediumImage,
        "smallImage": smallImage,
        "parentId": parentId,
        "latitued": latitued,
        "longitued": longitued,
        "description": description,
        "countryId": countryId,
        "stateId": stateId,
        "cityId": cityId,
        "countryImage": countryImage,
        "isService": isService,
        "previousLatitued": previousLatitued,
        "previousLongitued": previousLongitued,
        "distance": distance,
        "distanceTime": distanceTime,
        "firebaseToken": firebaseToken,
      };
}
