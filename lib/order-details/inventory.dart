import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/core/style/styles.dart';
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
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Paints.primaryBlueDarker,
            ),
            backgroundColor: Paints.primaryBlueDarker,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
            title: const Text('Inventory'),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
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
            ],
          ),
        );
      },
    );
  }
}
