import 'dart:async';
import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Home/steporder.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPembayaran extends StatefulWidget {
  int orderid;
  int harga;
  List seluruh;
  // String koment;
// Get Key Data
  DetailPembayaran({Key? key, required this.seluruh, required this.harga, required this.orderid}) : super(key: key);
  @override
  State<DetailPembayaran> createState() => _DetailPembayaranState();
}

class _DetailPembayaranState extends State<DetailPembayaran> {
  bool tampil = false;
  late Timer timer;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    int fee = widget.harga + 0;
    if (!loading) {
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
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      style: TextStyle(color: darkGrey, fontSize: 16, fontWeight: FontWeight.bold),
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
                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //
                            Row(
                              children: const [
                                Text(
                                  'Nomor Tagihan ',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: darkGrey),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
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
                                      fontWeight: FontWeight.w600, fontSize: 16, color: Colors.amberAccent),
                                )),
                          ],
                        ),
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 13),
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
                                  'Lakukan pembayaran sebelum',
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: darkGrey),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Center(
                                  child: Text.rich(TextSpan(
                                      text: 'Waktu pembayaran : ',
                                      style: TextStyle(color: darkGrey, fontSize: 12.sp),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: timerDisplayString,
                                          style: TextStyle(color: redDanger, fontSize: 12.sp),
                                        ),
                                      ])),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Tanggal : ',
                                          style:
                                              TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: darkGrey),
                                        ),
                                        Text(
                                          '${dateTime.day}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.red),
                                        ),
                                        Text(
                                          '${_month[dateTime.month - 1]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.red),
                                        ),
                                        Text(
                                          '${dateTime.year}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '- Waktu',
                                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: darkGrey),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '${dateTime.hour}:${dateTime.minute}',
                                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //
                            Row(
                              children: [
                                const Text(
                                  'Ringkasan Pesanan',
                                  style: TextStyle(
                                    color: darkGrey,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '(${widget.seluruh.length})',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
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
                              itemCount: widget.seluruh == null ? 0 : widget.seluruh.length,
                              itemBuilder: (BuildContext context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
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
                                          offset: const Offset(0, 5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(widget.seluruh[i]['name'].toString()),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(height: 1.5, color: Colors.grey, fontSize: 12),
                                          ),
                                          const SizedBox(
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
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage('gambar/rupiah.png'),
                                                  ),
                                                ),
                                              ),
                                              //
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                                    .format(int.parse(widget.seluruh[i]['price_min'].toString())),
                                                style:
                                                    TextStyle(fontWeight: FontWeight.w700, color: Colors.yellow[600]),
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
                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
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
                                    image: DecorationImage(image: NetworkImage(gambar), fit: BoxFit.cover),
                                  ),
                                ),
                                //
                                Text(
                                  NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(fee),
                                  style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.blue, fontSize: 18),
                                ),
                                //
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text(
                                  'Nomor Gawai Kamu',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: darkGrey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  nomerhp,
                                  style: TextStyle(fontSize: 16, color: darkGrey, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                          child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  border: Border.all(color: Colors.blue[50]!),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                      child: Text.rich(
                                    TextSpan(
                                        text: 'Ini adalah bukti pesanan yang Anda lakukan dengan nomor tagihan ',
                                        style: TextStyle(color: softGrey),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '$invoice.',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: darkGrey),
                                          ),
                                          TextSpan(
                                            text: ' Harap tunggu sampai mitra kami mengambil pesanan.',
                                            style: TextStyle(color: softGrey),
                                          )
                                        ]),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 12.sp),
                                    softWrap: true,
                                  )))),
                        ),
                      ),

                      //
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      top: MediaQuery.of(context).padding.top,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
                              (Route<dynamic> route) => false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 30.w),
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text('Batalkan Pesanan',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: redDanger)),
                          ),
                        ),
                      ))
                  //ini unutk stack kedua
                ],
              ),
              // ini yang container sukses failed dan null
              status == 'SUCCEEDED'
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20, top: 320.w),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.green.withOpacity(0.7)),
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
                                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          )),
                    ))
                  : status == 'PENDING'
                      ? Center(
                          child: Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20, top: 320.w),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), color: Colors.indigo.withOpacity(0.7)),
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
                                        style:
                                            TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              )),
                        ))
                      : status == 'FAILED'
                          ? GestureDetector(
                              onTap: () {},
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20, top: 320.w),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10), color: Colors.red.withOpacity(0.8)),
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
                                                  fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    )),
                              )))
                          : Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.height,
                              color: Colors.transparent,
                              child: const Center(
                                child: SpinKitPouringHourGlassRefined(
                                  color: Colors.blue,
                                  size: 50.0,
                                ),
                              )),
            ],
          ));
    }
  }

  //
  late List datalist;
  late String customer;
  late String invoice;
  late String status;
  late String gambar;
  late int grandtotal;
  late int adminfee;
  late var partner;
  late String nomerhp;
  // String status;
  getDataListHome() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    print(customer);
    var response = await http
        .get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order-detail/${widget.orderid}')), headers: {
      // .get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order-detail/${1066}')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer $customer",
    });
    var converDataToJson = json.decode(response.body);

    setState(() {
      invoice = converDataToJson['invoice'];
      status = converDataToJson['payments']['status'];
      gambar = converDataToJson['payments']['image'];
      grandtotal = converDataToJson['grand_total'];
      adminfee = converDataToJson['admin_fee'];
      nomerhp = converDataToJson['payments']['phone'];
      print(nomerhp);
      print(converDataToJson);
    });
    return converDataToJson;
    // var converDataToJson = json.decode(response.body);
    // if (converDataToJson['payments']['status'] == "SUCCEDED") {
    //   // tampilan step order
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (BuildContext context) => StepOrder(
    //               invoice: invoice,
    //               orderid: widget.orderid,
    //               seluruhdata: widget.seluruh)));
    // } else {
    //   //set statre
    //   setState(() {
    //     invoice = converDataToJson['invoice'];
    //     status = converDataToJson['payments']['status'];
    //     gambar = converDataToJson['payments']['image'];
    //     grandtotal = converDataToJson['grand_total'];
    //     adminfee = converDataToJson['admin_fee'];
    //     // datalist = converDataToJson;

    //     // ignore: avoid_print
    //     // print(converDataToJson['payments']['status']);
    //     print(converDataToJson);
    //   });
    // }

    // return "Success";
  }

  DateTime dateTime = DateTime.now();
  late String tanggal;
  late String jam;
  late String detik;
  List<String> _month = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  Duration duration = Duration(hours: 1, minutes: 6, seconds: 30);

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  DateTime getDateTime() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.second);
  }

  int _start = 90;
  String get timerDisplayString {
    var duration = _start;

    return formatHHMMSS(duration);
  }

  String formatHHMMSS(int seconds) {
    var hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    var minutes = (seconds / 60).truncate();

    var hoursStr = (hours).toString().padLeft(2, '0');
    var minutesStr = (minutes).toString().padLeft(2, '0');
    var secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return '$minutesStr:$secondsStr';
    }

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  Future startTimer() async {
    const oneSec = Duration(seconds: 1);
    if (mounted) {
      Timer _timer;
      _timer = Timer.periodic(oneSec, (Timer timer) {
        if (mounted) {
          if (_start == 0) {
            setState(() {
              timer.cancel();
            });
          } else {
            setState(() {
              _start--;
            });
          }
        }
      });
    }
  }

  bool loading = false;

  @override
  void initState() {
    getDataListHome();
    dateTime = getDateTime();
    startTimer();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        loading = !loading;
      });
    });
    super.initState();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      getDataListHome();
      if (status == "SUCCEEDED") {
        _start = 0;
        timer.cancel();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    StepOrder(invoice: invoice, orderid: widget.orderid, seluruhdata: widget.seluruh)),
            (Route<dynamic> route) => false);
      }
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
