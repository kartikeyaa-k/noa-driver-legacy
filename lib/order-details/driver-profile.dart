import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noa_driver/app-colors/app-colors.dart';
import 'package:noa_driver/core/style/styles.dart';
import 'package:noa_driver/order-details/home.dart';
import 'package:noa_driver/utils/nav_utils.dart';
import 'package:provider/provider.dart';

import 'inventory.dart';
import 'map/driverPosition.dart';
import 'order-controller.dart';

class DriverProfile extends StatefulWidget {
  final driverId;

  DriverProfile(this.driverId);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  @override
  void initState() {
    Provider.of<OrderController>(context, listen: false)
        .getUserProfile(widget.driverId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, provider, child) {
        return Scaffold(
            backgroundColor: Colors.white,
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
              title: const Text('Profile'),
              centerTitle: true,
            ),
            body: Center(
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                      'assets/images/404-wreck-it-ralph-ralph.gif')),
            ));
      },
    );
  }
}
