import 'dart:async';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PilihLokasi extends StatefulWidget {
  PilihLokasi({Key? key}) : super(key: key);

  @override
  State<PilihLokasi> createState() => _PilihLokasiState();
}

class _PilihLokasiState extends State<PilihLokasi> {
  addDataLocation() async* {
    var body = {
      "title": "Kos",
      "customer_name": "Abi",
      "address": "jalan kos",
      "longitude": "123",
      "latitude": "456",
      "mobile_phone": "085239969393",
      "address_note": "rumah warna hijau"
    };
    var response = await http.post(Uri.parse(Uri.encodeFull(KEY.BASE_URL)),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        },
        body: body);

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return Dashboard();
      }), (Route<dynamic> route) => false);
    } else {
      print('input all field');
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  Future<void> _goToTheLake(LatLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
    print(LatLng);
  }

  String? Address;
  String? Street;

  Future<void> GetAddressFromLatLong(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Street = '${place.street}';
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  //
  Position? newposition;
  void alamat() async {
    Position position = await _getGeoLocationPosition();
    newposition = position;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    _kGooglePlex = CameraPosition(
      target: LatLng(newposition!.latitude, newposition!.longitude),
      zoom: 14.4746,
    );

    Placemark place = placemarks[0];
    Street = '${place.street}';

    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});

    print('$Address');
    print('${position.latitude}');
    print('${position.longitude}');
  }

  late CameraPosition _kGooglePlex;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    // TODO: implement initState
    alamat();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isloading = true;
      });
    });

    super.initState();
  }

  bool isloading = false;
  bool showShape = false;
  @override
  Widget build(BuildContext context) {
    if (!isloading) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: const Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 60.0,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: transparent,
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: FloatingActionButton(
              backgroundColor: white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: transparent,
                ),

                child: Container(
                  padding: EdgeInsets.all(10),
                  // decoration: BoxDecoration(
                  //     color: white,
                  //     borderRadius: BorderRadius.circular(25.w)),
                  child: Icon(
                    Icons.arrow_back,
                    color: darkGrey,
                  ),
                ),
                // Text(
                //   'Pilih lokasi Kamu',
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold, fontSize: 14.sp),
                // ),
                // SizedBox()
              )),
          appBar: null,
          body: SafeArea(
              // top: false,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                      statusBarColor: white,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.dark),
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: GoogleMap(
                                  // padding: const EdgeInsets.only(
                                  //     top: 250, bottom: 250),
                                  mapToolbarEnabled: true,
                                  myLocationEnabled: true,
                                  mapType: MapType.normal,
                                  initialCameraPosition: _kGooglePlex,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                  onTap: (LatLng) {
                                    _goToTheLake(LatLng);
                                    GetAddressFromLatLong(LatLng);
                                    setState(() {
                                      showShape = true;
                                    });
                                  },
                                ))),
                      ],
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              // backgroundBlendMode: BlendMode.overlay,
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.w),
                                  topRight: Radius.circular(40.w))),
                          padding: EdgeInsets.all(20.w),
                          margin: EdgeInsets.only(left: 0, right: 0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 1.4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 15.w, right: 15.w),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                      // color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    // controller: email,
                                    // onChanged: (vale) {
                                    //   if (vale.length == 0) {
                                    //     setState(() {
                                    //       canSubmit = false;
                                    //     });
                                    //   } else {
                                    //     setState(() {
                                    //       canSubmit = true;
                                    //     });
                                    //   }
                                    // },
                                    autocorrect: false,

                                    // textAlign: TextAlign.left,
                                    // ignore: unnecessary_new
                                    decoration: new InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 20, right: 20, top: 5),
                                      hintText: 'Pilih lokasi saat ini',
                                      hintStyle: TextStyle(color: softGrey),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        size: 30,
                                        color: softGrey,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(25.0),
                                          ),
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: 10.w, left: 15.w, right: 15.w),
                                    child: Text(
                                      Street! != null ? Street! : '',
                                      style: TextStyle(
                                          color: darkGrey,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 10.w, left: 15.w, right: 15.w),
                                  child: Text(
                                    Address! != null ? Address! : '',
                                    style: TextStyle(
                                        color: softGrey, fontSize: 13.sp),
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 10.w,
                                          left: 15.w,
                                          right: 15.w,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(15.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.w),
                                            color: primary),
                                        child: Center(
                                            child: Text(
                                          'Pilih lokasi ini',
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.w500),
                                        )),
                                      )),
                                )
                              ]),
                        ))
                  ]))));
    }
  }
}
