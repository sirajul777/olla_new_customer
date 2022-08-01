import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:customer/Controllers/LocationController.dart';
import 'package:customer/Models/Lokasi.dart';
import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Components/emojiText.dart';
import 'package:customer/View/Home/listhome.dart';
import 'package:customer/View/Pages/MultiLokasi/PilihLokasi.dart';
import 'package:customer/View/TabDashboard/blog.dart';
import 'package:customer/View/TabDashboard/dibawabanner.dart';
import 'package:customer/View/TabDashboard/slidebanneratas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sweetalert/sweetalert.dart';

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

  @override
  void initState() {
    super.initState();
    Getnama();
    alamat();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
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

  List<bool>? idalamatutama;
  Future<String> setLokasiUtama(int id, int index) async {
    final prepes = await SharedPreferences.getInstance();
    prepes.setInt('idAlamatUtama', id);
    if (id == lokasi!.ress![index].id) {
      for (var i = 0; i < idalamatutama!.length; i++) {
        setState(() {
          idalamatutama![i] = false;
        });
      }
      setState(() {
        idalamatutama![index] = !idalamatutama![index];
      });
    }

    print(id);
    return 'oke';
  }

  //
  late List? data;
  getDataGrid() async {
    var response = await http.get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/icon')), headers: {
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
    var response =
        await http.get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/customer-profile')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": 'Bearer {$customer}',
    });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);

      String namaa = converDataToJson['data'];
      // print(profile);

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
    var response = await http.get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/service-list')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
    });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      datalist = converDataToJson['data'];
      filter.addAll(datalist.where((element) => element.containsValue("aktif")).toList());
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
    print('ok');
  }

  //
  String location = 'Null, Press Button';
  String Address = 'search';

  //
  // String? secreat_code;
  List? listlokasi;
  GetLokasi? lokasi;
  Future<void> alamat() async {
    // var prefs1 = await SharedPreferences.getInstance();
    // secreat_code = prefs1.getString('customer')!;

    try {
      lokasi = await LocationController.getLokasiBaru();
      print(lokasi!.ress!.length);
      setState(() {
        lokasi = lokasi;
      });
      if (lokasi!.ress![0].address! != null) {
        setState(() {
          listlokasi = lokasi!.ress!;
          Address = lokasi!.ress![0].address!;
          idalamatutama = List<bool>.filled(lokasi!.ress!.length, false, growable: true);
        });
        // print(lokasi);
      } else {
        SweetAlert.show(context,
            subtitle: 'Kesalahan pada server',
            style: SweetAlertStyle.confirm,
            confirmButtonColor: primary,
            showCancelButton: false);
      }
    } on SocketException catch (_) {
      return SweetAlert.show(context,
          subtitle: "No Internet Connection!", style: SweetAlertStyle.confirm, showCancelButton: false);
      // throw Failed(code: 101, response: "no connection");r
    } on TimeoutException {
      return SweetAlert.show(context, style: SweetAlertStyle.confirm, showCancelButton: false);
    }
  }

  //  item() async{
  //   setState(() {
  //     itemcount =  itemcount == 0 ?6:0;
  //   });
  // }
  bool tampil = true;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
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
                                height: MediaQuery.of(context).size.height / 3.3,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: darkBlue,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                ),
                              )
                            : Shimmer.fromColors(
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 3.5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[500],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                  ),
                                ),
                                baseColor: Colors.grey[100]!,
                                highlightColor: Colors.grey[300]!,
                                direction: ShimmerDirection.ltr,
                              ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 50),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                                // mainAxisSize: MainAxisSize.min,
                                                // height: MediaQuery.of(context).size.width-50,
                                                child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 30, left: 20),
                                                  child: Text(
                                                    'Alamat yang Anda gunakan sekarang',
                                                    style: TextStyle(fontWeight: FontWeight.bold, color: darkGrey),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top: 2, bottom: 20, left: 20),
                                                  child: Text(
                                                    'Kamu bisa pilih alamat yang di simpan',
                                                    style: TextStyle(color: softGrey, fontSize: 12.sp),
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.symmetric(vertical: 8.0),
                                                        height: MediaQuery.of(context).size.width / 2,
                                                        child: ListView.builder(
                                                            controller: _controller,
                                                            shrinkWrap: true,
                                                            itemCount: listlokasi != null ? listlokasi!.length : 0,
                                                            scrollDirection: Axis.horizontal,
                                                            itemBuilder: (context, index) {
                                                              return loading
                                                                  ? GestureDetector(
                                                                      onTap: () {
                                                                        setLokasiUtama(lokasi!.ress![index].id!, index);
                                                                      },
                                                                      child: InkWell(
                                                                        child: Container(
                                                                          margin: EdgeInsets.only(left: 15, right: 5),
                                                                          padding: EdgeInsets.all(8.w),
                                                                          width: MediaQuery.of(context).size.width / 2,
                                                                          height: MediaQuery.of(context).size.width / 2,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(25.w),
                                                                              border: Border.all(
                                                                                  color: idalamatutama![index]
                                                                                      ? primary
                                                                                      : Color.fromARGB(
                                                                                          255, 196, 196, 196),
                                                                                  width: 1)),
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(top: 10.w),
                                                                                child: Center(
                                                                                    child: new Icon(
                                                                                  Icons.location_pin,
                                                                                  color:
                                                                                      Color.fromARGB(255, 255, 107, 97),
                                                                                  size: 45,
                                                                                )),
                                                                              ),
                                                                              Container(
                                                                                  margin: EdgeInsets.only(top: 10.w),
                                                                                  child: new Text(
                                                                                    lokasi!.ress![index].customerName!,
                                                                                    style: TextStyle(
                                                                                        color: darkGrey,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 12.sp,
                                                                                        overflow: TextOverflow.clip),
                                                                                  )),
                                                                              new Text(
                                                                                lokasi!.ress![index].address!,
                                                                                style: TextStyle(
                                                                                    fontSize: 12.sp,
                                                                                    color: softGrey,
                                                                                    overflow: TextOverflow.clip),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  : SizedBox();
                                                            }),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext context) => PilihLokasi()));
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: 15),
                                                            padding: EdgeInsets.all(10.w),
                                                            width: MediaQuery.of(context).size.width / 2,
                                                            height: MediaQuery.of(context).size.width / 2,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(25.w),
                                                              border: Border.all(
                                                                  color: Color.fromARGB(255, 196, 196, 196), width: 1),
                                                            ),
                                                            child: Center(
                                                                child: Container(
                                                                    width: 60.w,
                                                                    height: 60.w,
                                                                    // height: 20.w,
                                                                    padding: EdgeInsets.all(5.w),
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(color: softGrey, width: 3),
                                                                        borderRadius: BorderRadius.circular(30.w)),
                                                                    child: Center(
                                                                      child: Text(
                                                                        '+',
                                                                        style: TextStyle(
                                                                          color: softGrey,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 30.sp,
                                                                        ),
                                                                      ),
                                                                    ))),
                                                          )),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.w,
                                                ),
                                                Center(
                                                    child: Container(
                                                  margin: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 2),
                                                  color: Color.fromARGB(255, 196, 196, 196),
                                                  height: 1,
                                                  width: MediaQuery.of(context).size.width - 30.w,
                                                )),
                                                SizedBox(
                                                  height: 8.w,
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(top: 5, bottom: 10, left: 20),
                                                    child: Flexible(
                                                      child: Text(
                                                          'Kamu juga bisa cari lokasi dulu kalau ke alamat lain',
                                                          style: TextStyle(
                                                              color: softGrey,
                                                              overflow: TextOverflow.clip,
                                                              fontSize: 12.w)),
                                                    )),
                                                Container(
                                                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                                                  width: MediaQuery.of(context).size.width,
                                                  height: MediaQuery.of(context).size.height / 15,
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
                                                      contentPadding: EdgeInsets.only(left: 20, right: 20, top: 5),
                                                      hintText: 'Cari lokasi',
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
                                              ],
                                            ));
                                          });
                                    },
                                    child: Row(children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.orange,
                                        size: 12,
                                      ),
                                      Text(
                                        'Lokasimu:',
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.blue[200],
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle: StrutStyle(fontSize: 12.0),
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.white, fontSize: 11.sp), text: Address),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      )
                                    ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.white),
                                      color: Colors.white10,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          //
                                          Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage('gambar/login.png'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Hallo ${namauser!} !',
                                                    style: TextStyle(
                                                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                  //
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Customer -',
                                                        style: TextStyle(
                                                            color: Colors.white60,
                                                            fontWeight: FontWeight.w600,
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
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FontStyle.italic,
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
                                                      builder: (BuildContext context) => Notifikasi(name: nama)));
                                            },
                                            child: Container(
                                              // margin: EdgeInsets.only(
                                              //     top: MediaQuery.of(context).size.height / 20),
                                              width: 30,
                                              padding: EdgeInsets.all(5),
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: lightBlue, borderRadius: BorderRadius.circular(30)),
                                              child: Center(
                                                  child: Icon(
                                                Icons.notifications_outlined,
                                                color: darkBlue,
                                                size: 20,
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SlideBannerAtas(),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20.w, right: 10.w),
                                child: Text(
                                  'Pilih Layanan',
                                  style:
                                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                                )),
                            Container(
                                padding: EdgeInsets.only(left: 20.w, right: 10.w, top: 8.w),
                                child: Column(children: [
                                  EmojiText(
                                      size: 12.sp,
                                      text:
                                          "Pilih layanan sesuai kebutuhanmu dirumah yah, kami siap datang dengan segera mengatasinya! 😄"),
                                ])),

                            //
                            ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right: 5),
                                  child: Container(
                                    // color: Colors.red,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 1, top: 0.0, right: 1),
                                        child: GridView.builder(
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisSpacing: 0,
                                                // childAspectRatio: 1 / 1,
                                                crossAxisSpacing: 0),
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            // ignore: prefer_if_null_operators
                                            itemCount: filter == null ? 0 : filter.length,
                                            // datalist == null
                                            //     ? 0
                                            //     : (datalist.length > 8 ? 8 : datalist.length),
                                            // data == null
                                            //                 ? 0
                                            //                 : data!.length,
                                            itemBuilder: (BuildContext context, i) {
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                      Navigator.push(context, PageRouteBuilder(
                                                          // transitionDuration:
                                                          //     Duration(
                                                          //         milliseconds:
                                                          //             500),
                                                          // transitionsBuilder:
                                                          //     (context,
                                                          //         animation,
                                                          //         animationTime,
                                                          //         child) {
                                                          //   animation = CurvedAnimation(
                                                          //       parent:
                                                          //           animation,
                                                          //       curve: Curves
                                                          //           .linearToEaseOut);
                                                          //   return ScaleTransition(
                                                          //       scale:
                                                          //           animation,
                                                          //       child:
                                                          //           child);
                                                          // },
                                                          pageBuilder: (context, animation, animationTime) {
                                                        return ListHome(
                                                            id: '${filter[i]['id']}',
                                                            nama: filter[i]['name'],
                                                            gambar: filter[i]['images']);
                                                      }));
                                                    },
                                                    child: loading
                                                        ? Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: Colors.blue[100]!.withOpacity(0.3)),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          '${filter[i]['images']}'.toString()),
                                                                      fit: BoxFit.cover),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Shimmer.fromColors(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: Colors.blue[50]),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                            '${filter[i]['images']}'.toString()),
                                                                        fit: BoxFit.cover),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            baseColor: Colors.grey[100]!,
                                                            highlightColor: Colors.grey[300]!,
                                                            direction: ShimmerDirection.ltr,
                                                          ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  loading
                                                      ? Flexible(
                                                          child: Text(
                                                          '${filter[i]['name']}'.toString(),
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600,
                                                              color: darkGrey),
                                                          textAlign: TextAlign.center,
                                                        ))
                                                      : Shimmer.fromColors(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.grey,
                                                                borderRadius: BorderRadius.circular(10)),
                                                            height: 10,
                                                            width: 50,
                                                          ),
                                                          baseColor: Colors.grey[100]!,
                                                          highlightColor: Colors.grey[300]!,
                                                          direction: ShimmerDirection.ltr,
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
                                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Info & Berita',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkGrey),
                                      ),
                                      Text('Lihat Semua',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.greenAccent,
                                            decoration: TextDecoration.underline,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Blog(),
                                SizedBox(
                                  height: 15,
                                ),
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
