import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:customer/Controllers/LocationController.dart';
import 'package:customer/Models/Lokasi.dart';

import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class PostLokasi extends StatefulWidget {
  String? address;
  LatLng? latlng;
  String? addressName;
  PostLokasi({Key? key, required this.address, required this.addressName, required this.latlng}) : super(key: key);

  @override
  State<PostLokasi> createState() => _PostLokasiState();
}

class _PostLokasiState extends State<PostLokasi> {
  TextEditingController phonenumber = TextEditingController();
  TextEditingController labelalamat = TextEditingController();
  TextEditingController customername = TextEditingController();
  TextEditingController address_note = TextEditingController();

  String? secreat_code;
  addDataLocation(
      {LatLng? latlong,
      String? customer_name,
      String? mobile_phone,
      String? address_note,
      String? address,
      String? title}) async {
    SweetAlert.show(
      context,
      subtitle: "Waiting!...",
      style: SweetAlertStyle.loading,
    );
    var prefs1 = await SharedPreferences.getInstance();
    secreat_code = prefs1.getString('customer')!;
    var body = json.encode({
      "title": title!,
      "customer_name": customer_name!,
      "address": address!,
      "longitude": "${latlong!.longitude}",
      "latitude": "${latlong.latitude}",
      "mobile_phone": mobile_phone,
      "address_note": address_note
    });
    try {
      Lokasi lokasi = await LocationController.PostLokasiBaru(body: body, bearer: secreat_code!);

      print(lokasi);
      if (lokasi.message == "Address succesfully added") {
        Future.delayed(const Duration(seconds: 4), () {
          setState(() {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
                (Route<dynamic> route) => false);
          });
        });
      } else {
        SweetAlert.show(context,
            subtitle: 'Kolom tidak boleh kosong',
            style: SweetAlertStyle.confirm,
            confirmButtonColor: primary,
            showCancelButton: false);
      }
    } on SocketException catch (_) {
      return SweetAlert.show(context,
          subtitle: "No Internet Connection!", style: SweetAlertStyle.confirm, showCancelButton: false);
      // throw Failed(code: 101, response: "no connection");r
    } on TimeoutException {
      return SweetAlert.show(context,
          subtitle: "Connection Timeout!", style: SweetAlertStyle.confirm, showCancelButton: false);
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  CameraPosition? _kGooglePlex;
  Future<void> _goToTheLake(LatLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799, target: LatLng, tilt: 59.440717697143555, zoom: 19.151926040649414)));
    print(LatLng);
  }

  @override
  void initState() {
    _goToTheLake(widget.latlng);
    // TODO: implement initState
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.latlng!.latitude, widget.latlng!.longitude),
      zoom: 14.4746,
    );

    setState(() {});
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isloading = true;
      });
    });
    super.initState();
  }

  bool isloading = false;

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
          backgroundColor: white,
          appBar: null,
          // floatingActionButton: FloatingActionButton.extended(
          //   onPressed: () {},
          //   label: Text('To the lake!'),
          //   icon: Icon(Icons.directions_boat),
          // ),
          body: SafeArea(
              top: false,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                      statusBarColor: white,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.dark),
                  child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Stack(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: MediaQuery.of(context).padding,
                                padding: EdgeInsets.only(top: 20.w, left: 20.w, right: 20.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: darkGrey,
                                      ),
                                    ),
                                    Text(
                                      'Pilih lokasi kamu',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: darkGrey),
                                    ),
                                    SizedBox()
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 20),
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 25.w, bottom: 30.w),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.w),
                                border: Border.all(color: softGrey, width: 1),
                              ),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Alamat berdasarkan titik lokasi',
                                    style: TextStyle(color: primary, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: 10.w),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          widget.address!,
                                          style: TextStyle(
                                              color: darkGrey,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp),
                                        )),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 6.w, top: 6.w),
                                              decoration: BoxDecoration(
                                                  color: primary, borderRadius: BorderRadius.circular(15.w)),
                                              child: Text(
                                                'Ganti lokasi',
                                                style: TextStyle(
                                                    color: white, fontWeight: FontWeight.w500, fontSize: 12.sp),
                                              )),
                                        )
                                      ],
                                    )),
                                Flexible(
                                    child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      heightFactor: 3.5,
                                      widthFactor: 2.5,
                                      child: GoogleMap(
                                        mapType: MapType.normal,
                                        myLocationButtonEnabled: true,
                                        myLocationEnabled: true,
                                        onCameraMove: null,
                                        initialCameraPosition: _kGooglePlex!,
                                        onMapCreated: (GoogleMapController controller) {
                                          _controller.complete(controller);
                                        },
                                        onTap: (LatLng lat) {},
                                      ),
                                    ),
                                  ),
                                ))
                              ]),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                    margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.w),
                                    padding: EdgeInsets.all(15.w),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: primary, width: 1),
                                        borderRadius: BorderRadius.circular(10.w),
                                        color: white),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Container(
                                        child: Text(
                                          'Alamat lengkap',
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.fade),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          widget.address!,
                                          style: TextStyle(
                                              color: softGrey,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.fade),
                                        ),
                                      ),
                                    ]))),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 5.w),
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: softGrey, width: 1),
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: white),
                              child: TextField(
                                controller: address_note,
                                // textAlign: TextAlign.left,
                                // ignore: unnecessary_new
                                decoration: new InputDecoration(
                                  fillColor: white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
                                  hintText: 'Deskripsi alamat',
                                  prefixIcon: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.description_outlined,
                                        size: 20,
                                      )),
                                  // prefixIcon: Container(padding: const EdgeInsets.all(10.0), child: null),
                                  hintStyle: TextStyle(color: softGrey),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.w),
                              child: Text(
                                'Contoh: Rumah warna hijau, rumah no.12 dan lainnya',
                                style: TextStyle(color: softGrey, fontSize: 10.sp),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 5.w),
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: softGrey, width: 1),
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: white),
                              child: TextField(
                                controller: customername,
                                // textAlign: TextAlign.left,
                                // ignore: unnecessary_new
                                decoration: new InputDecoration(
                                  fillColor: white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
                                  hintText: 'Nama pelanggan',
                                  prefixIcon: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.badge_outlined,
                                        size: 20,
                                      )),
                                  hintStyle: TextStyle(color: softGrey),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.w),
                              child: Text(
                                'Contoh: Mr. Ardi, Mrs. yunita dan lainnya',
                                style: TextStyle(color: softGrey, fontSize: 10.sp),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 5.w),
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: softGrey, width: 1),
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: white),
                              child: TextField(
                                controller: labelalamat,
                                // textAlign: TextAlign.left,
                                // ignore: unnecessary_new
                                decoration: new InputDecoration(
                                  fillColor: white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
                                  hintText: 'Label alamat',
                                  prefixIcon: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.bookmark_outline,
                                        size: 20,
                                      )),
                                  // prefixIcon: Container(padding: const EdgeInsets.all(10.0), child: null),
                                  hintStyle: TextStyle(color: softGrey),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.w),
                              child: Text(
                                'Contoh: Rumah, apartement, kantor dan lainnya',
                                style: TextStyle(color: softGrey, fontSize: 10.sp),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 5.w),
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: softGrey, width: 1),
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: white),
                              child: TextField(
                                controller: phonenumber,
                                keyboardType: TextInputType.number,
                                // textAlign: TextAlign.left,
                                // ignore: unnecessary_new
                                decoration: new InputDecoration(
                                  fillColor: white,
                                  filled: true,
                                  // hintTextDirection: TextDirection.LTR,
                                  contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
                                  hintText: 'Nomor kontak penerima',
                                  prefixIcon: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.book_outlined,
                                        size: 20,
                                      )),
                                  hintStyle: TextStyle(color: softGrey),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.w),
                              child: Text(
                                'Contoh: 08xxxxxxxxx',
                                style: TextStyle(color: softGrey, fontSize: 10.sp),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.w),
                              child: GestureDetector(
                                  onTap: () {
                                    addDataLocation(
                                      latlong: widget.latlng!,
                                      title: '${labelalamat.text}',
                                      mobile_phone: '${phonenumber.text}',
                                      address_note: '${address_note.text}',
                                      address: widget.address!,
                                      customer_name: '${customername.text}',
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10.w,
                                      left: 15.w,
                                      right: 15.w,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(15.w),
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(25.w), color: primary),
                                    child: Center(
                                        child: Text(
                                      'Tambah lokasi',
                                      style: TextStyle(color: white, fontWeight: FontWeight.w500),
                                    )),
                                  )),
                            )
                            // Container(
                            //   margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.w),
                            //   child: Text(
                            //     'Contoh: Rumah, Kantor, dan Lainnya',
                            //     style: TextStyle(color: softGrey, fontSize: 14.sp),
                            //   ),
                            // ),
                          ],
                        )
                      ])))));
    }
  }
}
