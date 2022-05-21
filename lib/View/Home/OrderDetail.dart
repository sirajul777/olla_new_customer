import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Home/lanjutpembayaran.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetail extends StatefulWidget {
  List? datahalaman;
  List? iddata;
  List? iddharga;
  List? iddnama;
  String? alamat;
  String? longitude;
  String? latitude;
  String? id;
  String? koment;
  int? angka;
  int? serviceid;
  // String koment;
// Get Key Data
  OrderDetail(
      {Key? key,
      this.iddnama,
      this.iddharga,
      this.iddata,
      this.datahalaman,
      this.angka,
      this.alamat,
      this.longitude,
      this.latitude,
      this.id,
      this.koment,
      this.serviceid})
      : super(key: key);
  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  var result;
  var result1;
  late int idapartement;
  late int? idrumah;
  var kaki;
  // Group Value for Radio Button.
  int id = 1;
  List<String> _locations = [
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
  ]; // Option 2
  //
  List<String> _locations2 = [
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
  ]; // Option 2
  //
  List<String> _locations3 = [
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
  ]; // Option 2
  //
  List<String> _locations4 = [
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ]; // Option 2
  //
  List<String> _locations5 = [
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ]; // Option 2
  //
  List<String> _locations6 = [
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ]; // Option 2
  //
  List<String> _locations7 = [
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ]; // Option 2
  //
  List<String> _locations8 = [
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ]; // Option 2
  //
  List<String> _locations9 = [
    'September',
    'Oktober',
    'November',
    'Desember'
  ]; // Option 2
  //
  List<String> _locations10 = ['Oktober', 'November', 'Desember']; // Option 2
  //
  List<String> _locations11 = ['November', 'Desember']; // Option 2
  //
  List<String> _locations12 = ['Desember']; // Option 2
//
//
  List<String> _tanggal = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal2 = [
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal3 = [
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal4 = [
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal5 = [
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal6 = [
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal7 = [
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal8 = [
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal9 = [
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal10 = [
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal11 = [
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal12 = [
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal13 = [
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal14 = [
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal15 = [
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal16 = [
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal17 = [
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal18 = [
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal19 = [
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal20 = [
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal21 = [
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal22 = [
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal23 = [
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  //
  List<String> _tanggal24 = ['24', '25', '26', '27', '28', '29', '30', '31'];
  //
  List<String> _tanggal25 = ['25', '26', '27', '28', '29', '30', '31'];
  //
  List<String> _tanggal26 = ['26', '27', '28', '29', '30', '31'];
  //
  List<String> _tanggal27 = ['27', '28', '29', '30', '31'];
  //
  List<String> _tanggal28 = ['28', '29', '30', '31'];
  //
  List<String> _tanggal29 = ['29', '30', '31'];
  //
  List<String> _tanggal30 = ['30', '31'];
  //
  List<String> _tanggal31 = ['31'];
  //
  List<String> _tahun = ['2022', '2023', '2024', '2025'];
  List<String> _jam = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24'
  ];
  List<String> _menit = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59'
  ];
  late String _tanggalsekarang14;
  String? _selectedLocation;
  late String _selectedLocationstack;
  String? _selectedLocation1; // Option 2
  String? _selectedLocation2;
  late String _selectedLocation3 = '00';
  String? _selectedLocation4;
  late String jadwal;
  late String tanggalharini;
  late String bulanini;
  late String tahunini;
  late String bulanlalu;
  var tanggalsemalam;
  late String bulandepan;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getDataListHome();
    getDataDomisili();
    alamat();
    kaki;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isloading = true;
      });
    });

    // loadCounter1();
    // loadCounter2();
  }

//tanggal
  late DateTime _myDateTime;
  String time = 'Pilih Tanggal';
  //waktu
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<Null> _selectedTime(BuildContext context) async {
    final TimeOfDay? picked_time = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    if (picked_time != null && picked_time != selectedTime)
      setState(() {
        selectedTime = picked_time;
      });
  }

  late String _dropDownValue;
  //
  late List datalist;
  late int service;
  late int method;
  late int dataid;
  late int dataid1;
  late int dataid2;
  late int dataid3;
  late int dataid4;
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
      method = converDataToJson['data'][0]['payment_method_group_id'];
      // ignore: avoid_print
      // print(datalist);
      // print(service);
      print(method);
    });
    return "Success";
  }

  late String customer;

  //
  late String home;
  late int _valProvince;
  List domisili = [];
  late String apartement = '';
  late String rumah = '';
  late int apartmentid;
  late int rumahid;
  getDataDomisili() async {
    var response = await http.get(
        Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/domisili')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      domisili = converDataToJson['data'];
      apartement = converDataToJson['data'][0]['name'];
      rumah = converDataToJson['data'][1]['name'];
      apartmentid = converDataToJson['data'][0]['id'];
      rumahid = converDataToJson['data'][1]['id'];
      // ignore: avoid_print
      // print(domisili);
      print(apartement);
      print(rumah);
    });
    return "Success";
  }

  List<String> _data = [
    "1",
    "2",
    "3",
  ];
  TextEditingController domisiliproblem = TextEditingController();
  final wishlistArrayGlb = <String>[];
// String text = 'Android iOS Fuschia Linux Windows MacOS';
//   List result = text.split(' ');
  late List iddata;
  late List hitung;
  late String angka;
  main() {
//     String arrayText = '{"tags": [${widget.koment}]}';
//  var saya= arrayText.replaceAll(' ','');
//   print(saya.split(' ')[0]);
// var send = [{' '+widget.koment[1]}];
// print(send);
    String text = '${dataid}';
    String text1 = '${dataid1}';
    String text2 = '${dataid2}';
    String text3 = '${dataid3}';
    String text4 = '${dataid4}';
    String result = text + text1 + text2 + text3 + text4;
    print(result);

    var id = '["$dataid", "$dataid1", "$dataid2", "$dataid3", "$dataid4"]';
    var ab = json.decode(id);
    setState(() {
      iddata = ab;
    });
    print(iddata[1]); // returns "one"
//
// List<Map<String, dynamic>> partner_packages=[] ;

// partner_packages = [{'id':iddata}];
// // setState(() {
// //  hitung = sended[0]['id'] ;
// // });
// hitung = partner_packages;
// // print(hitung[0]['id']);
// print(angka);
// angka = hitung[0]['id'];
  }

//
  late int partner1;
  late int partner2;
  late String partner3;
  int _groupValue = -1;
  late List jsonn;
  late int map0;
  late int map1;
  String kosong = '';
  List yes = [];
  List sayak = [2500, 2300];
// List krisdianto;
  List<Map<String, dynamic>> datak = [];
  dataku() async {
    List datatt = widget.iddharga!;

    var sum = datatt.reduce((a, b) => a + b);
//   }
    setState(() {});
    print("Sum : $sum");

    var send = [
      {partner1},
      {partner2}
    ];
    datak = [
      {
        "id": mapkosong,
        "qty": mapkosong,
        "comment": "p",
      },
      {
        "id": mapsatu,
        "qty": mapsatu,
        "comment": "",
      },
    ];
    //  Map<String, dynamic> indexedData = {};

    // datak.forEach((mapElement) {
    //   Map map = mapElement as Map;
    //   map.forEach((key, value) {
    //     indexedData[key] = value;
    //   });
    // });
    // print(datak);
    // print(kamu);
//  "partner_packages":[{
//         {"id":'2',"qty":'2',"comment":'pp'},
//         {"id":'3',"qty":'2',"comment":'pp'}
//       }],
  }

  //
  Dio dio = Dio();
  //
  late int mapkosong;
  late int mapsatu;
  late int mapdua;
  late int maptiga;
  late int mapempat;
  late int hitung1;
  late int hitung2;
  int kosongs = 0;
  List anak1 = [];
  Future postData() async {
//    List list1 = ['steve'];
// Map mapp = list1.asMap();
// print(mapp);
//    //
    List list = widget.iddata!;
    Map map1 = list.asMap();
    mapkosong = map1[0];
    mapsatu = map1[1];
    mapdua = map1[2];
    maptiga = map1[3];
    mapempat = map1[4];
    hitung1 = map1.length;
    hitung2 = map1.length;
    print(mapsatu);
    print(hitung1);
//  var anak =  widget.iddata;
//   print(anak);
//   for (int i = 0;i<anak.length;i++){
//     // print(anak[i]);
//     anak[i];
//   }
//   print(anak1);
// List list1 = widget.iddata;
// Map mapp = list1.asMap();
// print(mapp);
// print(map1[0]??'');
    // var send = [{"id": "1","qty":"1","comment":"asdasd"},{"id": "3","qty":"1","comment":"asdasd"} ];
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    final String pathUrl = '${KEY.BASE_URL}/v1/order-post';
    // final String pathUrl= 'https://jsonplaceholder.typicode.com/posts';
    //  //
    var datakris = {
      "customer_id": '${service}',
      "working_date": selectedTime.format(context),
      "working_time": '${time}',
      "description": '${result ?? result1}',
      "method_payment_id": '${method}',
      "longitude": '${widget.longitude}',
      "latitude": '${widget.latitude}',
      "domisili_id": '${idapartement != null ? idapartement : idrumah}',
      "address_note": '${domisiliproblem.text}',
      "partner_packages": [
        {
          "id": mapkosong,
          "qty": mapkosong,
          "comment": "p",
        },
      ],
      "address": "${widget.alamat}"
    };
    //
    var datakris1 = {
      "customer_id": '${service}',
      "working_date": selectedTime.format(context),
      "working_time": '${time}',
      "description": '${result ?? result1}',
      "method_payment_id": '${method}',
      "longitude": '${widget.longitude}',
      "latitude": '${widget.latitude}',
      "domisili_id": '${idapartement != null ? idapartement : idrumah}',
      "address_note": '${domisiliproblem.text}',
      "partner_packages": [
        {
          "id": mapkosong,
          "qty": mapkosong,
          "comment": "p",
        },
        {
          "id": mapsatu,
          "qty": mapsatu,
          "comment": "p",
        },
      ],
      "address": "${widget.alamat}"
    };
    //
    var datakris2 = {
      "customer_id": '${service}',
      "working_date": selectedTime.format(context),
      "working_time": '${time}',
      "description": '${result ?? result1}',
      "method_payment_id": '${method}',
      "longitude": '${widget.longitude}',
      "latitude": '${widget.latitude}',
      "domisili_id": '${idapartement != null ? idapartement : idrumah}',
      "address_note": '${domisiliproblem.text}',
      "partner_packages": [
        {
          "id": mapkosong,
          "qty": mapkosong,
          "comment": "p",
        },
        {
          "id": mapsatu,
          "qty": mapsatu,
          "comment": "p",
        },
        {
          "id": mapdua,
          "qty": mapdua,
          "comment": "p",
        },
      ],
      "address": "${widget.alamat}"
    };
    //
    var datakris3 = {
      "customer_id": '${service}',
      "working_date": selectedTime.format(context),
      "working_time": '${time}',
      "description": '${result ?? result1}',
      "method_payment_id": '${method}',
      "longitude": '${widget.longitude}',
      "latitude": '${widget.latitude}',
      "domisili_id": '${idapartement != null ? idapartement : idrumah}',
      "address_note": '${domisiliproblem.text}',
      "partner_packages": [
        {
          "id": mapkosong,
          "qty": mapkosong,
          "comment": "p",
        },
        {
          "id": mapsatu,
          "qty": mapsatu,
          "comment": "p",
        },
        {
          "id": mapdua,
          "qty": mapdua,
          "comment": "p",
        },
        {
          "id": maptiga,
          "qty": maptiga,
          "comment": "p",
        },
      ],
      "address": "${widget.alamat}"
    };
    var response = await dio.post(pathUrl,
        data: mapsatu == null
            ? datakris
            : mapdua == null
                ? datakris1
                : maptiga == null
                    ? datakris2
                    : datakris3,
        options: Options(
          //081283960337
          headers: {
            'Accept': 'application/json',
            "x-token-olla": KEY.APIKEY,
            "Authorization": "Bearer $customer",
            // "Content-Type": "application/json;charset=UTF-8",
          },
        ));
    return response.data;
  }

  //
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  //
  Widget _buildItem(String item, Animation<double> animation, int index) {
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: ListTile(
                title: Text('${widget.datahalaman![index]['name']}',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'gambar/rupiah.png',
                        width: 25,
                        height: 25,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 10),
                      Text(
                          NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp', decimalDigits: 0)
                              .format(int.parse('${item}')),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.yellow[800])),
                    ],
                  ),
                ),
                trailing: IconButton(
                    icon: Image.asset(
                      'gambar/Delete.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                    onPressed: () {
                      widget.iddharga!.length == 1
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: SpinKitPouringHourGlassRefined(
                                    color: Colors.blue,
                                    size: 50.0,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          // _dismissDialog();
                                        },
                                        child: Center(
                                            child:
                                                Text('tidak boleh kosong!!!'))),
                                  ],
                                );
                              })
                          : _removeItem(index);
                      // getdata();
                      setState(() {
                        kaki =
                            widget.iddharga!.reduce((a, b) => a + b).toString();
                      });
                    }),
              ),
            ),
          ),
        ));
  }

  //
  void _removeItem(int i) {
    int removedItem = widget.iddharga!.removeAt(i);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem.toString(), animation, i);
    };
    _key.currentState!.removeItem(i, builder);
  }

  //
  late String jam;
  late String menit;
  semuajadwal() async {
    DateTime now = DateTime.now();
    final current_mon = now.month;
// print(months[current_mon-1]);

    setState(() {
      jam = ("$_selectedLocation3");
      menit = ("$_selectedLocation4");
      tanggalstack = ("$_selectedLocationstack");
      jadwal =
          ("${_selectedLocation1} ? ${now.day} ? ${_selectedLocation} : ${tahunini}");
      print(jadwal);
    });
  }

  late String tanggalstack;
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

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm ').format(now);
    // String tanggal = DateFormat(  "dd/MMMM/yyyy", "id_ID").format(now);
    tahunini = DateFormat("yyyy", "id_ID").format(now);
    bulanini = DateFormat("MMMM", "id_ID").format(now);
    tanggalharini = DateFormat("dd", "id_ID").format(now);
    tanggalsemalam = now.day - 1;
    bulanlalu = _locations[now.month - 2];
    bulandepan = _locations[now.month - 1];
    //
    String waktu = _selectedLocation3 == '00'
        ? 'AM'
        : _selectedLocation3 == '01'
            ? 'AM'
            : _selectedLocation3 == '02'
                ? 'AM'
                : _selectedLocation3 == '03'
                    ? 'AM'
                    : _selectedLocation3 == '04'
                        ? 'AM'
                        : _selectedLocation3 == '05'
                            ? 'AM'
                            : _selectedLocation3 == '06'
                                ? 'AM'
                                : _selectedLocation3 == '07'
                                    ? 'AM'
                                    : _selectedLocation3 == '08'
                                        ? 'AM'
                                        : _selectedLocation3 == '09'
                                            ? 'AM'
                                            : _selectedLocation3 == '10'
                                                ? 'AM'
                                                : _selectedLocation3 == '11'
                                                    ? 'AM'
                                                    : _selectedLocation3 == '12'
                                                        ? 'PM'
                                                        : _selectedLocation3 ==
                                                                '13'
                                                            ? 'PM'
                                                            : _selectedLocation3 ==
                                                                    '14'
                                                                ? 'PM'
                                                                : _selectedLocation3 ==
                                                                        '15'
                                                                    ? 'PM'
                                                                    : _selectedLocation3 ==
                                                                            '16'
                                                                        ? 'PM'
                                                                        : _selectedLocation3 ==
                                                                                '17'
                                                                            ? 'PM'
                                                                            : _selectedLocation3 == '18'
                                                                                ? 'PM'
                                                                                : _selectedLocation3 == '19'
                                                                                    ? 'PM'
                                                                                    : _selectedLocation3 == '20'
                                                                                        ? 'PM'
                                                                                        : _selectedLocation3 == '21'
                                                                                            ? 'PM'
                                                                                            : _selectedLocation3 == '22'
                                                                                                ? 'PM'
                                                                                                : _selectedLocation3 == '23'
                                                                                                    ? 'PM'
                                                                                                    : 'AM/PM';
    // var sum = widget.iddharga.reduce((a, b) => a + b);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: !isloading
          ? Container()
          : Scaffold(
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
                        dataku();
                      },
                      child: Text(
                        'Atur Jadwal',
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
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(
                                      //     top: MediaQuery.of(context).size.height / 3.5),
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'gambar/navigation.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Lokasi Tujuan',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        alamat();
                                      },
                                      child: Text(
                                        'Sesuaikan',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green[400],
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            //
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                    child: Text(
                                  Address,
                                  style: TextStyle(fontSize: 12),
                                ))),
                            //
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Tipe Domisili',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            //
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('${apartement}'),
                                    value: 0,
                                    groupValue: _groupValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _groupValue = value!;
                                        result = apartement;
                                        idapartement = apartmentid;
                                        getDataDomisili();
                                        print(idapartement);
                                        print(result);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('${rumah}'),
                                    value: 1,
                                    groupValue: _groupValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        getDataDomisili();
                                        _groupValue = value!;
                                        result1 = rumah;
                                        idrumah = rumahid;
                                        print(result1);
                                        print(idrumah);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Tambahkan Catatan Alamat',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: BoxDecoration(
                                  // color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextField(
                                controller: domisiliproblem,
                                // textAlign: TextAlign.left,
                                // ignore: unnecessary_new
                                decoration: new InputDecoration(
                                  fillColor: Colors.blue[50],
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  hintText: 'Tulis catatan disini',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image.asset(
                                      'gambar/email.png',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Atur Jadwal',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200]!),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tanggal',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 85,
                                          padding: EdgeInsets.only(
                                              left: _selectedLocation1 != null
                                                  ? 35
                                                  : 35),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.blue[50],
                                            border:
                                                Border.all(color: Colors.blue),
                                            // color: Colors.blue[200]
                                          ),
                                          //
                                          //
                                          child: tanggalharini == _tanggal2[0]
                                              ? DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    //  iconSize: 0,
                                                    icon: Visibility(
                                                      visible: false,
                                                      child: Icon(
                                                          Icons.h_mobiledata),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),

                                                    hint: Center(
                                                        child: Text(
                                                      tanggalharini,
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    )), // Not necessary for Option 1
                                                    value: _selectedLocation1,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        _selectedLocation1 =
                                                            newValue!;
                                                        print(
                                                            _selectedLocation1);
                                                      });
                                                    },
                                                    items: _tanggal2
                                                        .map((tanggal2) {
                                                      return DropdownMenuItem(
                                                        child:
                                                            new Text(tanggal2),
                                                        value: tanggal2,
                                                      );
                                                    }).toList(),
                                                  ),
                                                )
                                              : tanggalharini == _tanggal3[0]
                                                  ? DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        //  iconSize: 0,
                                                        icon: Visibility(
                                                          visible: false,
                                                          child: Icon(Icons
                                                              .h_mobiledata),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),

                                                        hint: Center(
                                                            child: Text(
                                                          tanggalharini,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        )), // Not necessary for Option 1
                                                        value:
                                                            _selectedLocation1,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            _selectedLocation1 =
                                                                newValue!;
                                                            print(
                                                                _selectedLocation1);
                                                          });
                                                        },
                                                        items: _tanggal3
                                                            .map((tanggal3) {
                                                          return DropdownMenuItem(
                                                            child: new Text(
                                                                tanggal3),
                                                            value: tanggal3,
                                                          );
                                                        }).toList(),
                                                      ),
                                                    )
                                                  : tanggalharini ==
                                                          _tanggal4[0]
                                                      ? DropdownButtonHideUnderline(
                                                          child: DropdownButton(
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            //  iconSize: 0,
                                                            icon: Visibility(
                                                              visible: false,
                                                              child: Icon(Icons
                                                                  .h_mobiledata),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),

                                                            hint: Center(
                                                                child: Text(
                                                              tanggalharini,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            )), // Not necessary for Option 1
                                                            value:
                                                                _selectedLocation1,
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                _selectedLocation1 =
                                                                    newValue!;
                                                                print(
                                                                    _selectedLocation1);
                                                              });
                                                            },
                                                            items: _tanggal4
                                                                .map(
                                                                    (tanggal4) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                    tanggal4),
                                                                value: tanggal4,
                                                              );
                                                            }).toList(),
                                                          ),
                                                        )
                                                      : tanggalharini ==
                                                              _tanggal5[0]
                                                          ? DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                //  iconSize: 0,
                                                                icon:
                                                                    Visibility(
                                                                  visible:
                                                                      false,
                                                                  child: Icon(Icons
                                                                      .h_mobiledata),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),

                                                                hint: Center(
                                                                    child: Text(
                                                                  tanggalharini,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                                )), // Not necessary for Option 1
                                                                value:
                                                                    _selectedLocation1,
                                                                onChanged: (String?
                                                                    newValue) {
                                                                  setState(() {
                                                                    _selectedLocation1 =
                                                                        newValue!;
                                                                    print(
                                                                        _selectedLocation1);
                                                                  });
                                                                },
                                                                items: _tanggal5
                                                                    .map(
                                                                        (tanggal5) {
                                                                  return DropdownMenuItem(
                                                                    child: new Text(
                                                                        tanggal5),
                                                                    value:
                                                                        tanggal5,
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            )
                                                          : tanggalharini ==
                                                                  _tanggal6[0]
                                                              ? DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                    //  iconSize: 0,
                                                                    icon:
                                                                        Visibility(
                                                                      visible:
                                                                          false,
                                                                      child: Icon(
                                                                          Icons
                                                                              .h_mobiledata),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),

                                                                    hint: Center(
                                                                        child: Text(
                                                                      tanggalharini,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    )), // Not necessary for Option 1
                                                                    value:
                                                                        _selectedLocation1,
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        _selectedLocation1 =
                                                                            newValue!;
                                                                        print(
                                                                            _selectedLocation1);
                                                                      });
                                                                    },
                                                                    items: _tanggal6
                                                                        .map(
                                                                            (tanggal6) {
                                                                      return DropdownMenuItem(
                                                                        child: new Text(
                                                                            tanggal6),
                                                                        value:
                                                                            tanggal6,
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                )
                                                              : tanggalharini ==
                                                                      _tanggal7[
                                                                          0]
                                                                  ? DropdownButtonHideUnderline(
                                                                      child:
                                                                          DropdownButton(
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.blue,
                                                                            fontWeight: FontWeight.w500),
                                                                        //  iconSize: 0,
                                                                        icon:
                                                                            Visibility(
                                                                          visible:
                                                                              false,
                                                                          child:
                                                                              Icon(Icons.h_mobiledata),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),

                                                                        hint: Center(
                                                                            child: Text(
                                                                          tanggalharini,
                                                                          style:
                                                                              TextStyle(color: Colors.blue),
                                                                        )), // Not necessary for Option 1
                                                                        value:
                                                                            _selectedLocation1,
                                                                        onChanged:
                                                                            (String?
                                                                                newValue) {
                                                                          setState(
                                                                              () {
                                                                            _selectedLocation1 =
                                                                                newValue!;
                                                                            print(_selectedLocation1);
                                                                          });
                                                                        },
                                                                        items: _tanggal7
                                                                            .map((tanggal7) {
                                                                          return DropdownMenuItem(
                                                                            child:
                                                                                new Text(tanggal7),
                                                                            value:
                                                                                tanggal7,
                                                                          );
                                                                        }).toList(),
                                                                      ),
                                                                    )
                                                                  : tanggalharini ==
                                                                          _tanggal8[
                                                                              0]
                                                                      ? DropdownButtonHideUnderline(
                                                                          child:
                                                                              DropdownButton(
                                                                            style:
                                                                                TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                            //  iconSize: 0,
                                                                            icon:
                                                                                Visibility(
                                                                              visible: false,
                                                                              child: Icon(Icons.h_mobiledata),
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),

                                                                            hint: Center(
                                                                                child: Text(
                                                                              tanggalharini,
                                                                              style: TextStyle(color: Colors.blue),
                                                                            )), // Not necessary for Option 1
                                                                            value:
                                                                                _selectedLocation1,
                                                                            onChanged:
                                                                                (String? newValue) {
                                                                              setState(() {
                                                                                _selectedLocation1 = newValue!;
                                                                                print(_selectedLocation1);
                                                                              });
                                                                            },
                                                                            items:
                                                                                _tanggal8.map((tanggal8) {
                                                                              return DropdownMenuItem(
                                                                                child: new Text(tanggal8),
                                                                                value: tanggal8,
                                                                              );
                                                                            }).toList(),
                                                                          ),
                                                                        )
                                                                      : tanggalharini ==
                                                                              _tanggal9[0]
                                                                          ? DropdownButtonHideUnderline(
                                                                              child: DropdownButton(
                                                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                //  iconSize: 0,
                                                                                icon: Visibility(
                                                                                  visible: false,
                                                                                  child: Icon(Icons.h_mobiledata),
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(20),

                                                                                hint: Center(
                                                                                    child: Text(
                                                                                  tanggalharini,
                                                                                  style: TextStyle(color: Colors.blue),
                                                                                )), // Not necessary for Option 1
                                                                                value: _selectedLocation1,
                                                                                onChanged: (String? newValue) {
                                                                                  setState(() {
                                                                                    _selectedLocation1 = newValue!;
                                                                                    print(_selectedLocation1);
                                                                                  });
                                                                                },
                                                                                items: _tanggal9.map((tanggal9) {
                                                                                  return DropdownMenuItem(
                                                                                    child: new Text(tanggal9),
                                                                                    value: tanggal9,
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            )
                                                                          : tanggalharini == _tanggal10[0]
                                                                              ? DropdownButtonHideUnderline(
                                                                                  child: DropdownButton(
                                                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                    //  iconSize: 0,
                                                                                    icon: Visibility(
                                                                                      visible: false,
                                                                                      child: Icon(Icons.h_mobiledata),
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(20),

                                                                                    hint: Center(
                                                                                        child: Text(
                                                                                      tanggalharini,
                                                                                      style: TextStyle(color: Colors.blue),
                                                                                    )), // Not necessary for Option 1
                                                                                    value: _selectedLocation1,
                                                                                    onChanged: (String? newValue) {
                                                                                      setState(() {
                                                                                        _selectedLocation1 = newValue!;
                                                                                        print(_selectedLocation1);
                                                                                      });
                                                                                    },
                                                                                    items: _tanggal10.map((tanggal10) {
                                                                                      return DropdownMenuItem(
                                                                                        child: new Text(tanggal10),
                                                                                        value: tanggal10,
                                                                                      );
                                                                                    }).toList(),
                                                                                  ),
                                                                                )
                                                                              : tanggalharini == _tanggal11[0]
                                                                                  ? DropdownButtonHideUnderline(
                                                                                      child: DropdownButton(
                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                        //  iconSize: 0,
                                                                                        icon: Visibility(
                                                                                          visible: false,
                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                        hint: Center(
                                                                                            child: Text(
                                                                                          tanggalharini,
                                                                                          style: TextStyle(color: Colors.blue),
                                                                                        )), // Not necessary for Option 1
                                                                                        value: _selectedLocation1,
                                                                                        onChanged: (String? newValue) {
                                                                                          setState(() {
                                                                                            _selectedLocation1 = newValue!;
                                                                                            print(_selectedLocation1);
                                                                                          });
                                                                                        },
                                                                                        items: _tanggal11.map((tanggal11) {
                                                                                          return DropdownMenuItem(
                                                                                            child: new Text(tanggal11),
                                                                                            value: tanggal11,
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    )
                                                                                  : tanggalharini == _tanggal12[0]
                                                                                      ? DropdownButtonHideUnderline(
                                                                                          child: DropdownButton(
                                                                                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                            //  iconSize: 0,
                                                                                            icon: Visibility(
                                                                                              visible: false,
                                                                                              child: Icon(Icons.h_mobiledata),
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(20),

                                                                                            hint: Center(
                                                                                                child: Text(
                                                                                              tanggalharini,
                                                                                              style: TextStyle(color: Colors.blue),
                                                                                            )), // Not necessary for Option 1
                                                                                            value: _selectedLocation1,
                                                                                            onChanged: (String? newValue) {
                                                                                              setState(() {
                                                                                                _selectedLocation1 = newValue!;
                                                                                                print(_selectedLocation1);
                                                                                              });
                                                                                            },
                                                                                            items: _tanggal12.map((tanggal12) {
                                                                                              return DropdownMenuItem(
                                                                                                child: new Text(tanggal12),
                                                                                                value: tanggal12,
                                                                                              );
                                                                                            }).toList(),
                                                                                          ),
                                                                                        )
                                                                                      : tanggalharini == _tanggal13[0]
                                                                                          ? DropdownButtonHideUnderline(
                                                                                              child: DropdownButton(
                                                                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                //  iconSize: 0,
                                                                                                icon: Visibility(
                                                                                                  visible: false,
                                                                                                  child: Icon(Icons.h_mobiledata),
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(20),

                                                                                                hint: Center(
                                                                                                    child: Text(
                                                                                                  tanggalharini,
                                                                                                  style: TextStyle(color: Colors.blue),
                                                                                                )), // Not necessary for Option 1
                                                                                                value: _selectedLocation1,
                                                                                                onChanged: (String? newValue) {
                                                                                                  setState(() {
                                                                                                    _selectedLocation1 = newValue!;
                                                                                                    print(_selectedLocation1);
                                                                                                  });
                                                                                                },
                                                                                                items: _tanggal13.map((tanggal13) {
                                                                                                  return DropdownMenuItem(
                                                                                                    child: new Text(tanggal13),
                                                                                                    value: tanggal13,
                                                                                                  );
                                                                                                }).toList(),
                                                                                              ),
                                                                                            )
                                                                                          : tanggalharini == _tanggal14[0]
                                                                                              ? DropdownButtonHideUnderline(
                                                                                                  child: DropdownButton(
                                                                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                    //  iconSize: 0,
                                                                                                    icon: Visibility(
                                                                                                      visible: false,
                                                                                                      child: Icon(Icons.h_mobiledata),
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(20),

                                                                                                    hint: Center(
                                                                                                        child: Text(
                                                                                                      tanggalharini,
                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                    )), // Not necessary for Option 1
                                                                                                    value: _selectedLocation1,
                                                                                                    onChanged: (String? newValue) {
                                                                                                      setState(() {
                                                                                                        _selectedLocation1 = newValue!;
                                                                                                        print(_selectedLocation1);
                                                                                                      });
                                                                                                    },
                                                                                                    items: _tanggal14.map((tanggal14) {
                                                                                                      return DropdownMenuItem(
                                                                                                        child: new Text(tanggal14),
                                                                                                        value: tanggal14,
                                                                                                      );
                                                                                                    }).toList(),
                                                                                                  ),
                                                                                                )
                                                                                              : tanggalharini == _tanggal15[0]
                                                                                                  ? DropdownButtonHideUnderline(
                                                                                                      child: DropdownButton(
                                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                        //  iconSize: 0,
                                                                                                        icon: Visibility(
                                                                                                          visible: false,
                                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                                        hint: Center(
                                                                                                            child: Text(
                                                                                                          tanggalharini,
                                                                                                          style: TextStyle(color: Colors.blue),
                                                                                                        )), // Not necessary for Option 1
                                                                                                        value: _selectedLocation1,
                                                                                                        onChanged: (String? newValue) {
                                                                                                          setState(() {
                                                                                                            _selectedLocation1 = newValue!;
                                                                                                            print(_selectedLocation1);
                                                                                                          });
                                                                                                        },
                                                                                                        items: _tanggal15.map((tanggal15) {
                                                                                                          return DropdownMenuItem(
                                                                                                            child: new Text(tanggal15),
                                                                                                            value: tanggal15,
                                                                                                          );
                                                                                                        }).toList(),
                                                                                                      ),
                                                                                                    )
                                                                                                  : tanggalharini == _tanggal16[0]
                                                                                                      ? DropdownButtonHideUnderline(
                                                                                                          child: DropdownButton(
                                                                                                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                            //  iconSize: 0,
                                                                                                            icon: Visibility(
                                                                                                              visible: false,
                                                                                                              child: Icon(Icons.h_mobiledata),
                                                                                                            ),
                                                                                                            borderRadius: BorderRadius.circular(20),

                                                                                                            hint: Center(
                                                                                                                child: Text(
                                                                                                              tanggalharini,
                                                                                                              style: TextStyle(color: Colors.blue),
                                                                                                            )), // Not necessary for Option 1
                                                                                                            value: _selectedLocation1,
                                                                                                            onChanged: (String? newValue) {
                                                                                                              setState(() {
                                                                                                                _selectedLocation1 = newValue!;
                                                                                                                print(_selectedLocation1);
                                                                                                              });
                                                                                                            },
                                                                                                            items: _tanggal16.map((tanggal16) {
                                                                                                              return DropdownMenuItem(
                                                                                                                child: new Text(tanggal16),
                                                                                                                value: tanggal16,
                                                                                                              );
                                                                                                            }).toList(),
                                                                                                          ),
                                                                                                        )
                                                                                                      : tanggalharini == _tanggal17[0]
                                                                                                          ? DropdownButtonHideUnderline(
                                                                                                              child: DropdownButton(
                                                                                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                //  iconSize: 0,
                                                                                                                icon: Visibility(
                                                                                                                  visible: false,
                                                                                                                  child: Icon(Icons.h_mobiledata),
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(20),

                                                                                                                hint: Center(
                                                                                                                    child: Text(
                                                                                                                  tanggalharini,
                                                                                                                  style: TextStyle(color: Colors.blue),
                                                                                                                )), // Not necessary for Option 1
                                                                                                                value: _selectedLocation1,
                                                                                                                onChanged: (String? newValue) {
                                                                                                                  setState(() {
                                                                                                                    _selectedLocation1 = newValue!;
                                                                                                                    print(_selectedLocation1);
                                                                                                                  });
                                                                                                                },
                                                                                                                items: _tanggal17.map((tanggal17) {
                                                                                                                  return DropdownMenuItem(
                                                                                                                    child: new Text(tanggal17),
                                                                                                                    value: tanggal17,
                                                                                                                  );
                                                                                                                }).toList(),
                                                                                                              ),
                                                                                                            )
                                                                                                          : tanggalharini == _tanggal18[0]
                                                                                                              ? DropdownButtonHideUnderline(
                                                                                                                  child: DropdownButton(
                                                                                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                    //  iconSize: 0,
                                                                                                                    icon: Visibility(
                                                                                                                      visible: false,
                                                                                                                      child: Icon(Icons.h_mobiledata),
                                                                                                                    ),
                                                                                                                    borderRadius: BorderRadius.circular(20),

                                                                                                                    hint: Center(
                                                                                                                        child: Text(
                                                                                                                      tanggalharini,
                                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                                    )), // Not necessary for Option 1
                                                                                                                    value: _selectedLocation1,
                                                                                                                    onChanged: (String? newValue) {
                                                                                                                      setState(() {
                                                                                                                        _selectedLocation1 = newValue!;
                                                                                                                        print(_selectedLocation1);
                                                                                                                      });
                                                                                                                    },
                                                                                                                    items: _tanggal18.map((tanggal18) {
                                                                                                                      return DropdownMenuItem(
                                                                                                                        child: new Text(tanggal18),
                                                                                                                        value: tanggal18,
                                                                                                                      );
                                                                                                                    }).toList(),
                                                                                                                  ),
                                                                                                                )
                                                                                                              : tanggalharini == _tanggal19[0]
                                                                                                                  ? DropdownButtonHideUnderline(
                                                                                                                      child: DropdownButton(
                                                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                        //  iconSize: 0,
                                                                                                                        icon: Visibility(
                                                                                                                          visible: false,
                                                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                                                        ),
                                                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                                                        hint: Center(
                                                                                                                            child: Text(
                                                                                                                          tanggalharini,
                                                                                                                          style: TextStyle(color: Colors.blue),
                                                                                                                        )), // Not necessary for Option 1
                                                                                                                        value: _selectedLocation1,
                                                                                                                        onChanged: (String? newValue) {
                                                                                                                          setState(() {
                                                                                                                            _selectedLocation1 = newValue!;
                                                                                                                            print(_selectedLocation1);
                                                                                                                          });
                                                                                                                        },
                                                                                                                        items: _tanggal19.map((tanggal19) {
                                                                                                                          return DropdownMenuItem(
                                                                                                                            child: new Text(tanggal19),
                                                                                                                            value: tanggal19,
                                                                                                                          );
                                                                                                                        }).toList(),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  : tanggalharini == _tanggal20[0]
                                                                                                                      ? DropdownButtonHideUnderline(
                                                                                                                          child: DropdownButton(
                                                                                                                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                            //  iconSize: 0,
                                                                                                                            icon: Visibility(
                                                                                                                              visible: false,
                                                                                                                              child: Icon(Icons.h_mobiledata),
                                                                                                                            ),
                                                                                                                            borderRadius: BorderRadius.circular(20),

                                                                                                                            hint: Center(
                                                                                                                                child: Text(
                                                                                                                              tanggalharini,
                                                                                                                              style: TextStyle(color: Colors.blue),
                                                                                                                            )), // Not necessary for Option 1
                                                                                                                            value: _selectedLocation1,
                                                                                                                            onChanged: (String? newValue) {
                                                                                                                              setState(() {
                                                                                                                                _selectedLocation1 = newValue!;
                                                                                                                                print(_selectedLocation1);
                                                                                                                              });
                                                                                                                            },
                                                                                                                            items: _tanggal20.map((tanggal20) {
                                                                                                                              return DropdownMenuItem(
                                                                                                                                child: new Text(tanggal20),
                                                                                                                                value: tanggal20,
                                                                                                                              );
                                                                                                                            }).toList(),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      : tanggalharini == _tanggal21[0]
                                                                                                                          ? DropdownButtonHideUnderline(
                                                                                                                              child: DropdownButton(
                                                                                                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                //  iconSize: 0,
                                                                                                                                icon: Visibility(
                                                                                                                                  visible: false,
                                                                                                                                  child: Icon(Icons.h_mobiledata),
                                                                                                                                ),
                                                                                                                                borderRadius: BorderRadius.circular(20),

                                                                                                                                hint: Center(
                                                                                                                                    child: Text(
                                                                                                                                  tanggalharini,
                                                                                                                                  style: TextStyle(color: Colors.blue),
                                                                                                                                )), // Not necessary for Option 1
                                                                                                                                value: _selectedLocation1,
                                                                                                                                onChanged: (String? newValue) {
                                                                                                                                  setState(() {
                                                                                                                                    _selectedLocation1 = newValue!;
                                                                                                                                    print(_selectedLocation1);
                                                                                                                                  });
                                                                                                                                },
                                                                                                                                items: _tanggal21.map((tanggal21) {
                                                                                                                                  return DropdownMenuItem(
                                                                                                                                    child: new Text(tanggal21),
                                                                                                                                    value: tanggal21,
                                                                                                                                  );
                                                                                                                                }).toList(),
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          : tanggalharini == _tanggal22[0]
                                                                                                                              ? DropdownButtonHideUnderline(
                                                                                                                                  child: DropdownButton(
                                                                                                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                    //  iconSize: 0,
                                                                                                                                    icon: Visibility(
                                                                                                                                      visible: false,
                                                                                                                                      child: Icon(Icons.h_mobiledata),
                                                                                                                                    ),
                                                                                                                                    borderRadius: BorderRadius.circular(20),

                                                                                                                                    hint: Center(
                                                                                                                                        child: Text(
                                                                                                                                      tanggalharini,
                                                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                                                    )), // Not necessary for Option 1
                                                                                                                                    value: _selectedLocation1,
                                                                                                                                    onChanged: (String? newValue) {
                                                                                                                                      setState(() {
                                                                                                                                        _selectedLocation1 = newValue!;
                                                                                                                                        print(_selectedLocation1);
                                                                                                                                      });
                                                                                                                                    },
                                                                                                                                    items: _tanggal22.map((tanggal22) {
                                                                                                                                      return DropdownMenuItem(
                                                                                                                                        child: new Text(tanggal22),
                                                                                                                                        value: tanggal22,
                                                                                                                                      );
                                                                                                                                    }).toList(),
                                                                                                                                  ),
                                                                                                                                )
                                                                                                                              : tanggalharini == _tanggal23[0]
                                                                                                                                  ? DropdownButtonHideUnderline(
                                                                                                                                      child: DropdownButton(
                                                                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                        //  iconSize: 0,
                                                                                                                                        icon: Visibility(
                                                                                                                                          visible: false,
                                                                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                                                                        ),
                                                                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                                                                        hint: Center(
                                                                                                                                            child: Text(
                                                                                                                                          tanggalharini,
                                                                                                                                          style: TextStyle(color: Colors.blue),
                                                                                                                                        )), // Not necessary for Option 1
                                                                                                                                        value: _selectedLocation1,
                                                                                                                                        onChanged: (String? newValue) {
                                                                                                                                          setState(() {
                                                                                                                                            _selectedLocation1 = newValue!;
                                                                                                                                            print(_selectedLocation1);
                                                                                                                                          });
                                                                                                                                        },
                                                                                                                                        items: _tanggal23.map((tanggal23) {
                                                                                                                                          return DropdownMenuItem(
                                                                                                                                            child: new Text(tanggal23),
                                                                                                                                            value: tanggal23,
                                                                                                                                          );
                                                                                                                                        }).toList(),
                                                                                                                                      ),
                                                                                                                                    )
                                                                                                                                  : tanggalharini == _tanggal24[0]
                                                                                                                                      ? DropdownButtonHideUnderline(
                                                                                                                                          child: DropdownButton(
                                                                                                                                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                            //  iconSize: 0,
                                                                                                                                            icon: Visibility(
                                                                                                                                              visible: false,
                                                                                                                                              child: Icon(Icons.h_mobiledata),
                                                                                                                                            ),
                                                                                                                                            borderRadius: BorderRadius.circular(20),

                                                                                                                                            hint: Center(
                                                                                                                                                child: Text(
                                                                                                                                              tanggalharini,
                                                                                                                                              style: TextStyle(color: Colors.blue),
                                                                                                                                            )), // Not necessary for Option 1
                                                                                                                                            value: _selectedLocation1,
                                                                                                                                            onChanged: (String? newValue) {
                                                                                                                                              setState(() {
                                                                                                                                                _selectedLocation1 = newValue!;
                                                                                                                                                print(_selectedLocation1);
                                                                                                                                              });
                                                                                                                                            },
                                                                                                                                            items: _tanggal24.map((tanggal24) {
                                                                                                                                              return DropdownMenuItem(
                                                                                                                                                child: new Text(tanggal24),
                                                                                                                                                value: tanggal24,
                                                                                                                                              );
                                                                                                                                            }).toList(),
                                                                                                                                          ),
                                                                                                                                        )
                                                                                                                                      : tanggalharini == _tanggal25[0]
                                                                                                                                          ? DropdownButtonHideUnderline(
                                                                                                                                              child: DropdownButton(
                                                                                                                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                                //  iconSize: 0,
                                                                                                                                                icon: Visibility(
                                                                                                                                                  visible: false,
                                                                                                                                                  child: Icon(Icons.h_mobiledata),
                                                                                                                                                ),
                                                                                                                                                borderRadius: BorderRadius.circular(20),

                                                                                                                                                hint: Center(
                                                                                                                                                    child: Text(
                                                                                                                                                  tanggalharini,
                                                                                                                                                  style: TextStyle(color: Colors.blue),
                                                                                                                                                )), // Not necessary for Option 1
                                                                                                                                                value: _selectedLocation1,
                                                                                                                                                onChanged: (String? newValue) {
                                                                                                                                                  setState(() {
                                                                                                                                                    _selectedLocation1 = newValue!;
                                                                                                                                                    print(_selectedLocation1);
                                                                                                                                                  });
                                                                                                                                                },
                                                                                                                                                items: _tanggal25.map((tanggal25) {
                                                                                                                                                  return DropdownMenuItem(
                                                                                                                                                    child: new Text(tanggal25),
                                                                                                                                                    value: tanggal25,
                                                                                                                                                  );
                                                                                                                                                }).toList(),
                                                                                                                                              ),
                                                                                                                                            )
                                                                                                                                          : tanggalharini == _tanggal26[0]
                                                                                                                                              ? DropdownButtonHideUnderline(
                                                                                                                                                  child: DropdownButton(
                                                                                                                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                                    //  iconSize: 0,
                                                                                                                                                    icon: Visibility(
                                                                                                                                                      visible: false,
                                                                                                                                                      child: Icon(Icons.h_mobiledata),
                                                                                                                                                    ),
                                                                                                                                                    borderRadius: BorderRadius.circular(20),

                                                                                                                                                    hint: Center(
                                                                                                                                                        child: Text(
                                                                                                                                                      tanggalharini,
                                                                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                                                                    )), // Not necessary for Option 1
                                                                                                                                                    value: _selectedLocation1,
                                                                                                                                                    onChanged: (String? newValue) {
                                                                                                                                                      setState(() {
                                                                                                                                                        _selectedLocation1 = newValue!;
                                                                                                                                                        print(_selectedLocation1);
                                                                                                                                                      });
                                                                                                                                                    },
                                                                                                                                                    items: _tanggal26.map((tanggal26) {
                                                                                                                                                      return DropdownMenuItem(
                                                                                                                                                        child: new Text(tanggal26),
                                                                                                                                                        value: tanggal26,
                                                                                                                                                      );
                                                                                                                                                    }).toList(),
                                                                                                                                                  ),
                                                                                                                                                )
                                                                                                                                              : tanggalharini == _tanggal27[0]
                                                                                                                                                  ? DropdownButtonHideUnderline(
                                                                                                                                                      child: DropdownButton(
                                                                                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                                        //  iconSize: 0,
                                                                                                                                                        icon: Visibility(
                                                                                                                                                          visible: false,
                                                                                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                                                                                        ),
                                                                                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                                                                                        hint: Center(
                                                                                                                                                            child: Text(
                                                                                                                                                          tanggalharini,
                                                                                                                                                          style: TextStyle(color: Colors.blue),
                                                                                                                                                        )), // Not necessary for Option 1
                                                                                                                                                        value: _selectedLocation1,
                                                                                                                                                        onChanged: (String? newValue) {
                                                                                                                                                          setState(() {
                                                                                                                                                            _selectedLocation1 = newValue!;
                                                                                                                                                            print(_selectedLocation1);
                                                                                                                                                          });
                                                                                                                                                        },
                                                                                                                                                        items: _tanggal27.map((tanggal27) {
                                                                                                                                                          return DropdownMenuItem(
                                                                                                                                                            child: new Text(tanggal27),
                                                                                                                                                            value: tanggal27,
                                                                                                                                                          );
                                                                                                                                                        }).toList(),
                                                                                                                                                      ),
                                                                                                                                                    )
                                                                                                                                                  : tanggalharini == _tanggal28[0]
                                                                                                                                                      ? DropdownButtonHideUnderline(
                                                                                                                                                          child: DropdownButton(
                                                                                                                                                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                                            //  iconSize: 0,
                                                                                                                                                            icon: Visibility(
                                                                                                                                                              visible: false,
                                                                                                                                                              child: Icon(Icons.h_mobiledata),
                                                                                                                                                            ),
                                                                                                                                                            borderRadius: BorderRadius.circular(20),

                                                                                                                                                            hint: Center(
                                                                                                                                                                child: Text(
                                                                                                                                                              tanggalharini,
                                                                                                                                                              style: TextStyle(color: Colors.blue),
                                                                                                                                                            )), // Not necessary for Option 1
                                                                                                                                                            value: _selectedLocation1,
                                                                                                                                                            onChanged: (String? newValue) {
                                                                                                                                                              setState(() {
                                                                                                                                                                _selectedLocation1 = newValue!;
                                                                                                                                                                print(_selectedLocation1);
                                                                                                                                                              });
                                                                                                                                                            },
                                                                                                                                                            items: _tanggal28.map((tanggal28) {
                                                                                                                                                              return DropdownMenuItem(
                                                                                                                                                                child: new Text(tanggal28),
                                                                                                                                                                value: tanggal28,
                                                                                                                                                              );
                                                                                                                                                            }).toList(),
                                                                                                                                                          ),
                                                                                                                                                        )
                                                                                                                                                      : tanggalharini == _tanggal29[0]
                                                                                                                                                          ? DropdownButtonHideUnderline(
                                                                                                                                                              child: DropdownButton(
                                                                                                                                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                                                //  iconSize: 0,
                                                                                                                                                                icon: Visibility(
                                                                                                                                                                  visible: false,
                                                                                                                                                                  child: Icon(Icons.h_mobiledata),
                                                                                                                                                                ),
                                                                                                                                                                borderRadius: BorderRadius.circular(20),

                                                                                                                                                                hint: Center(
                                                                                                                                                                    child: Text(
                                                                                                                                                                  tanggalharini,
                                                                                                                                                                  style: TextStyle(color: Colors.blue),
                                                                                                                                                                )), // Not necessary for Option 1
                                                                                                                                                                value: _selectedLocation1,
                                                                                                                                                                onChanged: (String? newValue) {
                                                                                                                                                                  setState(() {
                                                                                                                                                                    _selectedLocation1 = newValue!;
                                                                                                                                                                    print(_selectedLocation1);
                                                                                                                                                                  });
                                                                                                                                                                },
                                                                                                                                                                items: _tanggal29.map((tanggal29) {
                                                                                                                                                                  return DropdownMenuItem(
                                                                                                                                                                    child: new Text(tanggal29),
                                                                                                                                                                    value: tanggal29,
                                                                                                                                                                  );
                                                                                                                                                                }).toList(),
                                                                                                                                                              ),
                                                                                                                                                            )
                                                                                                                                                          : tanggalharini == _tanggal30[0]
                                                                                                                                                              ? DropdownButtonHideUnderline(
                                                                                                                                                                  child: DropdownButton(
                                                                                                                                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                                                    //  iconSize: 0,
                                                                                                                                                                    icon: Visibility(
                                                                                                                                                                      visible: false,
                                                                                                                                                                      child: Icon(Icons.h_mobiledata),
                                                                                                                                                                    ),
                                                                                                                                                                    borderRadius: BorderRadius.circular(20),

                                                                                                                                                                    hint: Center(
                                                                                                                                                                        child: Text(
                                                                                                                                                                      tanggalharini,
                                                                                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                                                                                    )), // Not necessary for Option 1
                                                                                                                                                                    value: _selectedLocation1,
                                                                                                                                                                    onChanged: (String? newValue) {
                                                                                                                                                                      setState(() {
                                                                                                                                                                        _selectedLocation1 = newValue!;
                                                                                                                                                                        print(_selectedLocation1);
                                                                                                                                                                      });
                                                                                                                                                                    },
                                                                                                                                                                    items: _tanggal30.map((tanggal30) {
                                                                                                                                                                      return DropdownMenuItem(
                                                                                                                                                                        child: new Text(tanggal30),
                                                                                                                                                                        value: tanggal30,
                                                                                                                                                                      );
                                                                                                                                                                    }).toList(),
                                                                                                                                                                  ),
                                                                                                                                                                )
                                                                                                                                                              : tanggalharini == _tanggal31[0]
                                                                                                                                                                  ? DropdownButtonHideUnderline(
                                                                                                                                                                      child: DropdownButton(
                                                                                                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                                                        //  iconSize: 0,
                                                                                                                                                                        icon: Visibility(
                                                                                                                                                                          visible: false,
                                                                                                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                                                                                                        ),
                                                                                                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                                                                                                        hint: Center(
                                                                                                                                                                            child: Text(
                                                                                                                                                                          tanggalharini,
                                                                                                                                                                          style: TextStyle(color: Colors.blue),
                                                                                                                                                                        )), // Not necessary for Option 1
                                                                                                                                                                        value: _selectedLocation1,
                                                                                                                                                                        onChanged: (String? newValue) {
                                                                                                                                                                          setState(() {
                                                                                                                                                                            _selectedLocation1 = newValue!;
                                                                                                                                                                            print(_selectedLocation1);
                                                                                                                                                                          });
                                                                                                                                                                        },
                                                                                                                                                                        items: _tanggal31.map((tanggal31) {
                                                                                                                                                                          return DropdownMenuItem(
                                                                                                                                                                            child: new Text(tanggal31),
                                                                                                                                                                            value: tanggal31,
                                                                                                                                                                          );
                                                                                                                                                                        }).toList(),
                                                                                                                                                                      ),
                                                                                                                                                                    )
                                                                                                                                                                  : DropdownButtonHideUnderline(
                                                                                                                                                                      child: DropdownButton(
                                                                                                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                                                                                                        //  iconSize: 0,
                                                                                                                                                                        icon: Visibility(
                                                                                                                                                                          visible: false,
                                                                                                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                                                                                                        ),
                                                                                                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                                                                                                        hint: Center(
                                                                                                                                                                            child: Text(
                                                                                                                                                                          tanggalharini,
                                                                                                                                                                          style: TextStyle(color: Colors.blue),
                                                                                                                                                                        )), // Not necessary for Option 1
                                                                                                                                                                        value: _selectedLocation1,
                                                                                                                                                                        onChanged: (String? newValue) {
                                                                                                                                                                          setState(() {
                                                                                                                                                                            _selectedLocation1 = newValue!;
                                                                                                                                                                            print(_selectedLocation1);
                                                                                                                                                                          });
                                                                                                                                                                        },
                                                                                                                                                                        items: _tanggal.map((tanggal) {
                                                                                                                                                                          return DropdownMenuItem(
                                                                                                                                                                            child: new Text(tanggal),
                                                                                                                                                                            value: tanggal,
                                                                                                                                                                          );
                                                                                                                                                                        }).toList(),
                                                                                                                                                                      ),
                                                                                                                                                                    ),
                                        ),
                                        //stack
                                        Container(
                                          width: 85,
                                          padding: EdgeInsets.only(
                                              left: _selectedLocation1 != null
                                                  ? 35
                                                  : 35),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.blue[50],
                                            border:
                                                Border.all(color: Colors.blue),
                                            // color: Colors.blue[200]
                                          ),
                                          child: _selectedLocation == bulandepan
                                              ? SizedBox()
                                              : _selectedLocation == null
                                                  ? SizedBox()
                                                  : DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        //  iconSize: 0,
                                                        icon: Visibility(
                                                          visible: false,
                                                          child: Icon(Icons
                                                              .h_mobiledata),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),

                                                        hint: Center(
                                                            child: Text(
                                                          tanggalharini,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        )), // Not necessary for Option 1
                                                        value:
                                                            _selectedLocationstack,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            _selectedLocationstack =
                                                                newValue!;
                                                            print(
                                                                _selectedLocationstack);
                                                          });
                                                        },
                                                        items: _tanggal.map(
                                                            (tanggalstack) {
                                                          return DropdownMenuItem(
                                                            child: new Text(
                                                                tanggalstack),
                                                            value: tanggalstack,
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                        )
                                        // _selectedLocation!=bulandepan?SizedBox():Text('jhhgjggh'),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    //
                                    Container(
                                      width: 110,
                                      padding: EdgeInsets.only(
                                          left: _selectedLocation == 'Januari'
                                              ? 33
                                              : _selectedLocation == 'Februari'
                                                  ? 30
                                                  : _selectedLocation == 'Maret'
                                                      ? 36
                                                      : _selectedLocation ==
                                                              'April'
                                                          ? 36
                                                          : _selectedLocation ==
                                                                  'Mei'
                                                              ? 38
                                                              : _selectedLocation ==
                                                                      'Juni'
                                                                  ? 38
                                                                  : _selectedLocation ==
                                                                          'Juli'
                                                                      ? 38
                                                                      : _selectedLocation ==
                                                                              'Agustus'
                                                                          ? 30
                                                                          : _selectedLocation == 'September'
                                                                              ? 23
                                                                              : _selectedLocation == 'Oktober'
                                                                                  ? 30
                                                                                  : _selectedLocation == 'November'
                                                                                      ? 25
                                                                                      : _selectedLocation == 'Desember'
                                                                                          ? 25
                                                                                          : 35),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.blue),
                                        color: Colors.blue[50],
                                        // color: Colors.blue[200]
                                      ),
                                      child: bulanini == _locations2[0]
                                          ? DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                //  iconSize: 0,
                                                icon: Visibility(
                                                  visible: false,
                                                  child:
                                                      Icon(Icons.h_mobiledata),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),

                                                hint: Text(
                                                  bulanini,
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ), // Not necessary for Option 1
                                                value: _selectedLocation,
                                                onChanged: (String? newValue1) {
                                                  setState(() {
                                                    _selectedLocation =
                                                        newValue1!;
                                                  });
                                                },
                                                items: _locations2
                                                    .map((location2) {
                                                  return DropdownMenuItem(
                                                    child: new Text(location2),
                                                    value: location2,
                                                  );
                                                }).toList(),
                                              ),
                                            )
                                          : bulanini == _locations3[0]
                                              ? DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    //  iconSize: 0,
                                                    icon: Visibility(
                                                      visible: false,
                                                      child: Icon(
                                                          Icons.h_mobiledata),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),

                                                    hint: Text(
                                                      bulanini,
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ), // Not necessary for Option 1
                                                    value: _selectedLocation,
                                                    onChanged:
                                                        (String? newValue1) {
                                                      setState(() {
                                                        _selectedLocation =
                                                            newValue1!;
                                                      });
                                                    },
                                                    items: _locations3
                                                        .map((location3) {
                                                      return DropdownMenuItem(
                                                        child:
                                                            new Text(location3),
                                                        value: location3,
                                                      );
                                                    }).toList(),
                                                  ),
                                                )
                                              : bulanini == _locations4[0]
                                                  ? DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        //  iconSize: 0,
                                                        icon: Visibility(
                                                          visible: false,
                                                          child: Icon(Icons
                                                              .h_mobiledata),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),

                                                        hint: Text(
                                                          bulanini,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        ), // Not necessary for Option 1
                                                        value:
                                                            _selectedLocation,
                                                        onChanged: (String?
                                                            newValue1) {
                                                          setState(() {
                                                            _selectedLocation =
                                                                newValue1!;
                                                          });
                                                        },
                                                        items: _locations4
                                                            .map((location4) {
                                                          return DropdownMenuItem(
                                                            child: new Text(
                                                                location4),
                                                            value: location4,
                                                          );
                                                        }).toList(),
                                                      ),
                                                    )
                                                  : bulanini == _locations5[0]
                                                      ? DropdownButtonHideUnderline(
                                                          child: DropdownButton(
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            //  iconSize: 0,
                                                            icon: Visibility(
                                                              visible: false,
                                                              child: Icon(Icons
                                                                  .h_mobiledata),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),

                                                            hint: Text(
                                                              bulanini,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            ), // Not necessary for Option 1
                                                            value:
                                                                _selectedLocation,
                                                            onChanged: (String?
                                                                newValue1) {
                                                              setState(() {
                                                                _selectedLocation =
                                                                    newValue1!;
                                                              });
                                                            },
                                                            items: _locations5
                                                                .map(
                                                                    (location5) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                    location5),
                                                                value:
                                                                    location5,
                                                              );
                                                            }).toList(),
                                                          ),
                                                        )
                                                      : bulanini ==
                                                              _locations6[0]
                                                          ? DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                //  iconSize: 0,
                                                                icon:
                                                                    Visibility(
                                                                  visible:
                                                                      false,
                                                                  child: Icon(Icons
                                                                      .h_mobiledata),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),

                                                                hint: Text(
                                                                  bulanini,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                                ), // Not necessary for Option 1
                                                                value:
                                                                    _selectedLocation,
                                                                onChanged: (String?
                                                                    newValue1) {
                                                                  setState(() {
                                                                    _selectedLocation =
                                                                        newValue1!;
                                                                  });
                                                                },
                                                                items: _locations6
                                                                    .map(
                                                                        (location6) {
                                                                  return DropdownMenuItem(
                                                                    child: new Text(
                                                                        location6),
                                                                    value:
                                                                        location6,
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            )
                                                          : bulanini ==
                                                                  _locations7[0]
                                                              ? DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                    //  iconSize: 0,
                                                                    icon:
                                                                        Visibility(
                                                                      visible:
                                                                          false,
                                                                      child: Icon(
                                                                          Icons
                                                                              .h_mobiledata),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),

                                                                    hint: Text(
                                                                      bulanini,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ), // Not necessary for Option 1
                                                                    value:
                                                                        _selectedLocation,
                                                                    onChanged:
                                                                        (String?
                                                                            newValue1) {
                                                                      setState(
                                                                          () {
                                                                        _selectedLocation =
                                                                            newValue1!;
                                                                        print(
                                                                            newValue1);
                                                                      });
                                                                    },
                                                                    items: _locations7
                                                                        .map(
                                                                            (location7) {
                                                                      return DropdownMenuItem(
                                                                        child: new Text(
                                                                            location7),
                                                                        value:
                                                                            location7,
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                )
                                                              : bulanini ==
                                                                      _locations8[
                                                                          0]
                                                                  ? DropdownButtonHideUnderline(
                                                                      child:
                                                                          DropdownButton(
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.blue,
                                                                            fontWeight: FontWeight.w500),
                                                                        //  iconSize: 0,
                                                                        icon:
                                                                            Visibility(
                                                                          visible:
                                                                              false,
                                                                          child:
                                                                              Icon(Icons.h_mobiledata),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),

                                                                        hint:
                                                                            Text(
                                                                          bulanini,
                                                                          style:
                                                                              TextStyle(color: Colors.blue),
                                                                        ), // Not necessary for Option 1
                                                                        value:
                                                                            _selectedLocation,
                                                                        onChanged:
                                                                            (String?
                                                                                newValue1) {
                                                                          setState(
                                                                              () {
                                                                            _selectedLocation =
                                                                                newValue1!;
                                                                            print(newValue1);
                                                                          });
                                                                        },
                                                                        items: _locations8
                                                                            .map((location8) {
                                                                          return DropdownMenuItem(
                                                                            child:
                                                                                new Text(location8),
                                                                            value:
                                                                                location8,
                                                                          );
                                                                        }).toList(),
                                                                      ),
                                                                    )
                                                                  : bulanini ==
                                                                          _locations9[
                                                                              0]
                                                                      ? DropdownButtonHideUnderline(
                                                                          child:
                                                                              DropdownButton(
                                                                            style:
                                                                                TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                            //  iconSize: 0,
                                                                            icon:
                                                                                Visibility(
                                                                              visible: false,
                                                                              child: Icon(Icons.h_mobiledata),
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),

                                                                            hint:
                                                                                Text(
                                                                              bulanini,
                                                                              style: TextStyle(color: Colors.blue),
                                                                            ), // Not necessary for Option 1
                                                                            value:
                                                                                _selectedLocation,
                                                                            onChanged:
                                                                                (String? newValue1) {
                                                                              setState(() {
                                                                                _selectedLocation = newValue1!;
                                                                                print(newValue1);
                                                                              });
                                                                            },
                                                                            items:
                                                                                _locations9.map((location9) {
                                                                              return DropdownMenuItem(
                                                                                child: new Text(location9),
                                                                                value: location9,
                                                                              );
                                                                            }).toList(),
                                                                          ),
                                                                        )
                                                                      : bulanini ==
                                                                              _locations10[0]
                                                                          ? DropdownButtonHideUnderline(
                                                                              child: DropdownButton(
                                                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                //  iconSize: 0,
                                                                                icon: Visibility(
                                                                                  visible: false,
                                                                                  child: Icon(Icons.h_mobiledata),
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(20),

                                                                                hint: Text(
                                                                                  bulanini,
                                                                                  style: TextStyle(color: Colors.blue),
                                                                                ), // Not necessary for Option 1
                                                                                value: _selectedLocation,
                                                                                onChanged: (String? newValue1) {
                                                                                  setState(() {
                                                                                    _selectedLocation = newValue1!;
                                                                                  });
                                                                                },
                                                                                items: _locations10.map((location10) {
                                                                                  return DropdownMenuItem(
                                                                                    child: new Text(location10),
                                                                                    value: location10,
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            )
                                                                          : bulanini == _locations11[0]
                                                                              ? DropdownButtonHideUnderline(
                                                                                  child: DropdownButton(
                                                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                    //  iconSize: 0,
                                                                                    icon: Visibility(
                                                                                      visible: false,
                                                                                      child: Icon(Icons.h_mobiledata),
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(20),

                                                                                    hint: Text(
                                                                                      bulanini,
                                                                                      style: TextStyle(color: Colors.blue),
                                                                                    ), // Not necessary for Option 1
                                                                                    value: _selectedLocation,
                                                                                    onChanged: (String? newValue1) {
                                                                                      setState(() {
                                                                                        _selectedLocation = newValue1!;
                                                                                      });
                                                                                    },
                                                                                    items: _locations11.map((location11) {
                                                                                      return DropdownMenuItem(
                                                                                        child: new Text(location11),
                                                                                        value: location11,
                                                                                      );
                                                                                    }).toList(),
                                                                                  ),
                                                                                )
                                                                              : bulanini == _locations12[0]
                                                                                  ? DropdownButtonHideUnderline(
                                                                                      child: DropdownButton(
                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                        //  iconSize: 0,
                                                                                        icon: Visibility(
                                                                                          visible: false,
                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                        hint: Text(
                                                                                          bulanini,
                                                                                          style: TextStyle(color: Colors.blue),
                                                                                        ), // Not necessary for Option 1
                                                                                        value: _selectedLocation,
                                                                                        onChanged: (String? newValue1) {
                                                                                          setState(() {
                                                                                            _selectedLocation = newValue1!;
                                                                                          });
                                                                                        },
                                                                                        items: _locations12.map((location12) {
                                                                                          return DropdownMenuItem(
                                                                                            child: new Text(location12),
                                                                                            value: location12,
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    )
                                                                                  : DropdownButtonHideUnderline(
                                                                                      child: DropdownButton(
                                                                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                                                                        //  iconSize: 0,
                                                                                        icon: Visibility(
                                                                                          visible: false,
                                                                                          child: Icon(Icons.h_mobiledata),
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                        hint: Text(
                                                                                          bulanini,
                                                                                          style: TextStyle(color: Colors.blue),
                                                                                        ), // Not necessary for Option 1
                                                                                        value: _selectedLocation,
                                                                                        onChanged: (String? newValue1) {
                                                                                          setState(() {
                                                                                            _selectedLocation = newValue1!;
                                                                                          });
                                                                                        },
                                                                                        items: _locations.map((location) {
                                                                                          return DropdownMenuItem(
                                                                                            child: new Text(location),
                                                                                            value: location,
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    //
                                    Container(
                                      width: 100,
                                      padding: EdgeInsets.only(
                                          left: _selectedLocation2 != null
                                              ? 30
                                              : 13),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blue[50],
                                        border: Border.all(color: Colors.blue),
                                        // color: Colors.blue[200]
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500),
                                          //  iconSize: 0,
                                          icon: Visibility(
                                            visible: false,
                                            child: Icon(Icons.h_mobiledata),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),

                                          hint: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text(
                                              tahunini,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ), // Not necessary for Option 1
                                          value: _selectedLocation2,
                                          // onChanged: (newValue2) {
                                          //   setState(() {
                                          //     _selectedLocation2 = newValue2;
                                          //   });
                                          // },
                                          onChanged: null,
                                          items: _tahun.map((tahun) {
                                            return DropdownMenuItem(
                                              child: new Text(tahun),
                                              value: tahun,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //
                                //
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Pukul',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      padding: EdgeInsets.only(left: 28),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blue[50],
                                        border: Border.all(color: Colors.blue),
                                        // color: Colors.blue[200]
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500),
                                          //  iconSize: 0,
                                          icon: Visibility(
                                            visible: false,
                                            child: Icon(Icons.h_mobiledata),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),

                                          hint: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1.0),
                                            child: Text('jam',
                                                style: TextStyle(
                                                    color: Colors.blue)),
                                          ), // Not necessary for Option 1
                                          value: _selectedLocation3,
                                          onChanged: (String? newValue3) {
                                            setState(() {
                                              _selectedLocation3 = newValue3!;
                                            });
                                          },
                                          items: _jam.map((jam) {
                                            return DropdownMenuItem(
                                              child: new Text(jam),
                                              value: jam,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    Text(
                                      ':',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    //
                                    Container(
                                      width: 80,
                                      padding: EdgeInsets.only(
                                          left: _selectedLocation4 == null
                                              ? 20
                                              : 30),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.blue),
                                        color: Colors.blue[50],
                                        // color: Colors.blue[200]
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500),
                                          //  iconSize: 0,
                                          icon: Visibility(
                                            visible: false,
                                            child: Icon(Icons.h_mobiledata),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),

                                          hint: Text(
                                            'menit',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ), // Not necessary for Option 1
                                          value: _selectedLocation4,
                                          onChanged: (String? newValue4) {
                                            setState(() {
                                              _selectedLocation4 = newValue4!;
                                            });
                                          },
                                          items: _menit.map((menit) {
                                            return DropdownMenuItem(
                                              child: new Text(menit),
                                              value: menit,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    //
                                    SizedBox(width: 15),
                                    Container(
                                      width: 80,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      // padding: EdgeInsets.only(left:30),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.blue),
                                        color: Colors.blue[50],
                                        // color: Colors.blue[200]
                                      ),
                                      child: Center(
                                          child: Text(
                                        waktu,
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //
                        //
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Layanan yang dipilih',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            kaki == null
                                ? Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp',
                                            decimalDigits: 0)
                                        .format(int.parse(widget.iddharga!
                                            .reduce((a, b) => a + b)
                                            .toString())),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green))
                                : Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp',
                                            decimalDigits: 0)
                                        .format(int.parse(kaki)),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green)),
                          ],
                        ),
                        //
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedList(
                            key: _key,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            initialItemCount: widget.datahalaman!.length,
                            itemBuilder: (context, index, animation) {
                              return _buildItem('${widget.iddharga![index]}',
                                  animation, index);
                            },
                          ),
                          //
                          //

                          //                 child:  ListView.builder(
                          //                                     shrinkWrap: true,
                          //                                           itemCount: widget.iddharga == null ? 0 : widget.iddharga.length,
                          //                                     itemBuilder: (BuildContext context, index) {
                          //                                        final item = widget.iddharga[index];
                          //                                       return GestureDetector(
                          //                                         onTap:(){
                          //                                           setState(() {
                          //                                    item.removeAt(index);

                          //                                           });

                          //                                         },
                          //                                         child: Text(NumberFormat.currency(locale:'id',symbol:'Rp' ,decimalDigits:0).format(int.parse('${widget.iddharga[index]}'))));
                          //                                     }
                          // )
                        ),
                        //
                        //
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                // list: '${datalist[i]['name']}',
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: Text('Masukkan Ke Keranjang',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                          ))),
                                ),
                              ),
                            )),
                        //
                        //
                        SizedBox(
                          height: 3,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                semuajadwal();

                                Future.delayed(Duration(seconds: 3), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LanjutPembayaran(
                                                  longitude: widget.longitude!,
                                                  latitude: widget.latitude!,
                                                  harga: widget.iddharga!,
                                                  nama: widget.datahalaman!,
                                                  alamat: widget.alamat!,
                                                  jadwal: jadwal,
                                                  jam: jam,
                                                  menit: menit,
                                                  domisiliproblem:
                                                      domisiliproblem.text,
                                                  apartement: idapartement,
                                                  rumah: idrumah!,
                                                  iddata: widget.iddata!,
                                                  id: widget.id!)));
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: Text('Lanjut Pembayaran',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ))),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

//

}
