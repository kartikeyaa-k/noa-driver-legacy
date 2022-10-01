import 'package:intl/intl.dart';

import 'customer_view_model.dart';

class CurrentOrderResponseData {
  final int? invoiceId;
  final int? driverId;
  final String? refNumber;
  final String? remark;
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
  final dynamic distance;
  final double? customerLatitued;
  final double? customerLongitued;
  final CustomerViewModel? customerViewModel;

  CurrentOrderResponseData({
    this.invoiceId,
    this.driverId,
    this.refNumber,
    this.remark,
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
    this.distance,
    this.customerLatitued,
    this.customerLongitued,
    this.customerViewModel,
  });

  CurrentOrderResponseData.fromJson(Map<String, dynamic> json)
      : invoiceId = json['invoiceId'] as int?,
        driverId = json['driverId'] as int?,
        refNumber = json['refNumber'] as String?,
        remark = json['remark'] as String?,
        productName = json['productName'],
        productImage = json['productImage'] as String?,
        driverShipmentId = json['driverShipmentId'] as int?,
        totalAmount = json['totalAmount'] as double?,
        invoiceDate = DateFormat("yyyy-mm-dd hh:mm:ss")
            .parse((json['invoiceDate'] as String).replaceAll('T', ' '))
            .toLocal()
            .toString(),
        deliveryDate = json['deliveryDate'],
        invoiceStatusId = json['invoiceStatusId'] as int?,
        invoiceStatusName = json['invoiceStatusName'] as String?,
        paymentStatus = json['paymentStatus'] as int?,
        customerId = json['customerId'] as int?,
        storeId = json['storeId'] as int?,
        distance = json['distance'],
        customerLatitued = json['customerLatitued'] as double?,
        customerLongitued = json['customerLongitued'] as double?,
        customerViewModel =
            (json['customerViewModel'] as Map<String, dynamic>?) != null
                ? CustomerViewModel.fromJson(
                    json['customerViewModel'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
        'invoiceId': invoiceId,
        'driverId': driverId,
        'refNumber': refNumber,
        'productName': productName,
        'productImage': productImage,
        'driverShipmentId': driverShipmentId,
        'totalAmount': totalAmount,
        'invoiceDate': invoiceDate,
        'deliveryDate': deliveryDate,
        'invoiceStatusId': invoiceStatusId,
        'invoiceStatusName': invoiceStatusName,
        'paymentStatus': paymentStatus,
        'customerId': customerId,
        'storeId': storeId,
        'distance': distance,
        'customerLatitued': customerLatitued,
        'customerLongitued': customerLongitued,
        'customerViewModel': customerViewModel?.toJson()
      };
}
