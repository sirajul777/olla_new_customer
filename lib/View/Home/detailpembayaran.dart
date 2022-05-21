import 'dart:async';
import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Home/steporder.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPembayaran extends StatefulWidget {
  String orderid;
  List harga;
  List seluruh;
  // String koment;
// Get Key Data
  DetailPembayaran(
      {Key? key,
      required this.seluruh,
      required this.harga,
      required this.orderid})
      : super(key: key);
  @override
  State<DetailPembayaran> createState() => _DetailPembayaranState();
}

class _DetailPembayaranState extends State<DetailPembayaran> {
  bool tampil = false;
  late Timer timer;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    List fee = widget.harga + [0];
    return Scaffold(
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
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 80,
              ),
              GestureDetector(
                onTap: () {
                  // print(datalist);
                },
                child: GestureDetector(
                  onTap: () {
                    getDataListHome();
                  },
                  child: const Text(
                    "Detail Pembayaran",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'comfortaa',
                    ),
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
        //stack atas unutk membuat container sukses failed dan null
        body: Stack(
          children: [
            //stack yang kedua unutk Batalkan Pesanan
            Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Row(
                            children: const [
                              Text(
                                'Invoice ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '',
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
                                getDataListHome();
                                // setState(() {
                                //   tampil = !tampil;
                                // });
                              },
                              child: Text(
                                invoice,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.amberAccent),
                              )),
                        ],
                      ),
                    ),
                    //
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 13),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const Text(
                                'Lakukan Pembayaran Sebelum',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '26 Feburuari 2022',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.red),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'Pukul',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '10.00 am',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Row(
                            children: [
                              const Text(
                                'Ringkasan Pesanan',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'comfortaa',
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(${widget.harga.length})',
                                style: const TextStyle(
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
                                ? const Text('Tampilkan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.greenAccent,
                                      decoration: TextDecoration.underline,
                                    ))
                                : const Text('Sembunyikan',
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
                    //
                    const SizedBox(height: 8),
                    tampil
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.seluruh == null
                                ? 0
                                : widget.seluruh.length,
                            itemBuilder: (BuildContext context, i) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.blue[100]!),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(widget.seluruh[i]['name']
                                            .toString()),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              height: 1.5,
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              // margin: EdgeInsets.only(
                                              //     top: MediaQuery.of(context).size.height / 20),
                                              width: 30,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'gambar/rupiah.png'),
                                                ),
                                              ),
                                            ),
                                            //
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp ',
                                                      decimalDigits: 0)
                                                  .format(int.parse(widget
                                                      .seluruh[i]['price_min']
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
                        : const SizedBox(),
                    //
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue[50]!),
                          borderRadius: BorderRadius.circular(12),
                          // color: Colors.red
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(gambar),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              //
                              Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0)
                                    .format(int.parse(fee
                                        .reduce((a, b) => a + b)
                                        .toString())),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue,
                                    fontSize: 18),
                              ),
                              //
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                'Nomor Handphone',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                '081234567890',
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //
                    GestureDetector(
                      onTap: () {
                        print('kjsfkjsdfhksdkfsdhfdsh');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 15),
                        child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                border: Border.all(color: Colors.blue[50]!),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                  'ini adalah bukti pesanan yang Anda lakukan dengan nomor $invoice. Harap tunggu sampai mitra kami mengambil pesanan.',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      height: 1.5,
                                      fontSize: 14)),
                            )),
                      ),
                    ),
                    //
                  ],
                ),
                //ini unutk stack kedua
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Dashboard()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text('Batalkan Pesanan',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline)),
                    ),
                  ),
                )
              ],
            ),
            // ini yang container sukses failed dan null
            status == 'SUCCEEDED'
                ? Center(
                    child: Padding(
                    padding:
                        const EdgeInsets.only(left: 50.0, right: 50, top: 70),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.withOpacity(0.7)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(width: 24),
                              Text('Pembayaran Berhasil',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )),
                  ))
                : status == 'PENDING'
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, right: 50, top: 70),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.indigo.withOpacity(0.7)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Loading(
                                    indicator: BallPulseIndicator(),
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 24),
                                  const Text('Menunggu Pembayaran',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )),
                      ))
                    : status == 'FAILED'
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.only(
                                left: 50.0, right: 50, top: 70),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red.withOpacity(0.8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(width: 24),
                                      Text('Maaf Pembayaran Gagal',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                )),
                          ))
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.height,
                            color: Colors.transparent,
                            child: const Center(
                              child: SpinKitPouringHourGlassRefined(
                                color: Colors.blue,
                                size: 50.0,
                              ),
                            ))
          ],
        ));
  }

  //
  late List datalist;
  late String customer;
  late String invoice;
  late String status;
  late String gambar;
  late int grandtotal;
  late int adminfee;
  // String status;
  getDataListHome() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(
        Uri.parse(Uri.encodeFull(
            'https://olla.ws/api/customer/v1/order-detail/${widget.orderid}')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
          "Authorization": "Bearer $customer",
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      invoice = converDataToJson['invoice'];
      status = converDataToJson['payments']['status'];
      gambar = converDataToJson['payments']['image'];
      grandtotal = converDataToJson['grand_total'];
      adminfee = converDataToJson['admin_fee'];
      // datalist = converDataToJson;

      // ignore: avoid_print
      // print(converDataToJson['payments']['status']);
      print(converDataToJson);
    });
    return "Success";
  }

  @override
  void initState() {
    getDataListHome();
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (status == "SUCCEEDED") {
        //Stop if has status PENDING
        timer.cancel();
        Future.delayed(const Duration(seconds: 4), () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => StepOrder(
                        invoice: invoice,
                        orderid: widget.orderid,
                        seluruhdata: widget.seluruh)));
          });
        });
      }
      setState(() {
        getDataListHome();
      });
    });
  }

//
  // void addValue() {
  //   setState(() {
  //     getDataListHome();
  //   });
  // }

//
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

//
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {
  //     getDataListHome();
  //   });
  // }
}
