import 'dart:async';
import 'dart:ffi';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PostLokasi extends StatefulWidget {
  PostLokasi({Key? key}) : super(key: key);

  @override
  State<PostLokasi> createState() => _PostLokasiState();
}

class _PostLokasiState extends State<PostLokasi> {
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
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: Text('To the lake!'),
          icon: Icon(Icons.directions_boat),
        ),
        body: SafeArea(
            top: false,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarColor: white,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.dark),
                child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    child: Column(
                      children: [
                        Container(
                            child: Row(
                          children: [Icon(Icons.arrow_back), Text('Pilih lokasi Kamu'), SizedBox()],
                        )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.w),
                            border: Border.all(color: softGrey, width: 2),
                          ),
                          child: GoogleMap(
                            mapType: MapType.hybrid,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: softGrey, width: 2),
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: white),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle: StrutStyle(fontSize: 12.0),
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.white, fontSize: 12), text: 'Address'),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                      ],
                    )))));
  }
}
