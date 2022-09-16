import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/login-registration/login.dart';
import 'package:noa_driver/login-registration/model/custommer-login.dart';
import 'package:noa_driver/order-details/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DriverLogin? custommerLogin;

  Future<bool> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginData = (prefs.getString('logininfo') ?? "");

    if (loginData != null && loginData.isNotEmpty) {
      // print("the data is ${loginData}");

      Map<String, dynamic> mapdata = jsonDecode(loginData);
      custommerLogin = DriverLogin.fromJson(mapdata);
      return true;
    } else
      return false;
  }

  bool showCar = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showCar = true;
      });
    });

    getCommunitiesAndSubCommunities();
    getUserData().then((value) {
      if (custommerLogin != null) {
        Future.delayed(
            const Duration(seconds: 3),
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(
                            custommerLogin!.supplierId,
                            driverLogin: custommerLogin!,
                          )),
                ));
      } else {
        Future.delayed(
            const Duration(seconds: 3),
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                ));
      }
    });

    super.initState();
  }

  void getCommunitiesAndSubCommunities() async {
    // Community
    await Provider.of<AddressController>(context, listen: false)
        .getAllCommunities()
        .then((value) {
      mainCommunityList.clear();
      mainCommunityList = value;
    });

    // SubCommunities
    await Provider.of<AddressController>(context, listen: false)
        .getAllSubCommunities()
        .then((value) {
      mainSubCommunityList.clear();
      mainSubCommunityList = value;
      mainSubCommunityName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.pureWhite,
        child: Stack(
          children: [
            /////////////
            Positioned(
                left: -90,
                top: -90,
                child: Image.asset(
                  "assets/images/image-logo icon.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                )),
            Positioned(
                right: -90,
                bottom: -90,
                child: Image.asset(
                  "assets/images/ic-logo-colored.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                )),

            Positioned(
                child: AnimatedOpacity(
                    opacity: showCar == false ? 0.0 : 1.0,
                    duration: const Duration(seconds: 2),
                    child: Center(
                        child: Image.asset("assets/images/logowithtext.png")))),

            AnimatedPositioned(
                duration: const Duration(seconds: 2),
                left: showCar == false ? -120 : 0,
                bottom: -40.0,
                child: Image.asset("assets/images/lori.png")),
          ],
        ),
      ),
    );
  }
}
