import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/components/buttons/primary_button.dart';
import 'package:noa_driver/core/environments/base_config.dart';
import 'package:noa_driver/core/style/styles.dart';
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

  String mailstr = "Please enter your username";
  String passwordstr = "Please enter your password";
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
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/noa-slogan-blue.png',
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.only(
                        left: 32,
                        right: 32,
                        top: 24,
                        bottom: 24,
                      ),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            Environment().config.envType == EnvironmentType.dev
                                ? "Partner Login \n(Staging Environment)"
                                : 'Partner Login',
                            style: TextStyles.body20x600
                                .copyWith(color: Paints.primaryBlueDarker),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 24, right: 24),
                            child: TextField(
                              controller: mail,
                              style: TextStyles.body14x400.copyWith(
                                color: Paints.primaryBlueDarker,
                              ),
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Paints.primaryBlueDarker),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Paints.primaryBlueDarker),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Paints.primaryBlueDarker),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: Paints.red),
                                  ),
                                  hintText: "Username",
                                  hintStyle: TextStyles.body14x400.copyWith(
                                    color: Paints.primaryBlueDarker,
                                  ),
                                  errorText: validateName ? mailstr : null),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 24, right: 24),
                            child: TextField(
                              obscureText: true,
                              controller: password,
                              style: TextStyles.body14x400.copyWith(
                                color: Paints.primaryBlueDarker,
                              ),
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Paints.primaryBlueDarker),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Paints.primaryBlueDarker),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Paints.primaryBlueDarker),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: Paints.red),
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyles.body14x400.copyWith(
                                    color: Paints.primaryBlueDarker,
                                  ),
                                  errorText:
                                      validatePassword ? passwordstr : null),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          PrimaryButton(
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
                                    NavUtils.pushAndRemoveUntil(
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
                            text: 'Login',
                            backgroundColor: Paints.primaryBlueDarker,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    )
                  ],
                ),
              ),
            ),
          ),
          // bottomSheet: Image.asset(
          //   "assets/images/ic-footer.png",
          //   fit: BoxFit.fill,
          // ),
        );
      },
    );
  }
}
