import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/login-registration/login.dart';
import 'package:noa_driver/login-registration/model/custommer-login.dart';
import 'package:noa_driver/order-details/order-controller.dart';
import 'package:noa_driver/utils/nav_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../order-details/driver-profile.dart';

class DrawerCustom extends StatefulWidget {
  DriverLogin? driverId;

  DrawerCustom(this.driverId);

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  bool isToggled = false;

  bool isToggled_notification = false;

  final ImagePicker _picker = ImagePicker();
  // Pick an image
  late final XFile? image;

  Future<XFile?> selectImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selected != null && selected.path.isNotEmpty) {
      setState(() {
        //image=selected;
      });

      return selected;
    } else
      return null;
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  @override
  void initState() {
    Provider.of<OrderController>(context, listen: false)
        .getUserData()
        .then((value) {});

    getPackageInfo();
    super.initState();
  }

  Future<void> getPackageInfo() async {
    var info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (ctx, provider, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.Blue077C9E,
              elevation: 0.0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(12),
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.defaultblack),
                  child: Center(
                      child: Image.asset(
                    "assets/images/ic-back-noa-white.png",
                    height: 15,
                    width: 15,
                  )),
                ),
              ),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/images/ic-close-white.png"))
              ],
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    Image.asset("assets/images/ic-appbar.png"),
                    Positioned(
                        left: 150,
                        child: Image.asset("assets/images/ic-noa.png")),
                  ],
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          if (provider.custommerLogin!.supplierId != null) {
                            Navigator.pop(context, true);
                          } else {
                            Fluttertoast.showToast(
                                msg: "You are not loged in",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.BlueF2FAFF,
                              border: Border.all(color: AppColors.Blue276184)
                              //color: Colors.red
                              ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/images/ic-noa-home-coilored.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    color: AppColors.defaultblack,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Image.asset(
                                  "assets/images/ic-arrow-right-blue.png"),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      // InkWell(
                      //   onTap: (){
                      //     if(provider.custommerLogin!.driverId!=null){
                      //       //  NavUtils.push(context, MyOrders(provider.custommerLogin!.customerId));
                      //     }else{
                      //       Fluttertoast.showToast(
                      //           msg: "You are not loged in",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.CENTER,
                      //           timeInSecForIosWeb: 1,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 20,right: 20),
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(10)),
                      //         color: AppColors.BlueF2FAFF,
                      //         border:Border.all(color: AppColors.Blue276184)
                      //       //color: Colors.red
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         SizedBox(width: 5,),
                      //         Image.asset("assets/images/ic-noa-package-colored.png"),
                      //         SizedBox(width: 20,),
                      //         Text("My Orders",style: TextStyle(color: AppColors.defaultblack,fontSize: 15,fontWeight: FontWeight.w600),),
                      //         Spacer(),
                      //         Image.asset("assets/images/ic-arrow-right-blue.png"),
                      //         SizedBox(width: 5,)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15,),

                      InkWell(
                        onTap: () {
                          if (provider.custommerLogin!.supplierId != null) {
                            // NavUtils.push(context, MyProfile(provider.custommerLogin!.customerId));
                            NavUtils.push(
                                context,
                                DriverProfile(
                                    provider.custommerLogin!.supplierId));
                          } else {
                            Fluttertoast.showToast(
                                msg: "You are not loged in",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.BlueF2FAFF,
                              border: Border.all(color: AppColors.Blue276184)
                              //color: Colors.red
                              ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/images/ic-noa-profile-colored.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Profile",
                                style: TextStyle(
                                    color: AppColors.defaultblack,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Image.asset(
                                  "assets/images/ic-arrow-right-blue.png"),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      // InkWell(
                      //   onTap: (){
                      //     if(provider.custommerLogin!.driverId!=null){
                      //        //NavUtils.push(context, CategoryPerence());
                      //     }else{
                      //       Fluttertoast.showToast(
                      //           msg: "You are not loged in",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.CENTER,
                      //           timeInSecForIosWeb: 1,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 20,right: 20),
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(10)),
                      //         color: AppColors.BlueF2FAFF,
                      //         border:Border.all(color: AppColors.Blue276184)
                      //       //color: Colors.red
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         SizedBox(width: 5,),
                      //         Image.asset("assets/images/ic-noa-list-colored.png"),
                      //         SizedBox(width: 20,),
                      //         Text("Preference",style: TextStyle(color: AppColors.defaultblack,fontSize: 15,fontWeight: FontWeight.w600),),
                      //         Spacer(),
                      //         Image.asset("assets/images/ic-arrow-right-blue.png"),
                      //         SizedBox(width: 5,)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15,),

                      InkWell(
                        onTap: () {
                          if (provider.custommerLogin!.supplierId != null) {
                            //  NavUtils.push(context, MyProfile());
                          } else {
                            Fluttertoast.showToast(
                                msg: "You are not loged in",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.BlueF2FAFF,
                              border: Border.all(color: AppColors.Blue276184)
                              //color: Colors.red
                              ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/images/ic-noa-notification-colored.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Notification",
                                style: TextStyle(
                                    color: AppColors.defaultblack,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Image.asset(
                                  "assets/images/ic-arrow-right-blue.png"),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      // InkWell(
                      //   onTap: (){
                      //     if(provider.custommerLogin!.driverId!=null){
                      //       //  NavUtils.push(context, MyProfile());
                      //     }else{
                      //       Fluttertoast.showToast(
                      //           msg: "You are not loged in",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.CENTER,
                      //           timeInSecForIosWeb: 1,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 20,right: 20),
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(10)),
                      //         color: AppColors.BlueF2FAFF,
                      //         border:Border.all(color: AppColors.Blue276184)
                      //       //color: Colors.red
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         SizedBox(width: 5,),
                      //         Image.asset("assets/images/ic-noa-workflow-colored.png"),
                      //         SizedBox(width: 20,),
                      //         Text("How It works",style: TextStyle(color: AppColors.defaultblack,fontSize: 15,fontWeight: FontWeight.w600),),
                      //         Spacer(),
                      //         Image.asset("assets/images/ic-arrow-right-blue.png"),
                      //         SizedBox(width: 5,)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15,),

                      // InkWell(
                      //   onTap: (){
                      //     if(provider.custommerLogin!.driverId!=null){
                      //       //  NavUtils.push(context, MyProfile());
                      //     }else{
                      //       Fluttertoast.showToast(
                      //           msg: "You are not loged in",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.CENTER,
                      //           timeInSecForIosWeb: 1,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 20,right: 20),
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(10)),
                      //         color: AppColors.BlueF2FAFF,
                      //         border:Border.all(color: AppColors.Blue276184)
                      //       //color: Colors.red
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         SizedBox(width: 5,),
                      //         Image.asset("assets/images/ic-noa-deal-colored.png"),
                      //         SizedBox(width: 20,),
                      //         Text("Partners",style: TextStyle(color: AppColors.defaultblack,fontSize: 15,fontWeight: FontWeight.w600),),
                      //         Spacer(),
                      //         Image.asset("assets/images/ic-arrow-right-blue.png"),
                      //         SizedBox(width: 5,)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15,),

                      // InkWell(
                      //   onTap: (){
                      //     if(provider.custommerLogin!.driverId!=null){
                      //         //NavUtils.push(context, AddressBook(provider.custommerLogin!.customerId));
                      //     }else{
                      //       Fluttertoast.showToast(
                      //           msg: "You are not loged in",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.CENTER,
                      //           timeInSecForIosWeb: 1,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 20,right: 20),
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(10)),
                      //         color: AppColors.BlueF2FAFF,
                      //         border:Border.all(color: AppColors.Blue276184)
                      //       //color: Colors.red
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         SizedBox(width: 5,),
                      //         Image.asset("assets/images/ic-noa-location-colored.png"),
                      //         SizedBox(width: 20,),
                      //         Text("Address Book",style: TextStyle(color: AppColors.defaultblack,fontSize: 15,fontWeight: FontWeight.w600),),
                      //         Spacer(),
                      //         Image.asset("assets/images/ic-arrow-right-blue.png"),
                      //         SizedBox(width: 5,)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15,),

                      // InkWell(
                      //   onTap: (){
                      //     if(provider.custommerLogin!.driverId!=null){
                      //       //  NavUtils.push(context, MyProfile());
                      //     }else{
                      //       Fluttertoast.showToast(
                      //           msg: "You are not loged in",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.CENTER,
                      //           timeInSecForIosWeb: 1,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 20,right: 20),
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(10)),
                      //         color: AppColors.BlueF2FAFF,
                      //         border:Border.all(color: AppColors.Blue276184)
                      //       //color: Colors.red
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         SizedBox(width: 5,),
                      //         Image.asset("assets/images/ic-noa-payment-colored.png"),
                      //         SizedBox(width: 20,),
                      //         Text("Payment Method",style: TextStyle(color: AppColors.defaultblack,fontSize: 15,fontWeight: FontWeight.w600),),
                      //         Spacer(),
                      //         Image.asset("assets/images/ic-arrow-right-blue.png"),
                      //         SizedBox(width: 5,)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15,),
                      InkWell(
                        onTap: () {
                          if (provider.custommerLogin!.supplierId != null) {
                            //  NavUtils.push(context, MyProfile());
                          } else {
                            Fluttertoast.showToast(
                                msg: "You are not loged in",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.BlueF2FAFF,
                              border: Border.all(color: AppColors.Blue276184)
                              //color: Colors.red
                              ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/images/noa-inventory.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Inventory",
                                style: TextStyle(
                                    color: AppColors.defaultblack,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Image.asset(
                                  "assets/images/ic-arrow-right-blue.png"),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          // provider.setNewLocationForDriver(
                          //     widget.driverId!.storeId!,
                          //     const LatLng(0, 0), []);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.remove("logininfo").then((value) {
                            Provider.of<OrderController>(context, listen: false)
                                .getUserData();
                            setState(() {
                              NavUtils.pushAndRemoveUntil(context, Login());
                            });
                          });

                          await prefs.clear();

                          setState(() {
                            Fluttertoast.showToast(
                                msg: "you are loged out",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.BlueF2FAFF,
                              border: Border.all(color: AppColors.Blue276184)
                              //color: Colors.red
                              ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/images/ic-logout-colored.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: AppColors.defaultblack,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Image.asset(
                                  "assets/images/ic-arrow-right-blue.png"),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.BlueF2FAFF,
                            border: Border.all(color: AppColors.Blue276184)
                            //color: Colors.red
                            ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.verified_user_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Version : ${_packageInfo.version} + ${_packageInfo.buildNumber}",
                              style: TextStyle(
                                  color: AppColors.defaultblack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Image.asset(
                                "assets/images/ic-arrow-right-blue.png"),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
