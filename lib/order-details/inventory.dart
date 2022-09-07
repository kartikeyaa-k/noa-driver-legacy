import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/order-details/home.dart';
import 'package:noa_driver/utils/nav_utils.dart';
import 'package:provider/provider.dart';

import 'order-controller.dart';

class TruckDetails extends StatefulWidget {
  int? storeId;
  /*final inVoiceId;
  TruckDetails(this.inVoiceId);*/
  TruckDetails(this.storeId);
  @override
  State<TruckDetails> createState() => _TruckDetailsState();
}

class _TruckDetailsState extends State<TruckDetails> {
  int addressId = 0;

  @override
  void initState() {
    Provider.of<OrderController>(context, listen: false)
        .inventoryFilter(widget.storeId!);
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
              child: Container(
                margin: const EdgeInsets.all(12),
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: AppColors.Blue077C9E),
                child: Center(
                    child: Image.asset(
                  "assets/images/ic-back-noa-white.png",
                  height: 15,
                  width: 15,
                )),
              ),
            ),
            title: Text(
              "Inventory",
              style: TextStyle(
                  color: AppColors.defaultblack,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Container(
                    //
                    //   width: double.infinity,
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.only(
                    //         bottomLeft: Radius.circular(12),
                    //         bottomRight: Radius.circular(12)
                    //     ),
                    //     color: AppColors.Blue077C9E,
                    //   ),
                    //   child: Row(
                    //
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.only(left: 20),
                    //         height: 80,
                    //         width: 113,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.all(Radius.circular(8)),
                    //             color: AppColors.pureWhite
                    //         ),
                    //         child: Center(child: CachedNetworkImage(
                    //           imageUrl: '',
                    //           width: 65,
                    //           height: 65,
                    //           errorWidget: (ctx,url,error)=>Image.asset("assets/images/image-near-item.png"),
                    //         )),
                    //       ),
                    //       SizedBox(width: 10,),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text("Kibson",style: TextStyle(color: AppColors.pureWhite,fontSize: 22,fontWeight: FontWeight.w600),),
                    //           SizedBox(height: 5,),
                    //
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Image.asset("assets/images/ic-noa-location.png"),
                    //               SizedBox(width: 5,),
                    //               Text("2 KM",style: TextStyle(color: AppColors.pureWhite,fontSize: 12),),
                    //             ],
                    //           ),
                    //
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    /* SizedBox(height: 20,),

                    Row(
                      children: [
                        SizedBox(width: 20,),
                        Image.asset("assets/images/item-image3.png",width: 79,height: 79,),
                        SizedBox(width: 11,),
                        Image.asset("assets/images/category-fruits.png",width: 79,height: 79,),
                        SizedBox(width: 11,),
                        Image.asset("assets/images/category-vegetables.png",width: 79,height: 79,),
                        SizedBox(width: 11,),
                        Image.asset("assets/images/category-seafood.png",width: 79,height: 79,),
                        SizedBox(width: 20,),
                      ],
                    ),*/

                    /*  SizedBox(height: 20,),

                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 20,right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColors.pureWhite
                      ),
                      width: double.infinity,
                      child: TextField(
                        style: TextStyle(color: AppColors.defaultblack,fontSize: 11),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIcon: Image.asset("assets/images/ic-noa-search.png"),
                            hintText: "Search heare",
                            hintStyle: TextStyle(color: AppColors.gray8383,fontSize: 11)
                        ),
                      ),
                    ),*/

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: AppColors.pureWhite,
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
                      child: provider.productFilter != null
                          ? Container(
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8, bottom: 8),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.productFilter!
                                          .productListRequestModels!.isNotEmpty
                                      ? provider.productFilter!
                                          .productListRequestModels!.length
                                      : 0,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  (10 * 110)),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {},
                                      child: Container(
                                        width: 65,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            color: AppColors.pureWhite,
                                            border: Border.all(
                                                color: AppColors.Blue276184,
                                                width: 1)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 5, right: 5),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: provider
                                                          .productFilter!
                                                          .productListRequestModels![
                                                              index]
                                                          .productMasterMediaViewModels!
                                                          .isNotEmpty
                                                      ? '${provider.productFilter!.productListRequestModels![index].productMasterMediaViewModels![0].fileLocation}'
                                                      : "",
                                                  height: 120,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    "assets/images/image-item4.png",
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: 90,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                "${provider.productFilter!.productListRequestModels![index].productName}",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.defaultblack,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: "AED ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .defaultblack,
                                                        fontSize: 8)),
                                                TextSpan(
                                                    text:
                                                        "${provider.productFilter!.productListRequestModels![index].productSubSkuRequestModels![0].price} / ${provider.productFilter!.productListRequestModels![index].productSubSkuRequestModels![0].attributeCombination}  ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .Blue077C9E,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text:
                                                        "(${provider.productFilter!.productListRequestModels![index].productSubSkuRequestModels![0].subSKU})",
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.gray8383,
                                                        fontSize: 7)),
                                              ])),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${provider.productFilter!.productListRequestModels![index].productSubSkuRequestModels![0].quantity} units Left",
                                              style: TextStyle(
                                                color: AppColors.gray8383,
                                                fontSize: 13,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }))
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -0.5,
                left: 0.0,
                right: 0.0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      "assets/images/footernew.png",
                      width: 1000,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                NavUtils.push(
                                    context,
                                    Home(
                                      provider.custommerLogin!.supplierId,
                                      driverLogin: provider.custommerLogin!,
                                    ));
                              },
                              child: Image.asset(
                                "assets/images/ic-noa-home.png",
                                width: 24,
                                height: 24,
                              )),
                          Image.asset(
                            "assets/images/inventory-colored.png",
                            width: 24,
                            height: 24,
                          ),
                          GestureDetector(
                              onTap: () {
                                NavUtils.push(
                                    context,
                                    TruckDetails(
                                        provider.custommerLogin!.supplierId!));
                              },
                              child: Image.asset(
                                "assets/images/ic-noa-profile.png",
                                width: 24,
                                height: 24,
                              )),
                          Image.asset(
                            "assets/images/ic-noa-notification.png",
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
