import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/components/snackbar/primary_snackbar.dart';
import 'package:noa_driver/core/helpers/app_helpers.dart';
import 'package:noa_driver/utils/date-time-utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/customer_view_model.dart';
import 'order-controller.dart';

class OrderDetailsSingleItems extends StatefulWidget {
  CustomerViewModel? customerViewModel;
  double? totalAmmount;
  String? orderNumber;
  String? paymentStatus;
  int index;
  int? inVoiceId;
  String? invoiceStatus;
  String? preOrCurrent;
  String? firebaseToken;
  OrderDetailsSingleItems(this.customerViewModel, this.totalAmmount,
      this.orderNumber, this.paymentStatus, this.index, this.inVoiceId,
      {this.invoiceStatus, this.preOrCurrent, this.firebaseToken});

  @override
  _OrderDetailsSingleItemsState createState() =>
      _OrderDetailsSingleItemsState();
}

class _OrderDetailsSingleItemsState extends State<OrderDetailsSingleItems> {
  @override
  void initState() {
    Provider.of<OrderController>(context, listen: false)
        .getOrderDetails('0', widget.inVoiceId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.pureWhite,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: backBtn(),
            ),
            title: Image.asset("assets/images/ic-noa-colored.png"),
            centerTitle: true,
          ),
          body: provider.orderDetailsList != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      /*  ListView(
                    shrinkWrap: true,
                    children: [
                      Stack(
                        children: [

                          Positioned(
                            child: Container(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20,),


                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      // push done

                    ],
                  ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: AppColors.pureWhite,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 7,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: AppColors.Blue077C9E,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          color:
                                              AppColors.Blue077C9E.withOpacity(
                                                  0.3),
                                          border: Border.all(
                                              color: AppColors.pureWhite,
                                              width: 2)),
                                      child: Center(
                                          child: Text(
                                        "#${widget.index + 1}",
                                        style: TextStyle(
                                            color: AppColors.pureWhite,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.customerViewModel!.firstLastName}",
                                          style: TextStyle(
                                              color: AppColors.pureWhite,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        /*Container(
                                        width: 150,
                                        child: Text("${widget.customerViewModel!.customerAddressViewModel!.addressType}, ${widget.customerViewModel!.customerAddressViewModel!.address}, ${widget.customerViewModel!.customerAddressViewModel!.countryName}",style: TextStyle(color: AppColors.pureWhite,fontSize: 10,),)),*/
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                "Order No:",
                                                style: TextStyle(
                                                  color: AppColors.pureWhite,
                                                  fontSize: 11,
                                                ),
                                                maxLines: 2,
                                              )),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Flexible(
                                                  child: Text(
                                                "${widget.orderNumber}",
                                                style: TextStyle(
                                                    color: AppColors.pureWhite,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 2,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                            color: AppColors.pureWhite,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Flexible(
                                          child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "AED ",
                                                  style: TextStyle(
                                                    color: AppColors.pureWhite,
                                                    fontSize: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: provider
                                                      .orderDetailsList!
                                                      .totalAmount
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColors.pureWhite,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ])),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    leading: SizedBox(
                                        child: Text(
                                      "${widget.paymentStatus == 1 ? "Online" : ""}\nPayment",
                                      style: TextStyle(
                                          color: AppColors.pureWhite,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    )),
                                    trailing: Text(
                                      widget.invoiceStatus!,
                                      style: TextStyle(
                                          color: AppColors.pureWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Item Details",
                                  style: TextStyle(
                                      color: AppColors.Blue077C9E,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: provider
                                              .orderDetailsList!
                                              .invoiceDetailsViewModels!
                                              .length >
                                          0
                                      ? provider.orderDetailsList!
                                          .invoiceDetailsViewModels!.length
                                      : 0,
                                  itemBuilder: (ctx, i) {
                                    return Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8)),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "${provider.orderDetailsList!.invoiceDetailsViewModels![i].mediumImage}",
                                                        height: 50,
                                                        width: 70,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (ctx, uarl,
                                                                error) =>
                                                            ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            8)),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/golden-apple.png",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 70,
                                                                  height: 50,
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          width: 120,
                                                          child: Text(
                                                            "${provider.orderDetailsList!.invoiceDetailsViewModels![i].productName}",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .defaultblack,
                                                                fontSize: 13),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                              height: 15,
                                                              width: 15,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5)),
                                                                  color: AppColors
                                                                      .LightRedFAF2EE,
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .DeepYelowF37226)),
                                                              child: Center(
                                                                  child: Text(
                                                                provider
                                                                    .orderDetailsList!
                                                                    .invoiceDetailsViewModels![
                                                                        i]
                                                                    .quantity!
                                                                    .toInt()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .DeepYelowF37226,
                                                                    fontSize:
                                                                        10),
                                                              ))),
                                                          //const SizedBox(width: 10,),
                                                          //Text("2 Kg  (8/Kg)",style: TextStyle(color: AppColors.gray8383,fontSize:9),overflow: TextOverflow.ellipsis,)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "AED",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .defaultblack,
                                                        fontSize: 8),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${provider.orderDetailsList!.invoiceDetailsViewModels![i].price}",
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.Blue077C9E,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            child: Divider(
                                          color: AppColors.grayDBDBDB,
                                          thickness: 2,
                                        )),
                                      ],
                                    );
                                  }),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Sub total",
                                        style: TextStyle(
                                          color: AppColors.defaultblack,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "(Including VAT )",
                                        style: TextStyle(
                                          color: AppColors.gray8383,
                                          fontSize: 8,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "AED",
                                        style: TextStyle(
                                          color: AppColors.defaultblack,
                                          fontSize: 8,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "${provider.orderDetailsList!.totalAmount}",
                                        style: TextStyle(
                                            color: AppColors.defaultblack,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  /*   Row(
                                           children: [


                                             Text("Delivery charge",style: TextStyle(color: AppColors.defaultblack,fontSize: 12,),),

                                             const Spacer(),
                                             Text("AED",style: TextStyle(color: AppColors.defaultblack,fontSize: 8,),),
                                             const SizedBox(width: 4,),
                                             Text("0",style: TextStyle(color: AppColors.defaultblack,fontSize: 15,fontWeight: FontWeight.bold),),
                                           ],
                                         ),
                                         const SizedBox(height: 10,),*/
                                  Row(
                                    children: [
                                      Text(
                                        "Discount",
                                        style: TextStyle(
                                            color: AppColors.defaultblack,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "- AED",
                                        style: TextStyle(
                                          color: AppColors.defaultblack,
                                          fontSize: 8,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                            color: AppColors.defaultblack,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 45,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: AppColors.pureWhite,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Total Payable Amount",
                                          style: TextStyle(
                                              color: AppColors.defaultblack,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "AED",
                                          style: TextStyle(
                                            color: AppColors.defaultblack,
                                            fontSize: 8,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "${provider.orderDetailsList!.totalAmount}",
                                          style: TextStyle(
                                              color: AppColors.Blue077C9E,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(10)),
                          color: AppColors.pureWhite,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 7,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Details",
                                  style: TextStyle(
                                      color: AppColors.Blue077C9E,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            provider.orderDetailsList!
                                    .customInputDataRequestModels!.isEmpty
                                ? const SizedBox.shrink()
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: provider.orderDetailsList!
                                        .customInputDataRequestModels!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              provider
                                                          .orderDetailsList!
                                                          .customInputDataRequestModels![
                                                              index]
                                                          .name ==
                                                      ""
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      provider
                                                          .orderDetailsList!
                                                          .customInputDataRequestModels![
                                                              index]
                                                          .name!,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .pureBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              provider
                                                          .orderDetailsList!
                                                          .customInputDataRequestModels![
                                                              index]
                                                          .value ==
                                                      ""
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      provider
                                                          .orderDetailsList!
                                                          .customInputDataRequestModels![
                                                              index]
                                                          .value!,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.pureBlack,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          provider
                                                      .orderDetailsList!
                                                      .customInputDataRequestModels![
                                                          index]
                                                      .images!
                                                      .isEmpty ||
                                                  provider
                                                          .orderDetailsList!
                                                          .customInputDataRequestModels![
                                                              index]
                                                          .images ==
                                                      null
                                              ? const SizedBox.shrink()
                                              : /*ListView.builder(

                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider.orderDetailsList!.customInputDataRequestModels![index].images!.length,
                                      itemBuilder: (context, index2){
                                    return CachedNetworkImage(
                                      imageUrl: provider.orderDetailsList!.customInputDataRequestModels![index].images![index2],
                                      height: 70,
                                      width: 70,
                                      fit:BoxFit.cover,
                                      errorWidget: (ctx,uarl,error)=>Image.asset("assets/images/image_not_available.png",fit: BoxFit.cover,width: 70,height: 50,),
                                    );
                                  }),*/
                                              Wrap(
                                                  runSpacing: 5,
                                                  spacing: 5,
                                                  children: provider
                                                      .orderDetailsList!
                                                      .customInputDataRequestModels![
                                                          index]
                                                      .images!
                                                      .map((e) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    right: 8),
                                                            child: InkWell(
                                                              onTap: () =>
                                                                  _openImageView(
                                                                      context,
                                                                      e),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: e,
                                                                height: 150,
                                                                width: 70,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorWidget: (ctx,
                                                                        uarl,
                                                                        error) =>
                                                                    Image.asset(
                                                                  "assets/images/image_not_available.png",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 70,
                                                                  height: 70,
                                                                ),
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                ),
                                        ],
                                      );
                                    }),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Order Number",
                              style: TextStyle(
                                color: AppColors.pureBlack,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${provider.orderDetailsList!.refNumber}",
                              style: TextStyle(
                                  color: AppColors.pureBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Payment",
                              style: TextStyle(
                                color: AppColors.pureBlack,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.paymentStatus == 1
                                  ? "Online Payment"
                                  : "Payment",
                              style: TextStyle(
                                  color: AppColors.pureBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Date",
                              style: TextStyle(
                                color: AppColors.pureBlack,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${provider.orderDetailsList!.createdAt != null && provider.orderDetailsList != "" ? DateTimeUtil.getFormatedDateTimeFromServerFormat(provider.orderDetailsList!.createdAt!) : ""}",
                              style: TextStyle(
                                  color: AppColors.pureBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Mobile Number",
                              style: TextStyle(
                                color: AppColors.pureBlack,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${provider.orderDetailsList!.customerViewModel!.phoneNo}",
                              style: TextStyle(
                                  color: AppColors.pureBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Deliver to",
                                      style: TextStyle(
                                        color: AppColors.pureBlack,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${provider.orderDetailsList!.customerViewModel!.firstLastName}",
                                      style: TextStyle(
                                          color: AppColors.pureBlack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    /*Container(
                                    width: 130,
                                    child: Text("${provider.orderDetailsList!.customerViewModel!.customerAddressViewModels![0].addressType ?? ""}"
                                        ", ${provider.orderDetailsList!.customerViewModel!.customerAddressViewModels![0].address ?? ""}"
                                        ", ${provider.orderDetailsList!.customerViewModel!.customerAddressViewModels![0].addressLine2 ?? ""}"
                                        ", ${provider.orderDetailsList!.customerViewModel!.customerAddressViewModels![0].buildingName ?? ""}",style: TextStyle(color: AppColors.gray8383,fontSize: 10,),)),
*/
                                  ],
                                ),
                                const Spacer(),
                                /* GestureDetector(
                              onTap: (){
                                //_launchMapsUrl(provider.orderDetailsList!.customerLatitued!,provider.currentOrderList[index]!.customerLongitued!);
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                  color: AppColors.pureWhite,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1), // changes position of shadow
                                    ),
                                  ],

                                ),
                                child: Center(child: Image.asset("assets/images/google-maps.png")),
                              ),
                            ),*/
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          bottomSheet: widget.preOrCurrent == "Pre"
              ? const SizedBox.shrink()
              : Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(color: AppColors.pureWhite),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (provider.orderDetailsList!.remark != null) {
                              var firebaseToken = provider
                                  .orderDetailsList!.remark
                                  ?.split('#')
                                  .last;
                              var customerName = provider.orderDetailsList!
                                  .customerViewModel?.firstLastName;
                              await AppHelper.sendNotificationOnTheWay(
                                  context: context,
                                  firebaseToken: firebaseToken!,
                                  userName: customerName);
                              // Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(
                                  'Failed to send order confirmation notification',
                                ),
                              );
                            }

                            provider
                                .updateOrderStauts(
                                    provider.orderDetailsList!
                                        .invoiceViewModels![0].invoiceId!,
                                    16)
                                .then((value) {
                              //print("VALUEEEEE"+value.toString());
                              if (value) {
                                Fluttertoast.showToast(
                                    msg: "Order Updated",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context, true);
                              }
                            });
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              border: Border.all(color: AppColors.green00AF17),
                              color: AppColors.pureWhite,
                            ),
                            child: Center(
                                child: Text(
                              "Confirm Order",
                              style: TextStyle(
                                  color: AppColors.green00AF17,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (provider.orderDetailsList!.remark != null) {
                              var firebaseToken = provider
                                  .orderDetailsList!.remark
                                  ?.split('#')
                                  .last;
                              var customerName = provider.orderDetailsList!
                                  .customerViewModel?.firstLastName;
                              var userId =
                                  widget.customerViewModel!.customerId!;
                              var title = 'Noa Market';
                              var body =
                                  'We hope you loved using Noa. For any issues or feedback, please reach out to us on WhatsApp 0585387662 or via email at hello@noa.market.';
                              await Provider.of<OrderController>(context,
                                      listen: false)
                                  .sendNotificationToCustomer(
                                      firebaseToken: firebaseToken!,
                                      userId: userId,
                                      title: title,
                                      body: body);

                              await AppHelper.sendNotificationOrderCompleted(
                                  context: context,
                                  firebaseToken: firebaseToken!,
                                  userName: customerName);
                              // Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(
                                  'Failed to send order delivered notification',
                                ),
                              );
                            }

                            provider
                                .updateOrderStauts(
                                    provider.orderDetailsList!
                                        .invoiceViewModels![0].invoiceId!,
                                    4)
                                .then((value) {
                              if (value) {
                                Fluttertoast.showToast(
                                    msg: "Order Complete",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context, true);
                              }
                            });
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(100)),
                              border: Border.all(color: AppColors.Blue077C9E),
                              color: AppColors.pureWhite,
                            ),
                            child: Center(
                                child: Text(
                              "Complete Order",
                              style: TextStyle(
                                  color: AppColors.Blue077C9E,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            makeCall(provider
                                .orderDetailsList!.customerViewModel!.phoneNo!);
                          },
                          child: Image.asset(
                            "assets/images/ic-call.png",
                            height: 50,
                            width: 50,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _launchMapsUrl(double lat, double lon) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lon&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  void makeCall(String phoneNo) async {
    /* Uri uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon');
*/
    var uri = Uri(
      scheme: 'tel',
      path: phoneNo,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  _openImageView(
    BuildContext context,
    String imgUrl,
  ) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 900,
        width: 428,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: NetworkImage(
                imgUrl,
              ),
              loadingBuilder: (context, imageChunk) => const SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              errorBuilder: (context, error, stackTrace) {
                return const Text("Error Occured!");
              },
            ), // back button
            Positioned(
              left: 0,
              top: 0,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => Navigator.pop(context),
                child: backBtn(),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget backBtn() {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          color: AppColors.Blue077C9E),
      child: Center(
        child: Image.asset(
          "assets/images/ic-back-noa-white.png",
          height: 15,
          width: 15,
        ),
      ),
    );
  }
}
