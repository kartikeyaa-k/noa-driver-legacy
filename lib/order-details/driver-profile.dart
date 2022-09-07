import 'package:flutter/material.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/order-details/home.dart';
import 'package:noa_driver/utils/nav_utils.dart';
import 'package:provider/provider.dart';

import 'inventory.dart';
import 'map/driverPosition.dart';
import 'order-controller.dart';

class DriverProfile extends StatelessWidget{

  final driverId;

  DriverProfile(this.driverId);
  @override
  Widget build(BuildContext context) {

    Provider.of<OrderController>(context, listen: false).getUserProfile(driverId);

    return Consumer<OrderController>(

      builder: (context,provider,child){

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.Blue077C9E,
            elevation: 0.0,
            leading:InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(12),
                height: 15,
                width:15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.defaultblack
                ),
                child: Center(child: Image.asset("assets/images/ic-back-noa-white.png",height: 15,width: 15,)),
              ),
            ),

            actions: [
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/images/ic-close-white.png"))
            ],
          ),

          body: Stack(
            children: [
              provider.driverProfiledata!=null?  Column(
                children: [
                  Stack(
                    children: [

                      Image.asset("assets/images/ic-appbar.png"),
                      Positioned(

                          left: 150,

                          child: Image.asset("assets/images/ic-noa.png")),
                    ],
                  ),
                  SizedBox(height: 20,),

                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColors.pureWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius:2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]

                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("My Profile",style: TextStyle(color: AppColors.Blue077C9E,fontSize: 20,fontWeight: FontWeight.bold),),

                          ],
                        ),

                        SizedBox(height: 15,),

                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.grayFAFAFA,

                          ),
                          child: Column(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [
                                    Container(
                                        child:Image.asset("assets/images/ic-profile.png")

                                    ),
                                    SizedBox(width: 8,),
                                    Text("Full Name",style: TextStyle(color: AppColors.defaultblack,fontSize: 14),),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [


                                    Text(provider.custommerLogin!.supplierName??"",style: TextStyle(color: AppColors.defaultblack,fontSize: 14),),

                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),

                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Divider(color: AppColors.grayDBDBDB,thickness: 1,),

                              ),



                             /* Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [
                                    Container(
                                        child:Image.asset("assets/images/ic-delivery van.png")

                                    ),
                                    SizedBox(width: 8,),
                                    Text("Vehicle No: ",style: TextStyle(color: AppColors.defaultblack,fontSize: 14),),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [


                                    Text(provider.driverProfiledata!.vehicleNo,style: TextStyle(color: AppColors.defaultblack,fontSize: 14),),

                                  ],
                                ),
                              ),*/
                              SizedBox(height: 5,),

                             /* Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Divider(color: AppColors.grayDBDBDB,thickness: 1,),

                              ),*/



                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [
                                    Container(
                                        child:Image.asset("assets/images/ic-mail.png")

                                    ),
                                    SizedBox(width: 8,),
                                    Text("Email",style: TextStyle(color: AppColors.defaultblack,fontSize: 14),),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [


                                    Text(provider.custommerLogin!.email??"",style: TextStyle(color: AppColors.defaultblack,fontSize: 14),),

                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),

                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Divider(color: AppColors.grayDBDBDB,thickness: 1,),

                              ),

                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [
                                    Container(
                                        child:Image.asset("assets/images/ic-phone.png")

                                    ),
                                    SizedBox(width: 8,),
                                    Text("Mobile Number",style: TextStyle(color: AppColors.defaultblack,fontSize: 14),),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [


                                    Text(provider.custommerLogin!.mobile??"",style: TextStyle(color: AppColors.defaultblack,fontSize: 14),),

                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),

                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: Divider(color: AppColors.grayDBDBDB,thickness: 1,),

                              ),

                              SizedBox(height: 5,),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ):SizedBox(),

              Positioned(
                bottom: -0.5,
                left: 0.0,
                right: 0.0,
                child: Stack(
                  children: [
                    Image.asset("assets/images/footernew.png",width: 1000,),
                    Container(
                      margin: EdgeInsets.only(top:30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          GestureDetector(
                              onTap: (){
                                NavUtils.push(context, Home(provider.custommerLogin!.supplierId,driverLogin: provider.custommerLogin!,));
                              },
                              child: Image.asset("assets/images/ic-noa-home.png",width: 24, height: 24)),

                          GestureDetector(
                              onTap: (){


                                NavUtils.pushReplacement(context, TruckDetails(provider.custommerLogin!.supplierId!));

                                // if(provider.custommerLogin!=null){
                                //   NavUtils.push(context, MyOrders(provider.custommerLogin!.customerId));
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
                              child: Image.asset("assets/images/inventory-colored.png",width: 24, height: 24)),

                          Image.asset("assets/images/ic-noa-profile.png",width: 24, height: 24),

                          Image.asset("assets/images/ic-noa-notification.png",width: 24, height: 24),

                        ],
                      ),
                    ),
                   /* Positioned(
                        top: -40,
                        left: 150,
                        right: 150,
                        child: Center(child: GestureDetector(
                            onTap: (){
                              NavUtils.pushReplacement(context, TruckLocation(driverId));
                            },
                            child: Image.asset("assets/images/ic-noa-center-location.png"))))*/
                  ],
                ),

              )
            ],
          )
        );
      },
    );
  }



}