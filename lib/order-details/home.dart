import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:noa_driver/address/views/delivery_address.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/components/buttons/primary_button.dart';
import 'package:noa_driver/components/snackbar/primary_snackbar.dart';
import 'package:noa_driver/core/helpers/app_helpers.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/core/style/styles.dart';
import 'package:noa_driver/drawer/drawer.dart';
import 'package:noa_driver/login-registration/model/custommer-login.dart';
import 'package:noa_driver/main.dart';
import 'package:noa_driver/order-details/driver-profile.dart';
import 'package:noa_driver/utils/date-time-utils.dart';
import 'package:noa_driver/utils/nav_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'inventory.dart';
import 'order-controller.dart';
import 'order-details.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}

class Home extends StatefulWidget {
  int? DriverId;
  DriverLogin? driverLogin;
  Home(this.DriverId, {Key? key, this.driverLogin}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _ordersListController = ScrollController();
  bool stoppingFlag = false;
  Timer? _timer;
  bool isCurrent = true;

  int year = 2022;
  int mont = 03;
  int day = 2;

  String dates = "";
  String currentSelectedCommunityFromDropdownName = '';
  String currentSelectedSubCommunityFromDropdownName = '';
  List<SubCommunityModel> currentSelectedSubCommunity = [];
  DateTime dateTime = DateTime(2022, 03, 02);

  bool isOnline = false;

  // MAIN FUNCTIONS
  void _scrollDown() {
    _ordersListController.animateTo(
      _ordersListController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> setNotificationSubscriptionTopics() async {
    if (widget.driverLogin != null && widget.driverLogin?.supplierId != null) {
      var supplierId = widget.driverLogin!.supplierId;
      await messaging.subscribeToTopic(supplierId.toString()).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          getSnackBar(
            'Subscribed to receive notifications',
          ),
        );
      });
    }
  }

  Future<void> setDriverLocation(
      List<SubCommunityModel> subCommunityIds) async {
    print(
        '==================== DRIVER LOCATION UPDATE : Setting driver subcommunity as $subCommunityIds ====================');
    if (subCommunityIds.isEmpty) {
      Smartlook.trackCustomEvent('driver_status', {
        'storeID': '${widget.driverLogin?.storeId.toString()}',
        'storeName': '${widget.driverLogin?.shopName.toString()}',
        'isOnline': false,
        'subCommunities': '',
        'communityName': '',
      });
    } else {
      var subCommunities =
          currentSelectedSubCommunity.map((e) => e.name).toString();
      var communityName = currentSelectedCommunityFromDropdownName;
      Smartlook.trackCustomEvent('driver_status', {
        'storeID': '${widget.driverLogin?.storeId.toString()}',
        'storeName': '${widget.driverLogin?.shopName.toString()}',
        'isOnline': true,
        'subCommunities': subCommunities,
        'communityName': communityName,
      });
    }

    await Provider.of<OrderController>(context, listen: false)
        .locatePosition(widget.driverLogin!.storeId!, subCommunityIds);
  }

  void startFetchingOrderDetailsAtInterval() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      print(
          '============================================= FETCHING ORDERS AT 10s(${timer.tick}) ===============================================');
      if (timer.tick > 2) {
        // Is not the first time
        Provider.of<OrderController>(context, listen: false)
            .getCourrentOrder(widget.driverLogin!.storeId!, isFirstTime: false);
      } else {
        // first time api call
        Provider.of<OrderController>(context, listen: false)
            .getCourrentOrder(widget.driverLogin!.storeId!, isFirstTime: true);
      }
    });
  }

  getTruckOnlineStatus() async {
    await Provider.of<OrderController>(context, listen: false)
        .getTruckOnlineStatus(widget.driverLogin!.storeId!)
        .then((store) {
      if (store != null) {
        currentSelectedSubCommunity.clear();

        setState(() {
          isOnline = store.isOnline;
          Provider.of<OrderController>(context, listen: false).isLocationon =
              store.isOnline;
          currentSelectedCommunityFromDropdownName = store.communityName;
          currentSelectedSubCommunity
              .addAll(store.subCommunitiesOnlineList ?? []);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<OrderController>(context, listen: false).determinePosition();
    getTruckOnlineStatus();
    startFetchingOrderDetailsAtInterval();
    // setDriverLocation([]);
    setNotificationSubscriptionTopics();
    Provider.of<OrderController>(context, listen: false)
        .getPreviousOrderedItems(
      widget.driverLogin!.storeId!,
    );
    Provider.of<OrderController>(context, listen: false).getUserData();

    //   Provider.of<OrderController>(context, listen: false).locatePosition(widget.DriverId!);
    // if (!stoppingFlag) {
    //   sendingSignal();
    // }
    dates = "$year-$mont-$day";
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () async => setState(
          () {
            getTruckOnlineStatus();
            Provider.of<OrderController>(context, listen: false)
                .getCourrentOrder(widget.driverLogin!.storeId!);
            Provider.of<OrderController>(context, listen: false)
                .getPreviousOrderedItems(widget.driverLogin!.storeId!);
          },
        ),
      ),
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (mounted) {
        _scrollDown();
      }
    });

    setSmartlookIdentifier();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  setSmartlookIdentifier() async {
    await Smartlook.setUserIdentifier('driver & supplier data', {
      "shopName": widget.driverLogin?.shopName.toString(),
      "supplierName": widget.driverLogin?.supplierName.toString(),
      'storeID': widget.driverLogin?.storeId.toString(),
      'subcommunity': widget.driverLogin?.supplierId.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Consumer<OrderController>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
              ),
              backgroundColor: AppColors.pureWhite,
              leading: GestureDetector(
                  onTap: () {
                    NavUtils.push(
                        context, DrawerCustom(provider.custommerLogin));
                  },
                  child: const Icon(
                    Icons.menu_rounded,
                    color: Paints.primary,
                  )),
              title: SizedBox(
                  height: 30,
                  child: Image.asset("assets/images/ic-noa-colored.png")),
              centerTitle: true,
              // simple test to check
              actions: [
                Transform.scale(
                  scale: 1.0,
                  child: Switch(
                      activeColor: Paints.green,
                      value: isOnline,
                      onChanged: (value) {
                        provider.isLocationon = value;
                        setState(() {
                          isOnline = value;
                        });

                        if (isOnline == false) {
                          currentSelectedCommunityFromDropdownName = '';
                          currentSelectedSubCommunityFromDropdownName = '';
                          currentSelectedSubCommunity.clear();
                          setDriverLocation([]);
                        }
                        // if (provider.isLocationon == true) {
                        // if (!stoppingFlag) {
                        //   sendingSignal();
                        // }
                        // } else if (provider.isLocationon == false) {
                        // _timer!.cancel();

                        // setState(() {
                        //   stoppingFlag = false;
                        // });

                        // Provider.of<OrderController>(context, listen: false)
                        //     .locatePosition(widget.driverLogin!.storeId!, null);
                        // provider.driverLocationInput(
                        //   widget.driverLogin!.storeId!,
                        //   const LatLng(0, 0),
                        // );
                        // requesting again to make sure location set to null.
                        // Future.delayed(
                        //   const Duration(seconds: 3),
                        //   () {
                        // provider.driverLocationInput(
                        //   widget.driverLogin!.storeId!,
                        //   const LatLng(0, 0),
                        // );
                        //   },
                        // );
                        // _timer!.cancel();
                        // }
                      }),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: PrimaryButton(
                    padding: const EdgeInsets.all(8),
                    onTap: () {
                      if (isOnline) {
                        if (widget.DriverId != null) {
                          NavUtils.push(
                              context,
                              DeliveryAddressPage(
                                driverLogin: widget.driverLogin,
                                driverId: widget.DriverId.toString(),
                                onSubmitAddress: (
                                  String communityName,
                                  List<SubCommunityModel>
                                      currentSelectedSubCommunityFromDropdown,
                                ) {
                                  setState(() {
                                    isOnline = true;
                                    currentSelectedCommunityFromDropdownName =
                                        communityName;

                                    currentSelectedSubCommunity.clear();
                                    currentSelectedSubCommunity.addAll(
                                        currentSelectedSubCommunityFromDropdown);
                                  });

                                  setDriverLocation(
                                      currentSelectedSubCommunity);
                                },
                              ));
                        }
                      }
                    },
                    icon: Image.asset(
                      "assets/images/mike_icon.png",
                      fit: BoxFit.cover,
                      color: isOnline ? Paints.background : Colors.black,
                    ),
                    text: '',
                    backgroundColor: isOnline ? Paints.red : Paints.disable,
                  ),
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: Paints.primaryBlue, boxShadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            spreadRadius: 1,
                            blurRadius: 8,
                            color: Paints.primaryBlueDarker.withOpacity(0.3))
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Column(
                          children: [
                            Text(
                              "${provider.custommerLogin?.shopName}",
                              style: TextStyles.h1
                                  .copyWith(color: Paints.primaryBlueDarker),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            if (!provider.isLocationon)
                              Text(
                                "You are offline",
                                style: TextStyles.body12x400
                                    .copyWith(color: Paints.primaryBlueDarker),
                                textAlign: TextAlign.center,
                              )
                            else if (currentSelectedSubCommunity.isEmpty)
                              Text(
                                "No Community Selected. You are not visible to customers.",
                                style: TextStyles.body12x400
                                    .copyWith(color: Paints.primaryBlueDarker),
                                textAlign: TextAlign.center,
                              )
                            else
                              Center(
                                child: Text(
                                  currentSelectedSubCommunity
                                          .map((e) => e.name)
                                          .toString() +
                                      ' - ' +
                                      currentSelectedCommunityFromDropdownName,
                                  style: TextStyles.body12x400.copyWith(
                                      color: Paints.primaryBlueDarker),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: Paints.primaryBlue, boxShadow: [
                        const BoxShadow(
                            offset: Offset(-1, -1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: Colors.transparent),
                        BoxShadow(
                            offset: const Offset(2, 8),
                            spreadRadius: 1,
                            blurRadius: 12,
                            color: Paints.primaryBlueDarker.withOpacity(0.3))
                      ]),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isCurrent = true;
                                    });
                                  },
                                  child: Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: isCurrent
                                              ? Paints.primaryOrange
                                              : Colors.transparent),
                                    )),
                                    child: Center(
                                        child: Text(
                                      "New Orders",
                                      style: TextStyle(
                                        color: AppColors.Blue077C9E,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: GestureDetector(
                                  onTap: () => setState(
                                    () => isCurrent = false,
                                  ),
                                  child: Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: isCurrent
                                              ? Colors.transparent
                                              : Paints.primaryOrange),
                                    )),
                                    child: Center(
                                      child: Text(
                                        "Completed Orders",
                                        style: TextStyle(
                                          color: AppColors.Blue077C9E,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),

                    //-----------

                    const SizedBox(
                      height: 25,
                    ),
                    isCurrent
                        ? Expanded(
                            child: RefreshIndicator(
                              onRefresh: _pullRefresh,
                              child: provider.currentOrderList.isNotEmpty
                                  ? ListView.builder(
                                      controller: _ordersListController,
                                      shrinkWrap: true,
                                      itemCount:
                                          provider.currentOrderList.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (ctx, index) {
                                        var temp =
                                            provider.currentOrderList[index];

                                        var communityId = provider
                                            .currentOrderList[index]
                                            ?.customerViewModel
                                            ?.customerAddressViewModels
                                            ?.first
                                            .nearByLocation;

                                        var subCommunityId = provider
                                            .currentOrderList[index]
                                            ?.customerViewModel
                                            ?.customerAddressViewModels
                                            ?.first
                                            .buildingName;

                                        var communityName =
                                            AppHelper.getCommunityNameFromId(
                                                mainCommunityList, communityId);

                                        var subCommunityName =
                                            AppHelper.getSubCommunityNameFromId(
                                                mainSubCommunityList,
                                                subCommunityId);

                                        var villa = provider
                                                .currentOrderList[index]
                                                ?.customerViewModel
                                                ?.customerAddressViewModels
                                                ?.first
                                                .address ??
                                            '';

                                        var streetName = provider
                                                .currentOrderList[index]
                                                ?.customerViewModel
                                                ?.customerAddressViewModels
                                                ?.first
                                                .addressLine2 ??
                                            '';

                                        var orderAddress = villa +
                                            ', ' +
                                            streetName +
                                            ', ' +
                                            subCommunityName +
                                            ', ' +
                                            communityName;

                                        // if (provider.currentOrderList[index] !=
                                        //     null) {
                                        //   if (provider.currentOrderList[index]
                                        //           ?.customerViewModel !=
                                        //       null) {
                                        //     if (provider
                                        //         .currentOrderList[index]!
                                        //         .customerViewModel!
                                        //         .customerAddressViewModels!
                                        //         .isNotEmpty) {
                                        //   }
                                        //   }
                                        // }

                                        return InkWell(
                                          onTap: () {
                                            // NavUtils.push(context, MyOrderDetails(provider.myorderList[index]!.invoiceDetailsViewModels,provider.myorderList[index]!.invoiceViewModels![0],"","", provider.myorderList[index]!.totalAmount!,provider.myorderList[index]!.invoiceViewModels![0].status!));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: AppColors.pureWhite,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    ListTile(
                                                      leading: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          100)),
                                                              color: AppColors
                                                                      .Blue077C9E
                                                                  .withOpacity(
                                                                      0.3),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              "#${index + 1}",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .Blue077C9E,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )),
                                                          ),
                                                          Text(
                                                            "${provider.currentOrderList[index]!.invoiceStatusName} Order",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .green00AF17,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      title: Text(
                                                        "${provider.currentOrderList[index]!.customerViewModel?.firstLastName?.toUpperCase()}",
                                                        style: TextStyles
                                                            .body14x700,
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                              width: 150,
                                                              child: Text(
                                                                orderAddress,
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .gray8383,
                                                                  fontSize: 10,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Order No : ",
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .gray8383,
                                                              fontSize: 11,
                                                            ),
                                                            maxLines: 2,
                                                          ),
                                                          Text(
                                                            "${provider.currentOrderList[index]?.refNumber}",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .gray8383,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              // var lat =
                                                              //   if (provider
                                                              //               .currentOrderList[
                                                              //                   index]!
                                                              //               .customerLatitued !=
                                                              //           null &&
                                                              //       provider
                                                              //               .currentOrderList[
                                                              //                   index]!
                                                              //               .customerLongitued !=
                                                              //           null) {
                                                              //     _launchMapsUrl(
                                                              //         provider
                                                              //             .currentOrderList[
                                                              //                 index]!
                                                              //             .customerLatitued!,
                                                              //         provider
                                                              //             .currentOrderList[
                                                              //                 index]!
                                                              //             .customerLongitued!);
                                                              //   } else {
                                                              _launchMapsTextSearch(
                                                                  orderAddress);
                                                              // }
                                                            },
                                                            child: Container(
                                                              height: 35,
                                                              width: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            100)),
                                                                color: AppColors
                                                                    .pureWhite,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    spreadRadius:
                                                                        3,
                                                                    blurRadius:
                                                                        2,
                                                                    offset: const Offset(
                                                                        0,
                                                                        1), // changes position of shadow
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/images/google-maps.png")),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Divider(
                                                      color:
                                                          AppColors.grayDBDBDB,
                                                      thickness: 1,
                                                    ),
                                                    Text(
                                                      provider
                                                          .currentOrderList[
                                                              index]!
                                                          .invoiceDate!,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .gray8383,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                          child: FittedBox(
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Total Price: ",
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .defaultblack,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        " AED ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .Blue077C9E,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        "${provider.currentOrderList[index]?.totalAmount?.toStringAsFixed(2)} ",
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .Blue077C9E,
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ])),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              makeCall(provider
                                                                  .currentOrderList[
                                                                      index]!
                                                                  .customerViewModel!
                                                                  .phoneNo!);
                                                            },
                                                            child: Image.asset(
                                                              "assets/images/ic-call.png",
                                                              width: 22,
                                                              height: 22,
                                                            )),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 24),
                                                      child: PrimaryButton(
                                                        height: 34,
                                                        textStyle: TextStyles
                                                            .body12x500
                                                            .copyWith(
                                                                color: Paints
                                                                    .primary),
                                                        onTap: () async {
                                                          // Get Order details first
                                                          var invoiceID = provider
                                                              .currentOrderList[
                                                                  index]!
                                                              .invoiceId;

                                                          await Provider.of<
                                                                      OrderController>(
                                                                  context,
                                                                  listen: false)
                                                              .getOrderDetails(
                                                                  '0',
                                                                  invoiceID
                                                                      .toString())
                                                              .then(
                                                                  (currentOrder) {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                              OrderDetailsSingleItems(
                                                                                provider.currentOrderList[index]!.customerViewModel,
                                                                                provider.currentOrderList[index]!.totalAmount!.toDouble(),
                                                                                provider.currentOrderList[index]!.refNumber,
                                                                                "${provider.currentOrderList[index]!.paymentStatus ?? "0"}",
                                                                                index,
                                                                                provider.currentOrderList[index]!.invoiceId,
                                                                                preOrCurrent: "Curr",
                                                                                invoiceStatus: provider.currentOrderList[index]!.invoiceStatusName,
                                                                                firebaseToken: provider.currentOrderList[index]!.remark,
                                                                              )),
                                                                )
                                                                .then((val) => val
                                                                    ? _getRequests()
                                                                    : null);
                                                          });

                                                          /*  NavUtils.push(context, OrderDetailsSingleItems(provider.currentOrderList[index]!.customerViewModel,provider.currentOrderList[index]!.totalAmount!.toDouble(),provider.currentOrderList[index]!.refNumber,"${provider.currentOrderList[index]!.paymentStatus!=null?provider.currentOrderList[index]!.paymentStatus:"0"}",index,provider.currentOrderList[index]!.invoiceId,
                                                  preOrCurrent: "Curr",
                                                  invoiceStatus: provider.currentOrderList[index]!.invoiceStatusName,));*/
                                                        },
                                                        text: 'View Order',
                                                        backgroundColor:
                                                            Paints.primaryBlue,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    //                                                   Padding(
                                                    //                                                     padding: const EdgeInsets
                                                    //                                                             .symmetric(
                                                    //                                                         horizontal: 24),
                                                    //                                                     child: PrimaryButton(
                                                    //                                                         height: 34,
                                                    //                                                         textStyle: TextStyles
                                                    //                                                             .body12x500
                                                    //                                                             .copyWith(
                                                    //                                                                 color: Paints
                                                    //                                                                     .background),
                                                    //                                                         onTap: () async {
                                                    // //// Get Order details first
                                                    //                                                           var invoiceID = provider
                                                    //                                                               .currentOrderList[
                                                    //                                                                   index]!
                                                    //                                                               .invoiceId;

                                                    //                                                           var customerID = provider
                                                    //                                                               .currentOrderList[
                                                    //                                                                   index]!
                                                    //                                                               .customerId;

                                                    //                                                           // Getting order details by api call
                                                    //                                                           await Provider.of<
                                                    //                                                                       OrderController>(
                                                    //                                                                   context,
                                                    //                                                                   listen: false)
                                                    //                                                               .getOrdersForAllCustomer(
                                                    //                                                                   customerID
                                                    //                                                                       .toString(),
                                                    //                                                                   invoiceID
                                                    //                                                                       .toString())
                                                    //                                                               .then(
                                                    //                                                                   (currentOrder) {
                                                    //                                                             Navigator.of(
                                                    //                                                                     context)
                                                    //                                                                 .push(MaterialPageRoute(
                                                    //                                                                     builder:
                                                    //                                                                         (context) {
                                                    //                                                               return OrderConfirmationByDriverPage(
                                                    //                                                                 currentOrder:
                                                    //                                                                     currentOrder,
                                                    //                                                               );
                                                    //                                                             }));
                                                    //                                                           });
                                                    //                                                         },
                                                    //                                                         text: 'Update Order'),
                                                    //                                                   ),

                                                    // const SizedBox(
                                                    //   height: 16,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        );

                                        return Container(
                                          height: 20,
                                          color: Colors.red,
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: Text(
                                        'No Order Found!',
                                      ),
                                    ),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: _pullRefresh,
                              child: provider.previousList.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: provider.previousList.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (ctx, index) {
                                        var temp = provider.previousList[index];
                                        var communityId = temp
                                            ?.customerViewModel
                                            ?.customerAddressViewModels
                                            ?.first
                                            .nearByLocation;

                                        var subCommunityId = temp
                                            ?.customerViewModel
                                            ?.customerAddressViewModels
                                            ?.first
                                            .buildingName;

                                        var communityName =
                                            AppHelper.getCommunityNameFromId(
                                                mainCommunityList, communityId);

                                        var subCommunityName =
                                            AppHelper.getSubCommunityNameFromId(
                                                mainSubCommunityList,
                                                subCommunityId);

                                        var villa = temp
                                                ?.customerViewModel
                                                ?.customerAddressViewModels
                                                ?.first
                                                .address ??
                                            '';

                                        var streetName = temp
                                                ?.customerViewModel
                                                ?.customerAddressViewModels
                                                ?.first
                                                .addressLine2 ??
                                            '';

                                        var orderAddress = villa +
                                            ', ' +
                                            streetName +
                                            ', ' +
                                            subCommunityName +
                                            ', ' +
                                            communityName;

                                        return InkWell(
                                          onTap: () {
                                            // NavUtils.push(context, MyOrderDetails(provider.myorderList[index]!.invoiceDetailsViewModels,provider.myorderList[index]!.invoiceViewModels![0],"","", provider.myorderList[index]!.totalAmount!,provider.myorderList[index]!.invoiceViewModels![0].status!));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  color: AppColors.pureWhite,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    ListTile(
                                                      leading: Container(
                                                        height: 48,
                                                        width: 48,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                100),
                                                          ),
                                                          color: AppColors
                                                                  .Blue077C9E
                                                              .withOpacity(0.3),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .Blue077C9E,
                                                              width: 2),
                                                        ),
                                                        child: Center(
                                                            child: Image.asset(
                                                          "assets/images/ic-ok-blue.png",
                                                          width: 20,
                                                          height: 20,
                                                        )),
                                                      ),
                                                      title: Text(
                                                        "${provider.previousList[index]!.customerViewModel!.firstLastName}",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .defaultblack,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                              width: 150,
                                                              child: Text(
                                                                orderAddress,
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .gray8383,
                                                                  fontSize: 10,
                                                                ),
                                                              )),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          SizedBox(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Flexible(
                                                                    child: Text(
                                                                  "Order No:",
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .gray8383,
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                  maxLines: 2,
                                                                )),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                  "${provider.previousList[index]!.refNumber}",
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .gray8383,
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  maxLines: 2,
                                                                )),
                                                                const Spacer(),
                                                                Text(
                                                                  "${provider.previousList[index]!.invoiceStatusName}",
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .green00AF17,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              // _launchMapsUrl(provider.previousList[index]!.c!,provider.currentOrderList[index]!.customerLongitued!);
                                                            },
                                                            child: Container(
                                                              height: 35,
                                                              width: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          100),
                                                                ),
                                                                color: AppColors
                                                                    .pureWhite,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    spreadRadius:
                                                                        3,
                                                                    blurRadius:
                                                                        2,
                                                                    offset: const Offset(
                                                                        0,
                                                                        1), // changes position of shadow
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/images/google-maps.png")),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ListTile(
                                                      leading: Text(
                                                        provider
                                                                    .previousList[
                                                                        index]!
                                                                    .paymentStatus ==
                                                                1
                                                            ? "Online\nPayment"
                                                            : "",
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .Blue077C9E,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Divider(
                                                      color:
                                                          AppColors.grayDBDBDB,
                                                      thickness: 1,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    ListTile(
                                                      leading: Text(
                                                        DateTimeUtil
                                                            .getFormatedDateTimeFromServerFormat(
                                                                provider
                                                                    .previousList[
                                                                        index]!
                                                                    .invoiceDate!),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .gray8383,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      title: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Flexible(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "Total Price: ",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .defaultblack,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          "AED ",
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .defaultblack,
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          "${provider.previousList[index]!.totalAmount} ",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .Blue077C9E,
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ])),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                makeCall(provider
                                                                    .previousList[
                                                                        index]!
                                                                    .customerViewModel!
                                                                    .phoneNo!);
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/ic-call.png",
                                                                width: 22,
                                                                height: 22,
                                                              )),
                                                        ],
                                                      ),
                                                      trailing: InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        OrderDetailsSingleItems(
                                                                          provider
                                                                              .previousList[index]!
                                                                              .customerViewModel!,
                                                                          provider
                                                                              .previousList[index]!
                                                                              .totalAmount!
                                                                              .toDouble(),
                                                                          provider
                                                                              .previousList[index]!
                                                                              .refNumber,
                                                                          "${provider.previousList[index]!.paymentStatus ?? "0"}",
                                                                          index,
                                                                          provider
                                                                              .previousList[index]!
                                                                              .invoiceId,
                                                                          invoiceStatus: provider
                                                                              .previousList[index]!
                                                                              .invoiceStatusName,
                                                                          preOrCurrent:
                                                                              "Pre",
                                                                        )),
                                                              )
                                                              .then((val) => val
                                                                  ? _getRequests()
                                                                  : null);
                                                          /* NavUtils.push(context, OrderDetailsSingleItems(provider.previousList[index]!.customerViewModel!,provider.previousList[index]!.totalAmount!.toDouble(),provider.currentOrderList[index]!.refNumber,"${provider.currentOrderList[index]!.paymentStatus!=null?provider.currentOrderList[index]!.paymentStatus:"0"}",index,provider.currentOrderList[index]!.invoiceId,
                                                  invoiceStatus: provider.previousList[index]!.invoiceStatusName,
                                                  preOrCurrent: "Pre",));*/
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3),
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          50)),
                                                              color: AppColors
                                                                      .Blue077C9E
                                                                  .withOpacity(
                                                                      0.4),
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .Blue077C9E,
                                                                  width: 1)),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "View Order",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .Blue077C9E,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              Image.asset(
                                                                  "assets/images/ic-arrow-blue.png")
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                  : const Center(
                                      child: Text(
                                        'No Order Found!',
                                      ),
                                    ),
                            ),
                          ),
                    const SizedBox(
                      height: 65,
                    ),
                  ],
                ),
                Positioned(
                  bottom: -0.5,
                  left: 0.0,
                  right: 0.0,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 0),
                        padding:
                            EdgeInsets.only(bottom: Platform.isIOS ? 10 : 0),
                        decoration: const BoxDecoration(
                            color: Paints.primaryBlue,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 30,
                                  spreadRadius: 1,
                                  offset: Offset(0, 0),
                                  color: Paints.primaryBlueDarker)
                            ]),
                        height: Platform.isIOS ? 78 : 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/ic-noa-home.png",
                              width: 24,
                              height: 24,
                            ),
                            GestureDetector(
                                onTap: () {
                                  NavUtils.push(
                                    context,
                                    TruckDetails(
                                      provider.custommerLogin!.storeId!,
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  "assets/images/inventory-colored.png",
                                  width: 24,
                                  height: 24,
                                )),
                            GestureDetector(
                                onTap: () {
                                  NavUtils.push(
                                    context,
                                    DriverProfile(
                                      provider.custommerLogin!.storeId!,
                                    ),
                                  );
                                  // if(provider.custommerLogin!=null){
                                  //   NavUtils.push(context, MyProfile(provider.custommerLogin!.customerId));
                                  // }else{
                                  //   Fluttertoast.showToast(
                                  //       msg: "You are not loged in",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       gravity: ToastGravity.CENTER,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Colors.red,
                                  //       textColor: Colors.white,
                                  //       fontSize: 16.0
                                  //   );
                                  //   NavUtils.push(context, Login());
                                  // }
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
                      /*Positioned(
                          top: -10,
                          left: 150,
                          right: 150,
                          child: Center(child: GestureDetector(
                              onTap: (){
                                NavUtils.push(context, TruckLocation(widget.DriverId!));
                              },
                              child: Image.asset("assets/images/ic-noa-center-location.png",fit: BoxFit.cover,))))*/
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _getRequests() async {
    Provider.of<OrderController>(context, listen: false)
        .getCourrentOrder(widget.driverLogin!.storeId!);
    Provider.of<OrderController>(context, listen: false)
        .getPreviousOrderedItems(widget.driverLogin!.storeId!);
  }

  Future<void> _pullRefresh() async {
    Future.delayed(
      const Duration(seconds: 2),
      _getRequests,
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

  void _launchMapsTextSearch(String searchText) async {
    var uri = Uri.parse("google.navigation:q=$searchText&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  void makeCall(String phoneNo) async {
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

/* calculateDistance(OrderController provider,lat,longi) async{

    if(provider.isLocationon)
      {
        provider._currentPosition

        //LatLng latLng = LatLng(position.latitude, position.longitude);
        String distance = Geolocator.distanceBetween(provider._currentPosition, position.longitude, lat, longi).toString();
        return distance;
      }
    else{
      return "";
    }

  }*/

}
