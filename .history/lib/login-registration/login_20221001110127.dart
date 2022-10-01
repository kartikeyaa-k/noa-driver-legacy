import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/core/environments/base_config.dart';
import 'package:noa_driver/order-details/home.dart';
import 'package:noa_driver/utils/nav_utils.dart';

import 'package:provider/provider.dart';

import 'login-controller.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mail = TextEditingController();

  TextEditingController password = TextEditingController();

  bool validateName = false;
  bool validatePassword = false;
  final bool _isRemember = false;

  String mailstr = "Name Can't Be Empty";
  String passwordstr = "Password Can't Be Empty";
  String firebaseToken = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    firebaseCloudMessaging_Listeners();

    super.initState();
  }

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        firebaseToken = token.toString();
      });
      // print("FIREBASETOKEN:" + token.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustommerLoginController>(
      builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.pureWhite,
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset("assets/images/ic-appbar.png"),
                    Positioned(
                        top: 70,
                        left: 160,
                        child: Image.asset(
                          "assets/images/ic-noa.png",
                          height: 30,
                          width: 90,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          "assets/images/lori.png",
                          height: 240,
                          width: 188,
                        ),
                        Positioned(
                            left: 139,
                            top: 86,
                            child: Image.asset(
                              "assets/images/ic-person.png",
                              height: 110,
                            )),
                        Positioned(
                            top: 90,
                            left: 250,
                            child: Image.asset(
                              "assets/images/ic-noa-colored.png",
                              height: 30,
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: AppColors.pureWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            Environment().config.envType == EnvironmentType.dev
                                ? "Welcome To Noa (Staging Environment)"
                                : 'Welcome To Noa',
                            style: TextStyle(
                                color: AppColors.defaultblack, fontSize: 26),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Container(
                                  child:
                                      Image.asset("assets/images/ic-mail.png")),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: AppColors.defaultblack,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            controller: mail,
                            style: TextStyle(
                                color: AppColors.defaultblack, fontSize: 10),
                            decoration: InputDecoration(
                                hintText: "user name",
                                hintStyle: TextStyle(
                                    color: AppColors.gray8383, fontSize: 10),
                                contentPadding: const EdgeInsets.only(top: 20),
                                errorText: validateName ? mailstr : null),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Container(
                                  child: Image.asset(
                                      "assets/images/ic-phone.png")),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Password",
                                style: TextStyle(
                                    color: AppColors.defaultblack,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            obscureText: true,
                            controller: password,
                            style: TextStyle(
                                color: AppColors.defaultblack, fontSize: 10),
                            decoration: InputDecoration(
                                hintText: "*******",
                                hintStyle: TextStyle(
                                    color: AppColors.gray8383, fontSize: 10),
                                contentPadding: const EdgeInsets.all(5),
                                errorText:
                                    validatePassword ? passwordstr : null),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              mail.text.isEmpty
                                  ? validateName = true
                                  : validateName = false;
                              password.text.isEmpty
                                  ? validatePassword = true
                                  : validatePassword = false;
                            });

                            if (mail.text.isNotEmpty &&
                                password.text.isNotEmpty) {
                              await provider
                                  .postLogin(
                                mail.text,
                                password.text,
                                _isRemember,
                                firebaseToken,
                              )
                                  .whenComplete(() {
                                if (provider.custommerLogin != null) {
                                  Fluttertoast.showToast(
                                      msg: "Login Success",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  NavUtils.push(
                                    context,
                                    Home(
                                      provider.custommerLogin!.storeId!,
                                      driverLogin: provider.custommerLogin!,
                                    ),
                                  );
                                } else {
                                  mailstr = "User Name or Password error";
                                  passwordstr = "User Name or Password error";

                                  if (mail.text.isNotEmpty &&
                                      password.text.isNotEmpty) {
                                    setState(() {
                                      validateName = true;
                                      validatePassword = true;
                                    });
                                  }

                                  Fluttertoast.showToast(
                                      msg: "User or Password Error",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.Blue077C9E,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              "Login",
                              style: TextStyle(
                                  color: AppColors.pureWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                )
              ],
            ),
          ),
          bottomSheet: Image.asset(
            "assets/images/ic-footer.png",
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}
