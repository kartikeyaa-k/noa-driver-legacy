import 'dart:async';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as acurecy;
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../app-colors/app-colors.dart';
import '../../utils/nav_utils.dart';
import '../driver-profile.dart';
import '../inventory.dart';
import '../model/order-details-response-data.dart';
import '../order-controller.dart';
import '../order-details.dart';

class TruckLocation extends StatefulWidget {
  int DriverId;
  TruckLocation(this.DriverId);
  @override
  State<TruckLocation> createState() => _TruckLocationState();
}

class _TruckLocationState extends State<TruckLocation> {
  static CameraPosition? initialPosition = CameraPosition(
      target: LatLng(
        23.804385,
        90.358129,
      ),
      zoom: 14.4746);
  Location _locationtracker = Location();
  Marker? marker;
  Circle? circle;
  GoogleMapController? controller;
  StreamSubscription? _streamSubscription;
  Position? currentPosition;
  var geoLocator = Geolocator();

  Uint8List? commonMarker;

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/ic-storemarker.png");
    commonMarker = byteData.buffer.asUint8List();
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getMarkerMyCurrentPosition() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/ic-storemarker.png");
    commonMarker = byteData.buffer.asUint8List();
    return byteData.buffer.asUint8List();
  }

  Future<void> getCurrentLocation() async {
    try {
      Uint8List imagedata = await getMarker();
      var location = _locationtracker.getLocation();
      updateMarkerandLocation(await location, imagedata);

      if (_streamSubscription != null) {
        _streamSubscription!.cancel();
      }

      _streamSubscription =
          _locationtracker.onLocationChanged.listen((newLocationData) {
        if (controller != null) {
          controller!
              .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
            target:
                LatLng(newLocationData.latitude!, newLocationData.longitude!),
            tilt: 0,
            zoom: 18.00,
          )));

          updateMarkerandLocation(newLocationData, imagedata);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // debugPrint("Permission denied");
      }
    }
  }

  void updateMarkerandLocation(LocationData locationData, Uint8List imagedata) {
    LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);

    setState(() {
      marker = Marker(
        markerId: MarkerId("Home"),
        position: latLng,
        rotation: locationData.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imagedata),
      );
      circle = Circle(
          circleId: CircleId("radius"),
          radius: locationData.accuracy!,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latLng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> locatePosition() async {
    // print("my latlang ==");
    Uint8List imagedata = await getMarkerMyCurrentPosition();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: acurecy.LocationAccuracy.high);

    Uint8List imagedataa = await getMarker();

    currentPosition = position;
    LatLng latLng = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 14);
    controller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {
      marker = Marker(
        markerId: MarkerId("Homee"),
        position: latLng,
        rotation: currentPosition!.heading,
        draggable: false,
        zIndex: 3,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imagedata),
      );
      circle = Circle(
          circleId: CircleId("radius"),
          radius: currentPosition!.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latLng,
          fillColor: Colors.blue.withAlpha(70));
      storeLocation.add(marker!);
    });

    Provider.of<OrderController>(context, listen: false)
        .currentOrderList
        .forEach((element) {
      storeLocation.add(Marker(
          markerId: MarkerId("${element!.productName}"),
          position: LatLng(double.parse(element.customerViewModel!.latitued),
              double.parse(element.customerViewModel!.longitued!)),
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imagedataa),
          onTap: () {
            double distanceMeter = element.customerViewModel!.latitued != null
                ? Geolocator.distanceBetween(
                    currentPosition!.latitude,
                    currentPosition!.longitude,
                    double.parse(element.customerViewModel!.latitued!),
                    double.parse(element.customerViewModel!.longitued!))
                : 1000;
            Fluttertoast.showToast(
                msg: "${distanceMeter.floor() / 1000} KM away",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }));
    });
  }

  late BitmapDescriptor customIcon;
  List<Marker> locationList = [];
  List<Marker> storeLocation = [];

  getCcustomMarker() async {
    Uint8List imagedata = await getMarker();

    setState(() {
      locationList = [
        Marker(
            markerId: MarkerId("Home"),
            position: LatLng(23.807317, 90.368455),
            infoWindow: InfoWindow(title: "Static Store 1"),
            icon: BitmapDescriptor.fromBytes(imagedata),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            onTap: () {
              double distanceMeter = Geolocator.distanceBetween(
                  currentPosition!.latitude,
                  currentPosition!.longitude,
                  23.807317,
                  90.368455);
              Fluttertoast.showToast(
                  msg: "${distanceMeter.floor() / 1000} KM away",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }),
        Marker(
            markerId: MarkerId("Home1"),
            position: LatLng(23.75772014246706, 90.38843340684397),
            infoWindow: InfoWindow(title: "Static Store 2"),
            icon: BitmapDescriptor.fromBytes(imagedata),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            onTap: () {
              double distanceMeter = Geolocator.distanceBetween(
                  currentPosition!.latitude,
                  currentPosition!.longitude,
                  23.75772014246706,
                  90.38843340684397);
              Fluttertoast.showToast(
                  msg: "${distanceMeter.floor() / 1000} KM away",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }),
        Marker(
            markerId: MarkerId("Home2"),
            position: LatLng(23.806005391655933, 90.40253110563232),
            infoWindow: InfoWindow(title: "Static Store 3"),
            icon: BitmapDescriptor.fromBytes(imagedata),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            onTap: () {
              double distanceMeter = Geolocator.distanceBetween(
                  currentPosition!.latitude,
                  currentPosition!.longitude,
                  23.806005391655933,
                  90.40253110563232);
              Fluttertoast.showToast(
                  msg: "${distanceMeter.floor() / 1000} KM away",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }),
        Marker(
            markerId: MarkerId("Home3"),
            position: LatLng(23.780480038798007, 90.39338084391315),
            infoWindow: InfoWindow(title: "Static Store 4"),
            icon: BitmapDescriptor.fromBytes(imagedata),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            onTap: () {
              double distanceMeter = Geolocator.distanceBetween(
                  currentPosition!.latitude,
                  currentPosition!.longitude,
                  23.780480038798007,
                  90.39338084391315);
              Fluttertoast.showToast(
                  msg: "${distanceMeter.floor() / 1000} KM away",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }),
      ];
    });

// storeLocation.addAll(locationList);
  }

  //bool isLocationfetch=true;

  @override
  void dispose() {
    _streamSubscription!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
    getCcustomMarker();
    Provider.of<OrderController>(context, listen: false).isLocationon == true
        ? locatePosition()
        : "";
    //getCurrentLocation();
    // Provider.of<OrderController>(context, listen: false)
    //     .locatePosition(widget.DriverId!, '');
  }

  void toggle(provider) {
    setState(() => provider.isLocationon = !provider.isLocationon);
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
                //  provider.detailsTotalAmount=0;
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(12),
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
              "Near To You",
              style: TextStyle(
                  color: AppColors.defaultblack,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: Container(
              child: Stack(
                children: [
                  SlidingUpPanel(
                    minHeight: 120,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    panelBuilder: (sc) => _panel(sc, context, provider),
                    body: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: initialPosition!,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: provider.isLocationon,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          mapType: MapType.normal,
                          markers:
                              Set.of((marker != null) ? storeLocation : []),
                          circles: Set.of((circle != null) ? [circle!] : []),
                          onMapCreated: (GoogleMapController gcontroller) {
                            controller = gcontroller;
                            provider.isLocationon == true
                                ? locatePosition()
                                : "";
                          },
                        ),
                        /* Container(
                        margin: EdgeInsets.only(top: 10,left: 20),

                        child: Row(
                          children: [
                            SizedBox(width: 8,),
                            Container(
                              width: MediaQuery.of(context).size.width-100,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: AppColors.pureWhite,
                              ),
                              child: TextField(

                                style: TextStyle(color: AppColors.defaultblack,fontSize: 10),
                                decoration: InputDecoration(
                                  hintText: "search here",
                                  suffixIcon: Container(
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: AppColors.DeepYelowF37226
                                      ),
                                      child:  Image.asset("assets/images/ic-advance-search.png",height: 15,width: 15,),
                                    ),
                                  ),
                                  prefixIcon: Image.asset("assets/images/ic-search.png"),
                                  hintStyle: TextStyle(color: AppColors.gray8383,fontSize: 10),
                                  contentPadding: EdgeInsets.only(left: 10,top: 15),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),*/
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
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //SizedBox(width: 30,),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                      "assets/images/ic-noa-home.png",
                                      width: 24,
                                      height: 24)),
                              //SizedBox(width: 25,),
                              GestureDetector(
                                  onTap: () {
                                    NavUtils.push(
                                        context,
                                        TruckDetails(provider
                                            .custommerLogin!.supplierId!));
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
                                  child: Image.asset(
                                      "assets/images/inventory-colored.png",
                                      width: 24,
                                      height: 24)),
                              //Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    NavUtils.push(
                                        context,
                                        DriverProfile(provider
                                            .custommerLogin!.supplierId));
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
                              //SizedBox(width: 25,),
                              Image.asset(
                                  "assets/images/ic-noa-notification.png",
                                  width: 24,
                                  height: 24),
                              //SizedBox(width:25,),
                            ],
                          ),
                        ),
                        /* Positioned(
                          top: -10,
                          left: 150,
                          right: 150,
                          child: Center(child: GestureDetector(
                              onTap: (){
                              //  NavUtils.push(context, TruckLocation());
                              },
                              child: Image.asset("assets/images/ic-noa-center-location.png",fit: BoxFit.cover,))))*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _panel(ScrollController sc, context, provider) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Near To You",
                  style: TextStyle(
                      color: AppColors.Blue276184,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    color: AppColors.Blue276184,
                    fontSize: 10,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.currentOrderList.length > 0
                      ? provider.currentOrderList.length
                      : 0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        // NavUtils.push(context, MyOrderDetails(provider.myorderList[index]!.invoiceDetailsViewModels,provider.myorderList[index]!.invoiceViewModels![0],"","", provider.myorderList[index]!.totalAmount!,provider.myorderList[index]!.invoiceViewModels![0].status!));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            padding: EdgeInsets.all(10),
                            height: 205,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.pureWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 48,
                                          width: 48,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                              color: AppColors.Blue077C9E
                                                  .withOpacity(0.3),
                                              border: Border.all(
                                                  color: AppColors.Blue077C9E,
                                                  width: 2)),
                                          child: Center(
                                              child: Text(
                                            "#${index + 1}",
                                            style: TextStyle(
                                                color: AppColors.Blue077C9E,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          )),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            width: 50,
                                            child: Text(
                                              "${provider.currentOrderList[index]!.paymentStatus} Payment",
                                              style: TextStyle(
                                                  color: AppColors.Blue077C9E,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${provider.currentOrderList[index]!.customerViewModel!.firstLastName}",
                                          style: TextStyle(
                                              color: AppColors.defaultblack,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 150,
                                            child: Text(
                                              "${provider.currentOrderList[index]!.customerViewModel!.customerAddressViewModels![0].flatNo},"
                                              " ${provider.currentOrderList[index]!.customerViewModel!.customerAddressViewModels![0].address}, ${provider.currentOrderList[index]!.customerViewModel!.customerAddressViewModels![0].cityName}",
                                              style: TextStyle(
                                                color: AppColors.gray8383,
                                                fontSize: 10,
                                              ),
                                            )),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                child: Text(
                                              "Order Number ",
                                              style: TextStyle(
                                                color: AppColors.gray8383,
                                                fontSize: 11,
                                              ),
                                            )),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Container(
                                                width: 80,
                                                child: Text(
                                                  "${provider.currentOrderList[index]!.refNumber}",
                                                  style: TextStyle(
                                                      color: AppColors.gray8383,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 75,
                                        ),
                                        Text(
                                          "${provider.currentOrderList[index]!.customerViewModel!.customerAddressViewModels![0].status}",
                                          style: TextStyle(
                                              color: AppColors.green00AF17,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            color: AppColors.pureWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 2,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                              child: Image.asset(
                                                  "assets/images/google-maps.png")),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "2Km",
                                          style: TextStyle(
                                              color: AppColors.pureBlack,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "5 Mins",
                                          style: TextStyle(
                                              color: AppColors.pureBlack,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),

                                Divider(
                                  color: AppColors.grayDBDBDB,
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
//
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "25 minago",
                                      style: TextStyle(
                                          color: AppColors.gray8383,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "Total Price: ",
                                        style: TextStyle(
                                            color: AppColors.defaultblack,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: "AED ",
                                        style: TextStyle(
                                          color: AppColors.defaultblack,
                                          fontSize: 10,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "${provider.currentOrderList[index]!.totalAmount} ",
                                        style: TextStyle(
                                            color: AppColors.Blue077C9E,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ])),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Image.asset("assets/images/ic-call.png"),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          //NavUtils.push(context, OrderDetails(provider.currentOrderList[index]!.customerViewModel,provider.currentOrderList[index]!.totalAmount,provider.currentOrderList[index]!.refNumber,"${provider.currentOrderList[index]!.paymentStatus!=null?provider.currentOrderList[index]!.paymentStatus:"0"}",index,provider.currentOrderList[index]!.invoiceId));

                                          NavUtils.push(
                                              context,
                                              OrderDetailsSingleItems(
                                                  provider
                                                      .currentOrderList[index]!
                                                      .customerViewModel,
                                                  provider
                                                      .currentOrderList[index]!
                                                      .totalAmount!
                                                      .toDouble(),
                                                  provider
                                                      .currentOrderList[index]!
                                                      .refNumber,
                                                  "${provider.currentOrderList[index]!.paymentStatus != null ? provider.currentOrderList[index]!.paymentStatus : "0"}",
                                                  index,
                                                  provider
                                                      .currentOrderList[index]!
                                                      .invoiceId));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              color: AppColors.Blue077C9E
                                                  .withOpacity(0.4),
                                              border: Border.all(
                                                  color: AppColors.Blue077C9E,
                                                  width: 1)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "View Order",
                                                style: TextStyle(
                                                    color: AppColors.Blue077C9E,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Image.asset(
                                                  "assets/images/ic-arrow-blue.png")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ));
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }
}
