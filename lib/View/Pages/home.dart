import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Home/listhome.dart';
import 'package:customer/View/TabDashboard/blog.dart';
import 'package:customer/View/TabDashboard/dibawabanner.dart';
import 'package:customer/View/TabDashboard/slidebanneratas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../TabDashboard/notifikasi.dart';

// ignore_for_file: prefer_const_constructors
class Home extends StatefulWidget {
  @override
  String auto;
  // Get Key Data
  Home({Key? key, required this.auto}) : super(key: key);
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int itemcount = 6;
  late String data1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    Getnama();

    alamat();
    getDataGrid();
    getDataList();
    getDataCustomer();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = true;
      });
    });
    // getData();
    // getDataidpartner();
    //  Future.delayed(const Duration(seconds: 3), () {
    //   setState(() {
    //     loading = true;
    //   });
    //   });
  }

  //
  late List? data;
  getDataGrid() async {
    var response = await http.get(
        Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/icon')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      data = converDataToJson['data'];
      // ignore: avoid_print
      // print(converDataToJson);
    });
    return "Success";
  }

  //
  //name of dashboard
  // String data1;
  late String customer;

  late String nama;
  late List profile;
  getDataCustomer() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(
        Uri.parse(
            Uri.encodeFull('https://olla.ws/api/customer/v1/customer-profile')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
          "Authorization": 'Bearer {$customer}',
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);

      String namaa = converDataToJson['data'];
      // print(profile);
      print(namaa.toString());
      // data1 = converDataToJson['profile'][0]['name'];
      // // ignore: avoid_print
      // print('$data1');
      // print(nama);
    });
    return "Success";
  }

  //
  late List aktif;
  late List datalist;
  List gabung = [];
  List filter = [];
  getDataList() async {
    var response = await http.get(
        Uri.parse(
            Uri.encodeFull('https://olla.ws/api/customer/v1/service-list')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      datalist = converDataToJson['data'];
      filter.addAll(
          datalist.where((element) => element.containsValue("aktif")).toList());
    });
    return "Success";
  }

  //
  late String? namauser;
  void Getnama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namauser = (prefs.getString('nama')!);
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  //
  void alamat() async {
    Position position = await _getGeoLocationPosition();
    GetAddressFromLatLong(position);
    print('$Address');
    print('${position.latitude}');
    print('${position.longitude}');
  }

  //  item() async{
  //   setState(() {
  //     itemcount =  itemcount == 0 ?6:0;
  //   });
  // }
  bool tampil = true;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
            top: false,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: darkBlue,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        loading
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height / 3.3,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: darkBlue,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                              )
                            : Shimmer.fromColors(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[500],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                ),
                                baseColor: Colors.grey[100]!,
                                highlightColor: Colors.grey[300]!,
                                direction: ShimmerDirection.ltr,
                              ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30, top: 50),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Lokasi kamu:',
                                        style:
                                            TextStyle(color: Colors.blue[200]),
                                      ),
                                      SizedBox(width: 2),
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              StrutStyle(fontSize: 12.0),
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              text: Address),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))),
                                                context: context,
                                                builder: (context) {
                                                  return Column(
                                                    // mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          ListTile(
                                                            leading:
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      print(
                                                                          'kjfhkdjshfj');
                                                                    },
                                                                    child:
                                                                        new Icon(
                                                                      Icons
                                                                          .location_pin,
                                                                      color: Colors
                                                                          .red,
                                                                    )),
                                                            title: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                new Text(
                                                                    Address),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      alamat();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              30.0),
                                                                      child: Container(
                                                                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                                                                          child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'Cocokan Alamat',
                                                                              style: TextStyle(color: Colors.white, fontSize: 15),
                                                                            ),
                                                                          )),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.white),
                                      color: Colors.white10,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, top: 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //
                                          Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'gambar/login.png'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Hallo ${namauser!} !',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  //
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Customer -',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white60,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      //
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Member Gold',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          //
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          Notifikasi(
                                                              name: nama)));
                                            },
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: Colors.white30,
                                              child: Container(
                                                // margin: EdgeInsets.only(
                                                //     top: MediaQuery.of(context).size.height / 20),
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'gambar/Vector.png'),
                                                      fit: BoxFit.fitHeight),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //         height: MediaQuery.of(context).size.height / 11,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(15),
                            //           border: Border.all(color: Colors.white),
                            //           color: Colors.white10,
                            //         ),
                            //         margin:
                            //             EdgeInsets.only(left: 20, right: 20, top: 45),
                            //         child: ListTile(

                            //             horizontalTitleGap: 10,
                            //             leading: Container(
                            //               // margin: EdgeInsets.only(
                            //               //     top: MediaQuery.of(context).size.height / 20),
                            //               width: 60,
                            //               height: 60,
                            //               decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                   image: AssetImage('gambar/login.png'),
                            //                 ),
                            //               ),
                            //             ),
                            //             title: Text(
                            //               'Hallo ${nama ?? ''} !',
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 14),
                            //             ),
                            //             subtitle: Row(
                            //               children: [
                            //                 Text(
                            //                   'Customer -',
                            //                   style: TextStyle(
                            //                       color: Colors.white60,
                            //                       fontWeight: FontWeight.w600,fontSize: 12),
                            //                 ),
                            //                 //
                            //                 SizedBox(
                            //                   width: 5,
                            //                 ),
                            //                 Text(
                            //                   'Member Gold',
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontWeight: FontWeight.w600,
                            //                       fontStyle: FontStyle.italic,fontSize: 12),
                            //                 ),
                            //               ],
                            //             ),
                            //             trailing: GestureDetector(
                            //               onTap: () {
                            //                 Navigator.push(
                            //                     context,
                            //                     MaterialPageRoute(
                            //                         builder: (BuildContext context) =>
                            //                             Notifikasi(name: nama ?? '')));
                            //               },
                            //               child: CircleAvatar(
                            //                 radius: 20,
                            //                 backgroundColor: Colors.white30,
                            //                 child: Container(
                            //                   // margin: EdgeInsets.only(
                            //                   //     top: MediaQuery.of(context).size.height / 20),
                            //                   width: 25,
                            //                   height: 25,
                            //                   decoration: BoxDecoration(
                            //                     image: DecorationImage(
                            //                         image:
                            //                             AssetImage('gambar/Vector.png'),
                            //                         fit: BoxFit.fitHeight),
                            //                   ),
                            //                 ),
                            //               ),
                            //             )),
                            //       ),
                            // : Shimmer.fromColors(
                            //     child: Container(
                            //       height: MediaQuery.of(context).size.height / 8,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(20),
                            //         color: Colors.grey[500],
                            //       ),
                            //       margin:
                            //           EdgeInsets.only(left: 25, right: 25, top: 50),
                            //     ),
                            //     baseColor: Colors.grey[100],
                            //     highlightColor: Colors.grey,
                            //     direction: ShimmerDirection.ltr,
                            //   ),
                            SizedBox(
                              height: 20,
                            ),
                            SlideBannerAtas(),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: GestureDetector(
                                    onTap: () {
                                      //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Blog()));
                                      getDataCustomer();
                                    },
                                    child: Text(
                                      'Pilih Layanan',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ))),
                            //
                            ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: Container(
                                    // color: Colors.red,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 1, top: 0.0, right: 1),
                                        child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    mainAxisSpacing: 0,
                                                    // childAspectRatio: 1 / 1,
                                                    crossAxisSpacing: 0),
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            // ignore: prefer_if_null_operators
                                            itemCount: filter == null
                                                ? 0
                                                : filter.length,
                                            // datalist == null
                                            //     ? 0
                                            //     : (datalist.length > 8 ? 8 : datalist.length),
                                            // data == null
                                            //                 ? 0
                                            //                 : data!.length,
                                            itemBuilder:
                                                (BuildContext context, i) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // datalist[i]['name'].contains('Pompa Air')
                                                      //     ? Navigator.push(
                                                      //         context,
                                                      //         MaterialPageRoute(
                                                      //             builder: (BuildContext context) =>
                                                      //                 ListHome(
                                                      //                     id:
                                                      //                         '${datalist[i]['id']}',
                                                      //                     nama: 'Pompa Air',
                                                      //                     gambar: datalist[i]
                                                      //                         ['images'])))
                                                      //     : datalist[i]
                                                      //                 ['name']
                                                      //             .contains('Tandon/Toren')
                                                      //         ? Navigator.push(
                                                      //             context,
                                                      //             MaterialPageRoute(
                                                      //                 builder: (BuildContext context) => ListHome(
                                                      //                     id:
                                                      //                         '${datalist[i]['id']}',
                                                      //                     nama: 'Tandon/Toren',
                                                      //                     gambar: datalist[i]
                                                      //                         ['images'])))
                                                      //         : datalist[i]['name']
                                                      //                 .contains('Penghangat Air')
                                                      //             ? Navigator.push(
                                                      //                 context,
                                                      //                 MaterialPageRoute(
                                                      //                     builder: (BuildContext context) => ListHome(
                                                      //                         id: '${datalist[i]['id']}',
                                                      //                         nama: 'Penghangat Air',
                                                      //                         gambar: datalist[i]['images'])))
                                                      //             : datalist[i]['name'].contains('CCTV')
                                                      //                 ? Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ListHome(id: '${datalist[i]['id']}', nama: 'CCTV', gambar: datalist[i]['images'])))
                                                      //                 : datalist[i]['name'].contains('Pendingin Ruangan')
                                                      //                     ? Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ListHome(id: '${datalist[i]['id']}', nama: 'Pendingin Ruangan', gambar: datalist[i]['images'])))
                                                      //                     : datalist[i]['name'].contains('Mobil')
                                                      //                         ? Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ListHome(id: '${datalist[i]['id']}', nama: 'Mobil', gambar: datalist[i]['images'])))
                                                      //                         : null;
                                                      // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>ListHome(  id: '${filter[i]['id']}',nama:filter[i]['name'] ,gambar:filter[i]['images'])));
                                                      Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                              transitionDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          500),
                                                              transitionsBuilder:
                                                                  (context,
                                                                      animation,
                                                                      animationTime,
                                                                      child) {
                                                                animation = CurvedAnimation(
                                                                    parent:
                                                                        animation,
                                                                    curve: Curves
                                                                        .linearToEaseOut);
                                                                return ScaleTransition(
                                                                    scale:
                                                                        animation,
                                                                    child:
                                                                        child);
                                                              },
                                                              pageBuilder: (context,
                                                                  animation,
                                                                  animationTime) {
                                                                return ListHome(
                                                                    id:
                                                                        '${filter[i]['id']}',
                                                                    nama: filter[
                                                                            i][
                                                                        'name'],
                                                                    gambar: filter[
                                                                            i][
                                                                        'images']);
                                                              }));
                                                    },
                                                    child: loading
                                                        ? Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .blue[100]!
                                                                    .withOpacity(
                                                                        0.3)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          '${filter[i]['images']}'
                                                                              .toString()),
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Shimmer.fromColors(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                          .blue[
                                                                      50]),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage('${filter[i]['images']}'
                                                                            .toString()),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            baseColor: Colors
                                                                .grey[100]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[300]!,
                                                            direction:
                                                                ShimmerDirection
                                                                    .ltr,
                                                          ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  loading
                                                      ? Flexible(
                                                          child: Text(
                                                          '${filter[i]['name']}'
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))
                                                      : Shimmer.fromColors(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            height: 10,
                                                            width: 50,
                                                          ),
                                                          baseColor:
                                                              Colors.grey[100]!,
                                                          highlightColor:
                                                              Colors.grey[300]!,
                                                          direction:
                                                              ShimmerDirection
                                                                  .ltr,
                                                        ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                // UpSlideBanner(),
                                //  SlideBanner()
                                SizedBox(
                                  height: 10,
                                ),
                                DibawahBanner(),
                                //
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Info & Berita',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text('Lihat Semua',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.greenAccent,
                                            decoration:
                                                TextDecoration.underline,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Blog()
                              ],
                            ),
                            //
                          ],
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //    getDataCustomer();
                        //   // getDataList();

                        //   },
                        //   child: Container(
                        //       margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         // ignore: prefer_const_literals_to_create_immutables
                        //         children: [
                        //           Icon(
                        //             Icons.list_rounded,
                        //             color: Colors.white,
                        //           ),
                        //           Text(
                        //             'Olla.id',
                        //             style: TextStyle(color: Colors.white),
                        //           ),
                        //           GestureDetector(
                        //             onTap: () async {
                        //               SharedPreferences prefs =
                        //                   await SharedPreferences.getInstance();
                        //               prefs.remove('sukses');
                        //               Navigator.pushAndRemoveUntil(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (BuildContext context) =>
                        //                           SendOtp()),
                        //                   (Route<dynamic> route) => false);
                        //             },
                        //             child: Container(
                        //               child: Icon(
                        //                 Icons.add_alert_rounded,
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       )),
                        // ),
                        //
                        // tampil?Padding(
                        //   padding: const EdgeInsets.only(top:45.0,left:20,right: 20),
                        //   child: Container(
                        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                        //     color: Colors.white
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: ListTile(
                        //         title: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: [
                        //             Text(Address),
                        //             SizedBox(height: 10,),
                        //           ],
                        //         ),
                        //         leading: Icon(Icons.location_pin,color: Colors.red,),
                        //       )
                        //     ),
                        //   ),
                        // ):SizedBox()
                      ],
                    ),
                    // ListView(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   children: [
                    //     Container(
                    //       child: Padding(
                    //         padding:
                    //             const EdgeInsets.only(left: 10.0, right: 10, ),
                    //         child: GridView.builder(
                    //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 4,
                    //                 mainAxisSpacing: 10,
                    //                 // childAspectRatio: 5 / 5,
                    //                 crossAxisSpacing: 10),
                    //             shrinkWrap: true,
                    //             physics: NeverScrollableScrollPhysics(),
                    //             // ignore: prefer_if_null_operators
                    //             itemCount: datalist == null
                    //                 ? 0
                    //                 : (datalist.length > 8 ? 8 : datalist.length),
                    //             // data == null
                    //             //                 ? 0
                    //             //                 : data!.length,
                    //             itemBuilder: (BuildContext context, int i) {
                    //               return Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: [
                    //                   GestureDetector(
                    //                     onTap: () {
                    //                       datalist[i]['name'].contains('Pompa Air')
                    //                           ? Navigator.push(
                    //                               context,
                    //                               MaterialPageRoute(
                    //                                   builder: (BuildContext context) =>
                    //                                       ListHome(
                    //                                           id:
                    //                                               '${datalist[i]['id']}',
                    //                                           nama: 'Pompa Air',
                    //                                           gambar: datalist[i]
                    //                                               ['images'])))
                    //                           : datalist[i]
                    //                                       ['name']
                    //                                   .contains('Tandon/Toren')
                    //                               ? Navigator.push(
                    //                                   context,
                    //                                   MaterialPageRoute(
                    //                                       builder: (BuildContext context) => ListHome(
                    //                                           id:
                    //                                               '${datalist[i]['id']}',
                    //                                           nama: 'Tandon/Toren',
                    //                                           gambar: datalist[i]
                    //                                               ['images'])))
                    //                               : datalist[i]['name']
                    //                                       .contains('Penghangat Air')
                    //                                   ? Navigator.push(
                    //                                       context,
                    //                                       MaterialPageRoute(
                    //                                           builder: (BuildContext context) => ListHome(
                    //                                               id: '${datalist[i]['id']}',
                    //                                               nama: 'Penghangat Air',
                    //                                               gambar: datalist[i]['images'])))
                    //                                   : datalist[i]['name'].contains('CCTV')
                    //                                       ? Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ListHome(id: '${datalist[i]['id']}', nama: 'CCTV', gambar: datalist[i]['images'])))
                    //                                       : datalist[i]['name'].contains('Pendingin Ruangan')
                    //                                           ? Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ListHome(id: '${datalist[i]['id']}', nama: 'Pendingin Ruangan', gambar: datalist[i]['images'])))
                    //                                           : datalist[i]['name'].contains('Mobil')
                    //                                               ? Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ListHome(id: '${datalist[i]['id']}', nama: 'Mobil', gambar: datalist[i]['images'])))
                    //                                               : null;
                    //                     },
                    //                     child: Container(
                    //                       decoration: BoxDecoration(
                    //                         color: Colors.white,
                    //                         shape: BoxShape.circle,
                    //                         boxShadow: [
                    //                           BoxShadow(
                    //                               color: Colors.grey.withOpacity(0.2),
                    //                               spreadRadius: 1,
                    //                               blurRadius: 5,
                    //                               offset: Offset(0, 3))
                    //                         ],
                    //                       ),
                    //                       child: loading
                    //                           ? Container(
                    //                               child: CircleAvatar(
                    //                                 backgroundColor: Colors.transparent,
                    //                                 radius: 30,
                    //                                 child: CircleAvatar(
                    //                                   radius: 27,
                    //                                   backgroundColor: Colors.white,
                    //                                   child: Container(
                    //                                     width: 60,
                    //                                     height: 60,
                    //                                     decoration: BoxDecoration(
                    //                                       image: DecorationImage(
                    //                                           image: NetworkImage(
                    //                                               'https://olla.ws/images/service/${datalist[i]['images']}'),
                    //                                           fit: BoxFit.cover),
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             )
                    //                           : Shimmer.fromColors(
                    //                               child: Container(
                    //                                 child: CircleAvatar(
                    //                                   backgroundColor:
                    //                                       Colors.transparent,
                    //                                   radius: 30,
                    //                                   child: CircleAvatar(
                    //                                     radius: 27,
                    //                                     backgroundColor: Colors.white,
                    //                                     child: Container(
                    //                                       width: 60,
                    //                                       height: 60,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               baseColor: Colors.grey[100],
                    //                               highlightColor: Colors.grey[300],
                    //                               direction: ShimmerDirection.ltr,
                    //                             ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     height: 10,
                    //                   ),
                    //                   Flexible(
                    //                       child: Text(
                    //                     '${datalist[i]['name']}',
                    //                     maxLines: 2,
                    //                     style: TextStyle(
                    //                         fontSize: 10, fontWeight: FontWeight.w600),
                    //                     textAlign: TextAlign.center,
                    //                   )),
                    //                 ],
                    //               );
                    //             }),
                    //       ),
                    //     ),
                    //     // UpSlideBanner(),
                    //     //  SlideBanner()
                    //     DibawahBanner()
                    //   ],
                    // ),
                    //
                  ],
                ),
              ),
            )));
  }

  //

}
