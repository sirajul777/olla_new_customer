import 'dart:async';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarColor: white,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.dark),
                child: Stack(children: [
                  Column(
                    children: [
                      Container(
                          color: null,
                          decoration: BoxDecoration(color: null),
                          padding: EdgeInsets.all(15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.arrow_back),
                              Text(
                                'Pilih lokasi Kamu',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              SizedBox()
                            ],
                          )),
                      Flexible(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: GoogleMap(
                                mapToolbarEnabled: true,
                                myLocationEnabled: true,
                                mapType: MapType.normal,
                                initialCameraPosition: _kGooglePlex,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                                onTap: (LatLng) {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          child: Text('${LatLng}'),
                                        );
                                      });
                                },
                              ))),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.w),
                                topRight: Radius.circular(40.w))),
                        padding: EdgeInsets.all(20.w),
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.width / 1.2,
                        child: Text('coba'),
                      )
                    ],
                  )
                ]))));
  }
}
