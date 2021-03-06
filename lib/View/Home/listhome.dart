import 'dart:convert';
import 'dart:ffi';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Pages/AturJadwal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

// ignore_for_file: prefer_const_constructors
// ignore: must_be_immutable
class ListHome extends StatefulWidget {
  String id;
  String nama;
  String gambar;
// Get Key Data
  ListHome({Key? key, required this.id, required this.nama, required this.gambar}) : super(key: key);
  @override
  State<ListHome> createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  late List<String> komentar1;
  bool loading = false;
  bool value = false;
  bool _showLanjutButton = false;

  // bool _isLoading = false;
  // List<Map> krisdianto=[];
  // List<Map> availableHobbies = [
  //   {"name": "Foobball", "isChecked": false},
  //   {"name": "Baseball", "isChecked": false},
  //   {
  //     "name": "Video Games",
  //     "isChecked": false,
  //   },
  //   {"name": "Readding Books", "isChecked": false},
  //   {"name": "Surfling The Internet", "isChecked": false}

  // ];
  showButtonLanjut() {
    if (selectData!.every((element) => false) == true || isChecked!.any((element) => element != false) == true) {
      setState(() {
        _showLanjutButton = true;
      });
    } else {
      setState(() {
        _showLanjutButton = false;
      });
    }
  }

  List? selectData = [];

  List? iddatta = [];
  List? idcomment = [];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
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
      return SafeArea(
          top: false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: white, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.dark),
            child: Stack(
              children: [
                Scaffold(
                    backgroundColor: white,
                    // extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      title: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            // ignore: avoid_unnecessary_containers
                            child: Container(
                              height: MediaQuery.of(context).size.height / 25,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(3),
                              //   color: Colors.blue[50],
                              // ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          GestureDetector(
                            onTap: () {
                              print(datalist!);
                            },
                            child: Text(
                              "Pesan Layanan",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ),
                          //
                          // SizedBox(
                          //   width: 130,
                          // ),
                          //
                          // Column(
                          //   // ignore: prefer_const_literals_to_create_immutables
                          //   children: [
                          //     Icon(
                          //       Icons.add_alert_rounded,
                          //       color: Colors.white,
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                      automaticallyImplyLeading: false,

                      // backgroundColor: Colors.transparent,
                      // shape:
                      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    floatingActionButtonAnimator: NoScalingAnimation(),
                    floatingActionButton: _showLanjutButton
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                //        String text = _controllerMap.values
                                //     .where((indexlement) => element.text != "")
                                //     .fold("", (acc, element) => acc += "${element.text}\n");
                                // await _showUpdateDialog(text);
                                // setState(() {
                                //   _controllerMap.forEach((key, controller) {
                                //     int index = _controllerMap.keys.toList().indexOf(key);
                                //     key = controller.text;
                                //     _data[index] = controller.text;
                                //   });
                                // });
                                Position position = await _getGeoLocationPosition();
                                GetAddressFromLatLong(position);
                                print('$Address');
                                print('${position.latitude}');
                                print('${position.longitude}');
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      // fullscreenDialog: true,
                                      // transitionDuration: Duration(seconds: 1),
                                      // transitionsBuilder: (context, animation, animationTime, child) {
                                      //   animation = CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);

                                      //   return ScaleTransition(scale: animation, child: child);
                                      // },
                                      builder: (context) => Aturjadwal(
                                            alamat: '$Address',
                                            longitude: '${position.longitude}',
                                            latitude: '${position.latitude}',
                                            id: '${widget.id}',
                                            datahalaman: selectData!,
                                            isChecked: isChecked,
                                            iddnama: idcomment!,
                                            iddata: iddatta!,
                                            iddharga: harga,
                                            totalharga: totalharga,
                                            quantity: qty,
                                          )),
                                );
                                ;
                                print("oke");
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: Text('Selanjutnya',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500))),
                                ),
                              ),
                            ),
                          )
                        : null,
                    body: WillPopScope(
                      onWillPop: () async {
                        Navigator.pop(context, true);
                        return false;
                      },
                      child: new PageStorage(
                          bucket: bucket,
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 23.0, left: 20, right: 20),
                                    child: loading
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white,
                                              border: Border.all(color: Colors.amber),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 5), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            height: MediaQuery.of(context).size.height / 5,
                                            width: double.infinity,
                                            child: Center(
                                                child: Padding(
                                              padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30),
                                              child: Text(
                                                'Demi memelihara unit pendingin ruangan diharapkan dilakukan pemeliharaan dalam jangka waktu 14 hari, sehingga unit pendingin ruangan tidak kotor karena debu dan kotoran, dan terhindar dari kerusakan yang diinginkan.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 13, color: Colors.grey),
                                              ),
                                            )),
                                          )
                                        : Shimmer.fromColors(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height / 5,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[500],
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                            baseColor: Colors.grey[100]!,
                                            highlightColor: Colors.grey[300]!,
                                            direction: ShimmerDirection.ltr,
                                          ),
                                  ),

                                  //
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0, right: 80),
                                    child: loading
                                        ? Container(
                                            height: MediaQuery.of(context).size.height / 16,
                                            decoration: BoxDecoration(
                                                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(35),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        image: NetworkImage('${widget.gambar}'), fit: BoxFit.cover),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    widget.nama,
                                                    style: TextStyle(
                                                        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Shimmer.fromColors(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height / 16,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[500], borderRadius: BorderRadius.circular(20)),
                                            ),
                                            baseColor: Colors.grey[100]!,
                                            highlightColor: Colors.grey[300]!,
                                            direction: ShimmerDirection.ltr,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              //
                              Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Pilih Tindakan',
                                        style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                                    //    const SizedBox(height: 10),
                                    // const Divider(),
                                    // const SizedBox(height: 10),
                                    datalist!.length != 0
                                        ? ListView.builder(
                                            controller: _controller,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: datalist!.length,
                                            itemBuilder: (context, index) {
                                              return loading
                                                  ? Padding(
                                                      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(color: Colors.blue[100]!),
                                                          borderRadius: BorderRadius.circular(20),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.1),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset: Offset(0, 5), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Stack(
                                                          clipBehavior: Clip.none,
                                                          children: [
                                                            Theme(
                                                              data: ThemeData(unselectedWidgetColor: Colors.blue[200]),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child: Column(
                                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          SizedBox(
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Flexible(
                                                                                  child: Text(
                                                                                    datalist![index]['name'],
                                                                                    style: TextStyle(
                                                                                        overflow: TextOverflow.clip,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.grey[600],
                                                                                        fontSize: 13.sp),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      checked(index: index);
                                                                                      finalharga(indexs: index);
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 22.h,
                                                                                      width: 22.w,
                                                                                      decoration: BoxDecoration(
                                                                                          color: isChecked![index]
                                                                                              ? primary
                                                                                              : transparent,
                                                                                          borderRadius:
                                                                                              BorderRadius.circular(5),
                                                                                          border: Border.all(
                                                                                              color: primary,
                                                                                              width: 2.w)),
                                                                                      child: Center(
                                                                                          child: isChecked![index]
                                                                                              ? Icon(
                                                                                                  Icons.done,
                                                                                                  size: 20,
                                                                                                  color:
                                                                                                      isChecked![index]
                                                                                                          ? white
                                                                                                          : primary,
                                                                                                )
                                                                                              : const SizedBox()),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          Text(
                                                                            'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                                                                            textAlign: TextAlign.left,
                                                                            style: TextStyle(
                                                                                height: 1.5,
                                                                                color: Colors.grey,
                                                                                fontSize: 12),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          Center(
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  // margin: EdgeInsets.only(
                                                                                  //     top: MediaQuery.of(context).size.height / 20),
                                                                                  width: 30,
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    image: DecorationImage(
                                                                                      image: AssetImage(
                                                                                          'gambar/rupiah.png'),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                // SizedBox(
                                                                                //   width: 10,
                                                                                // ),
                                                                                // Text(
                                                                                //   'Rp',
                                                                                //   style: TextStyle(
                                                                                //       fontWeight:
                                                                                //           FontWeight
                                                                                //               .w700,
                                                                                //       color: Colors
                                                                                //               .yellow[
                                                                                //           600]),
                                                                                // ),

                                                                                Text(
                                                                                  NumberFormat.currency(
                                                                                          locale: 'id',
                                                                                          symbol: 'Rp ',
                                                                                          decimalDigits: 0)
                                                                                      .format(int.parse(datalist![index]
                                                                                          ['price_min'])),
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: Colors.yellow[600]),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Container(
                                                                                  width: 90.w,
                                                                                  height: 30.h,
                                                                                  padding: EdgeInsets.only(
                                                                                      left: 5.w, right: 5.w),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius:
                                                                                          BorderRadius.circular(5.w),
                                                                                      color: lightBlue),
                                                                                  child: Row(
                                                                                    mainAxisAlignment:
                                                                                        MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          minQty(index);
                                                                                        },
                                                                                        child: Container(
                                                                                            width: 22.w,
                                                                                            height: 22.w,
                                                                                            decoration: BoxDecoration(
                                                                                                color: primary,
                                                                                                borderRadius:
                                                                                                    BorderRadius
                                                                                                        .circular(5.w)),
                                                                                            child: const Center(
                                                                                              child: Text(
                                                                                                '-',
                                                                                                style: TextStyle(
                                                                                                    color: white),
                                                                                              ),
                                                                                            )),
                                                                                      ),
                                                                                      Text('${qty[index]}',
                                                                                          style: const TextStyle(
                                                                                              color: darkGrey)),
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          addQty(index);
                                                                                        },
                                                                                        child: Container(
                                                                                            width: 22.w,
                                                                                            height: 22.w,
                                                                                            padding: EdgeInsets.only(
                                                                                                top: 5.w),
                                                                                            decoration: BoxDecoration(
                                                                                                color: primary,
                                                                                                borderRadius:
                                                                                                    BorderRadius
                                                                                                        .circular(5.w)),
                                                                                            child: const Center(
                                                                                              child: Text(
                                                                                                '+',
                                                                                                style: TextStyle(
                                                                                                    color: white),
                                                                                              ),
                                                                                            )),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            // Positioned(
                                                            //   bottom: 14,
                                                            //   //  left: 0,
                                                            //   right: 30,
                                                            //   //  top:10,
                                                            //   child:
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Shimmer.fromColors(
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height / 4,
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[500],
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                        ),
                                                        baseColor: Colors.grey[100]!,
                                                        highlightColor: Colors.grey[300]!,
                                                        direction: ShimmerDirection.ltr,
                                                      ),
                                                    );
                                            })
                                        : Container(
                                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                              Container(
                                                margin: EdgeInsets.only(top: 30.w),
                                                width: 200.w,
                                                height: 200.w,
                                                child: SvgPicture.asset('gambar/takenodata.svg'),
                                              ),
                                              Center(
                                                child: Text(
                                                  'Pemberitahuan',
                                                  style: TextStyle(
                                                      color: darkGrey, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(bottom: 20.w),
                                                padding: EdgeInsets.only(top: 8.w, left: 20, right: 20),
                                                child: Center(
                                                  child: Text(
                                                    'Layanan yang Anda pilih saat ini sedang dalam proses pengembangan',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: softGrey, fontSize: 14.sp),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                  width: 120.w,
                                                  padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 8),
                                                  decoration: BoxDecoration(
                                                      color: primary, borderRadius: BorderRadius.circular(20.w)),
                                                  child: Center(
                                                      child: Text(
                                                    'Kembali',
                                                    style: TextStyle(color: white, fontSize: 14.sp),
                                                  )),
                                                ),
                                              )
                                            ]),
                                          ),

                                    Padding(
                                      padding: EdgeInsets.only(bottom: 45.h),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))),
                    ))
              ],
            ),
          ));
    }
  }

//
  int _itemCount = 0;
  //
  late ScrollController _controller;
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  bool isloading = false;
  @override
  void initState() {
    getDataListHome();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    // iddatta;
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        isloading = true;
        loading = true;
      });
    });
  }

  //
  late List? datalist = [];

  Future getDataListHome() async {
    final preff2 = await SharedPreferences.getInstance();
    preff2.setString('partnerdecline', 'saya');
    var response = await http
        .get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/packages-list?service_id=${widget.id}')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
    });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      datalist = converDataToJson['data'];
      isChecked = List<bool>.filled(datalist!.length, false, growable: true);
      qty = List<int>.filled(datalist!.length, 0, growable: true);
      selectData = List<dynamic>.filled(datalist!.length, 0, growable: true);
      iddatta = List<dynamic>.filled(datalist!.length, 0, growable: true);
      idcomment = List<dynamic>.filled(datalist!.length, 0, growable: true);
      harga = List<int>.filled(datalist!.length, 0, growable: true);

      // ignore: avoid_print
      print(datalist!);
    });
    return "Success";
  }

  //
  showimage(context, img) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: datalist! == null ? 0 : (datalist!.length > 1 ? 1 : datalist!.length),
                    itemBuilder: (BuildContext context, int i) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(img),
                      );
                    }),
              ),
            ),
          );
        });
  }

  //
  String location = 'Null, Press Button';
  String Address = 'search';
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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street},';
    setState(() {});
  }

  //
  // List<TextEditingController> _coment = List();

  // TextEditingController coment = TextEditingController();
  //
  //
  // TextEditingController saya = TextEditingController();
  TextEditingController _getControllerOf(String name) {
    var controller = _controllerMap[name];
    if (controller == null) {
      controller = TextEditingController();
      _controllerMap[name] = controller;
      // setState(() {
      //   saya = controller;
      // });
    }
    return controller;
  }

  //
  Map<String, TextEditingController> _controllerMap = Map();
  @override
  void dispose() {
    _controllerMap.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  //
  Future<List<String>> _retrieveData() {
    return Future.value(_data);
  }

  //
  var satu = 1;
  List<String> _data = [
    '1',
    "2",
    "3",
    "4",
    "5",
    "",
    "",
    "",
  ];
  //

  late String tampilan;
  Future _showUpdateDialog(String text) async {
    setState(() {
      tampilan = text.trim();
    });
  }

  //
  List<int>? harga = [];
  List<bool>? isChecked;
  bool ceklist = false;

  void valuechecker(int index) {
    setState(() {
      if (isChecked![index] && qty[index] > 0 || iddatta![index] == 0 || selectData![index] == 0) {
        selectData![index] = datalist![index];
        iddatta![index] = datalist![index]['id'];
        idcomment![index] = datalist![index]['name'];
        harga![index] = int.parse(datalist![index]['price_min']);
      }
    });
    finalharga(indexs: index);
  }

  void valueremove(int index) {
    setState(() {
      selectData![selectData!.indexWhere((element) => element['id'] == iddatta![index])] = 0;
      iddatta![index] = 0;
      idcomment![index] = 0;
      harga![index] = 0;
    });
  }

  void checked({int? index}) async {
    setState(() {
      isChecked![index!] = !isChecked![index];
      showButtonLanjut();
      if (isChecked![index]) {
        addQty(index);
      } else {
        minQty(index);
      }
    });
  }

  late String? totalharga = '0';
  Future<void> finalharga({int? indexs, bool? all}) async {
    var cektrue = isChecked!.every((indexl) => indexl == true);
    var cekfalse = isChecked!.every((indexl) => indexl == false);

    if (cektrue) {
      for (var i = 0; i < harga!.length; i++) {
        if (isChecked![i] == true) {
          var string = datalist![i]['price_min'];

          int dataharga = int.parse(string);

          setState(() {
            harga![indexs!] = 0;
            harga![i] = dataharga * qty[i];
          });
        }
      }
    } else if (cekfalse) {
      for (var i = 0; i < harga!.length; i++) {
        setState(() {
          harga![i] = 0;
        });
      }
    } else {
      if (isChecked![indexs!] == true) {
        var string = datalist![indexs]['price_min'];
        String variabel = string;
        int dataharga = int.parse(variabel);
        for (var i = 0; i < harga!.length; i++) {
          if (isChecked![i] == false) {
            setState(() {
              harga![i] = 0;
            });
          }
          print(i);
        }
        setState(() {
          harga![indexs] = 0;
          harga![indexs] = dataharga * qty[indexs];
        });
      }
      print(harga);
    }

    var jumlah = harga!.reduce((a, b) => a + b).toString();

    if (jumlah != 0) {
      setState(() {
        totalharga = jumlah;
      });
    } else {
      setState(() {
        totalharga = '$jumlah';
      });
    }
    print(harga);
    print(totalharga);
    print(qty);
    print(selectData);
    print(iddatta);
  }

  late List<int> qty = [];
  // toto menambah jumlah
  void addQty(int index) async {
    setState(() {
      if (qty[index] < 10) {
        qty[index] += 1;
        isChecked![index] = true;
        valuechecker(index);
      }
    });
    showButtonLanjut();
    finalharga(indexs: index);
  }

  // counter mengurangi jumlah
  void minQty(int index) async {
    showButtonLanjut();
    if (qty[index] > 0) {
      if (qty[index] == 1) {
        setState(() {
          qty[index] -= 1;
          isChecked![index] = false;
        });
        valueremove(index);
      } else {
        valueremove(index);

        if (isChecked![index] == false) {
          setState(() {
            qty[index] = 0;
            isChecked![index] = false;
          });
        } else {
          setState(() {
            qty[index] -= 1;
          });
        }
      }
    }
    showButtonLanjut();
  }

  // Future<String> setQty() async {
  //   for (var i = 0; i < datalist!.length; i++) {
  //     setState(() {
  //       qty[i] = List<int>.filled(datalist!.length, 1, growable: true) as int;
  //       ;
  //     });
  //   }
  //   print(qty);
  //   return 'sukses';
  // }
}

class NoScalingAnimation extends FloatingActionButtonAnimator {
  @override
  Offset getOffset({Offset? begin, Offset? end, double? progress}) {
    return end!;
  }

  @override
  Animation<double> getRotationAnimation({Animation<double>? parent}) {
    return Tween<double>(begin: 0, end: 0).animate(parent!);
  }

  @override
  Animation<double> getScaleAnimation({Animation<double>? parent}) {
    return Tween<double>(begin: 1, end: 1).animate(parent!);
  }
}
