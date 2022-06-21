import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detailpembayaran.dart';

class LanjutPembayaran extends StatefulWidget {
  List nama;
  List harga;
  String alamat;
  String longitude;
  String latitude;
  String jadwal;
  String jam;
  String menit;
  String domisiliproblem;
  int rumah;
  int apartement;
  List iddata;

  String id;
  // String koment;
// Get Key Data
  LanjutPembayaran(
      {Key? key,
      required this.longitude,
      required this.latitude,
      required this.id,
      required this.iddata,
      required this.rumah,
      required this.apartement,
      required this.nama,
      required this.harga,
      required this.alamat,
      required this.jadwal,
      required this.jam,
      required this.domisiliproblem,
      required this.menit})
      : super(key: key);
  @override
  State<LanjutPembayaran> createState() => _LanjutPembayaranState();
}

class _LanjutPembayaranState extends State<LanjutPembayaran> {
  int admin = 5000;
  late int methodpayment;
  bool tampil = false;
  bool pembayaran = false;

  late int order_id;
  bool pressed = false;
  bool _selected = false;
  @override
  void initState() {
    print(widget.harga);
    super.initState();
    getDataPembayaran();
    getDataListHome();
  }

  addData() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('secret_code')!;
    String myUrl = '${KEY.BASE_URL}/v1/order-post';
    http.post(Uri.parse(Uri.encodeFull(myUrl)), headers: {
      'Accept': 'application/json',
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer $customer",
      // "imei": "123456"
    }, body: {
      // "customer_id": '${service}',
      "working_date": '${widget.jadwal}',
      "working_time": '${widget.jam}',
      "description": '${widget.domisiliproblem}',
      "method_payment_id": '${1}',
      "longitude": '${widget.longitude}',
      "latitude": '${widget.latitude}',
      "domisili_id":
          '${widget.apartement != null ? widget.apartement : widget.rumah}',
      "address_note": '${widget.domisiliproblem}',
      "partner_packages[0][id]": '${widget.id}',
      "partner_packages[0][qty]": '3',
      "partner_packages[0][comment]": 'ff',
      "partner_packages[1][id]": '${widget.iddata}',
      "partner_packages[1][qty]": '4',
      "partner_packages[1][comment]": 'ii',
      "address": "${widget.alamat}"
    }).then((response) async {
      var jsonObj = json.decode(response.body);
      print(response);
      if (response.statusCode == 200) {
        setState(() {
          order_id = jsonObj['data'][0]['order_id'];
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(17),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Maaf!!!',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Masukkan Data Anda Dengan Benar',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                      )),
                  Positioned(
                    // bottom: 10,
                    top: 0,
                    left: 16,
                    right: 16,
                    // ignore: sized_box_for_whitespace
                    child: Container(
                        height: 80,
                        width: 80,
                        child: Image.asset('gambar/login.png')),
                  )
                ],
              ),
            );
          },
        );
      }
      // print('$statusinactive');
      // return print('$data');
      //   return showDialog(
      //       context: context,
      //       barrierDismissible: false,
      //       builder: (BuildContext context) {
      //         return WillPopScope(
      //           onWillPop: () async => false,
      //           child: GestureDetector(onTap: () {
      //             Navigator.pop(context);
      //             // Navigator.pushAndRemoveUntil(
      //             //     context,
      //             //     MaterialPageRoute(
      //             //         builder: (BuildContext context) => HomeScreen()),
      //             //     (Route<dynamic> route) => false);
      //           }, child: StatefulBuilder(
      //             builder: (BuildContext context, StateSetter setState) {
      //               return SimpleDialog(
      //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //                 contentPadding: EdgeInsets.zero,
      //                 titlePadding: EdgeInsets.only(bottom: 0),
      //                 title: Column(
      //                   children: [
      //                     Container(
      //                       decoration: BoxDecoration(
      //                       color:Colors.deepPurple[400],
      //                         borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10))
      //                       ),
      //                       height:20,
      //                     ),
      //                     SizedBox(height:15),
      //                     Text('Akun Belum Aktiv'),
      //                     SizedBox(height:15),
      //                     RaisedButton(
      //                       child:Text('Verifikasi Akun'),
      //                       onPressed: (){
      //                         // _launchMap();
      //                       },
      //                     ),
      //                     SizedBox(height:15),
      //                   ],
      //                 )
      //               );
      //             },
      //           )),
      //         );
      //       });
      // } else {}
    });
//
//
  }

  //
  late List payment;
  getDataPembayaran() async {
    var response = await http.get(
        Uri.parse(
            Uri.encodeFull('https://olla.ws/api/customer/v1/method-payments')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      payment = converDataToJson['data'];
      // ignore: avoid_print
      // print(converDataToJson);
      print(payment);
    });
    return "Success";
  }

  void coba() async {
    List list = widget.iddata;
    Map map1 = list.asMap();
    print(widget.apartement);
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
  }

  //
  Dio dio = Dio();
  //
  late String customer;
  late int mapkosong;
  late int mapsatu;
  late int mapdua;
  late int maptiga;
  late int mapempat;
  late int hitung1;
  late int hitung2;
  int kosongs = 0;
  List anak1 = [];

  //
  late int service;
  // int method;
  // int dataid;
  // int dataid1;
  // int dataid2;
  // int dataid3;
  // int dataid4;
  late List datalist;
  getDataListHome() async {
    var response = await http.get(
        Uri.parse(Uri.encodeFull(
            'https://olla.ws/api/customer/packages-list?service_id=${widget.id}')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      datalist = converDataToJson['data'];

      service = converDataToJson['data'][0]['service_id'];
      print(service);
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    List jumlah = widget.harga + [admin];
    // feedmin.insert(1,5000);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.red,
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.blue[50],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 90,
              ),
              GestureDetector(
                onTap: () {
                  // print(datalist);
                },
                child: Text(
                  "Pembayaran",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'comfortaa',
                  ),
                ),
              ),
              //
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
        body: ListView(
          children: [
            // Text('${widget.id}'),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Row(
                    children: [
                      Text(
                        'Ringkasan Pesanan',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'comfortaa',
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '(${widget.nama.length})',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontFamily: 'comfortaa',
                        ),
                      ),
                    ],
                  ),
                  //
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tampil = !tampil;
                      });
                    },
                    child: !tampil
                        ? Text('Tampilkan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.greenAccent,
                              decoration: TextDecoration.underline,
                            ))
                        : Text('Sembunyikan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.greenAccent,
                              decoration: TextDecoration.underline,
                            )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            tampil
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.nama == null ? 0 : widget.nama.length,
                    itemBuilder: (BuildContext context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue[100]!),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.nama[i]['name'].toString()),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: 1.5,
                                      color: Colors.grey,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(
                                      //     top: MediaQuery.of(context).size.height / 20),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('gambar/rupiah.png'),
                                        ),
                                      ),
                                    ),
                                    //
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'Rp ',
                                              decimalDigits: 0)
                                          .format(int.parse(widget.nama[i]
                                                  ['price_min']
                                              .toString())),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.yellow[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(),
            //
            tampil
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.blue[100]!),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jadwal',
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(
                                  //     top: MediaQuery.of(context).size.height / 20),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('gambar/jadwal.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(widget.jadwal),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('-'),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(widget.jam),
                                Text(':'),
                                Text(widget.menit)
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //
                            Row(
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(
                                  //     top: MediaQuery.of(context).size.height / 20),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('gambar/alamat.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Flexible(child: Text(widget.alamat))
                              ],
                            ),
                            //
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(widget.domisiliproblem),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            //
            Padding(
              padding: const EdgeInsets.only(left: 1.0, right: 1, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    // height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                        // color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                      // controller: domisiliproblem,
                      // textAlign: TextAlign.left,
                      // ignore: unnecessary_new
                      decoration: new InputDecoration(
                        fillColor: Colors.blue[50],
                        filled: true,
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        hintText: 'Masukkan Kode Promo',
                        // prefixIcon: Padding(
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Image.asset(
                        //     'gambar/email.png',
                        //     width: 25,
                        //     height: 25,
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            // margin: EdgeInsets.only(
                            //     top: MediaQuery.of(context).size.height / 20),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('gambar/Discount.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Pakai',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.blue[100]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pembayaran',
                          ),
                          Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp',
                                      decimalDigits: 0)
                                  .format(int.parse(widget.harga
                                      .reduce((a, b) => a + b)
                                      .toString())),
                              style: TextStyle(
                                  // fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue))
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtottal',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                          SizedBox(width: 5),
                          Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp',
                                      decimalDigits: 0)
                                  .format(int.parse(widget.harga
                                      .reduce((a, b) => a + b)
                                      .toString())),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Biaya Admin',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                          // SizedBox(width: 5),
                          Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp',
                                      decimalDigits: 0)
                                  .format(
                                int.parse('0'),
                              ),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                        ],
                      ),
                      //
                      SizedBox(
                        height: 5,
                      ),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Potongan',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                          SizedBox(width: 5),
                          Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp',
                                      decimalDigits: 0)
                                  .format(0),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Metode Pembayaran'),
            ),
            //
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 2),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                      color: Colors.blue[50]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('e-Wallet / QRIS',
                            style: TextStyle(
                                color: Colors.blue[300],
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                pembayaran = !pembayaran;
                              });
                            },
                            child: !pembayaran
                                ? Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('gambar/pembayaran.png'),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'gambar/pembayaran1.png'),
                                      ),
                                    ),
                                  )),
                      ],
                    ),
                  )),
            ),
            //
            pembayaran
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: payment == null ? 0 : payment.length,
                    itemBuilder: (BuildContext context, i) {
                      return GestureDetector(
                        onTap: () {
                          print(payment[i]['id']);
                          setState(() {
                            methodpayment = payment[i]['id'];
                            pressed = true;
                            _selected = !_selected;
                          });
                          //  getDataPembayaran();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    _selected ? Colors.blue[100] : Colors.white,
                                border: Border.all(color: Colors.blue[100]!)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 10, top: 2),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Row(
                                  children: [
                                    // Text('${methodpayment}'),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(payment[i]['image']),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      payment[i]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : SizedBox(),
            //
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 18),
              child: GestureDetector(
                onTap: () async {
                  addData();
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => DetailPembayaran(
                                orderid: '${order_id}',
                                harga: widget.harga,
                                seluruh: widget.nama)));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 17.0),
                      child: Center(
                        child: Text(
                          'Bayar Sekarang',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            //  Text('${widget.apartement}'),
            // Text('${widget.apartement??''}'),
            // Text(widget.jadwal)
          ],
        ),
      ),
    );
  }
}
