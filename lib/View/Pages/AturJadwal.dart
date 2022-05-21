import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Components/utils.dart';
import 'package:customer/View/Home/lanjutpembayaran.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Aturjadwal extends StatefulWidget {
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
  Aturjadwal(
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
  _AturjadwalState createState() => _AturjadwalState();
}

class _AturjadwalState extends State<Aturjadwal> {
  DateTime dateTime = DateTime.now();
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

  var kaki;
  final GlobalKey<AnimatedListState> _key = GlobalKey();

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

  @override
  void initState() {
    super.initState();
    getDataListHome();
    getDataDomisili();
    alamat();
    dateTime = getDateTime();
    kaki;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // isloading = true;
      });
    });

    // loadCounter1();
    // loadCounter2();
  }

  late String jadwal;
  late String jam;
  late String menit;

  semuajadwal() async {
// print(months[current_mon-1]);

    setState(() {
      jam = ("${dateTime.hour}");
      menit = ("${dateTime.minute}");
      // tanggalstack = ("$_selectedLocationstack");
      jadwal = ("${Address} ? ${dateTime.day} ? ${Address} : ${dateTime.year}");
      print(jadwal);
    });
  }

  int id = 1;
  var result;
  var result1;
  late int idapartement;
  late int? idrumah;
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

  late List datalist;
  late int service;
  late int method;
  late int dataid;
  late int dataid1;
  late int dataid2;
  late int dataid3;
  late int dataid4;
  late String home;

  List domisili = [];
  late String apartement = '';
  late String rumah = '';
  late int apartmentid;
  late int rumahid;
  int _groupValue = -1;

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

  String location = 'Null, Press Button';
  TextEditingController domisiliproblem = TextEditingController();

  String Address = 'search';
  void alamat() async {
    Position position = await _getGeoLocationPosition();
    GetAddressFromLatLong(position);
    print('$Address');
    print('${position.latitude}');
    print('${position.longitude}');
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: white,
      body: SafeArea(
          top: false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: white,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark),
              child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(top: 20.w, left: 20.w, right: 20.w),
                        height: ScreenUtil().setHeight(75.h),
                        color: white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                // ignore: avoid_unnecessary_containers
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    // color: Colors.blue[50],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios_outlined,
                                      // color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Atur Jadwal',
                                  style: TextStyle(
                                    color: blackBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.w,
                                  ),
                                ),
                              ),
                              SizedBox()
                            ]),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.w),
                        margin: EdgeInsets.only(bottom: 10.w, top: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(children: [
                                SizedBox(
                                    width: 35.w,
                                    height: 35.w,
                                    child: SvgPicture.asset(
                                        'image/navigation.svg')),
                                Text(
                                  ' Pengiriman',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: blackBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.w,
                                  ),
                                )
                              ]),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // tampil2 = !tampil2;
                                });
                              },
                              child: Text(
                                'Sesuaikan',
                                style: TextStyle(
                                    color: ligthgreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.w,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(15.0),
                          width: MediaQuery.of(context).size.width - 60,
                          // height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            Address,
                            style: TextStyle(fontSize: 12),
                          ))),
                      SizedBox(
                        height: 20.h,
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
                      Text(
                        'Tambahkan Catatan Alamat',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        width: MediaQuery.of(context).size.width - 30,
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
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            hintText: 'Tulis catatan disini',
                            // prefixIcon: Padding(
                            //   padding: const EdgeInsets.all(20.0),
                            //   child: Image.asset(
                            //     'gambar/email.png',
                            //     width: 25,
                            //     height: 25,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      //
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 300.w,
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                              border: Border.all(color: softGrey, width: 0.5),
                              borderRadius: BorderRadius.circular(20.w)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // buildDatePicker(),
                              // Text('Setup Date'),

                              GestureDetector(
                                  onTap: () {
                                    Utils.showSheet(
                                      context,
                                      child: buildDatePicker(),
                                      onClicked: () {
                                        // Utils.showSheet(context, 'Selected "$value"');

                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(20.w),
                                      decoration: BoxDecoration(
                                          color: lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(20.w)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '${dateTime.day}',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${_month[dateTime.month - 1]}',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${dateTime.year}',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ))),
                              const SizedBox(height: 24),

                              GestureDetector(
                                  onTap: () {
                                    Utils.showSheet(
                                      context,
                                      child: buildTimePicker(),
                                      onClicked: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(20.w),
                                      decoration: BoxDecoration(
                                          color: lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(20.w)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Pukul ',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          dateTime.minute != 0
                                              ? Text(
                                                  '${dateTime.hour}:${dateTime.minute}',
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              : Text(
                                                  '${dateTime.hour}:${dateTime.minute}0',
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          // Text(''),
                                        ],
                                      ))),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        padding: EdgeInsets.all(30.w),
                        child: Row(
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
                      ),

                      //
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 30,

                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: AnimatedList(
                          key: _key,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          initialItemCount: widget.datahalaman!.length,
                          itemBuilder: (context, index, animation) {
                            return _buildItem(
                                '${widget.iddharga![index]}', animation, index);
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
                            onTap: () {
                              semuajadwal();
                              print(jadwal);

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
                  )))),
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 240,
        width: ScreenUtil.defaultSize.width - 20,
        child: CupertinoDatePicker(
          minimumYear: 2022,
          maximumYear: DateTime.now().year + 3,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (timepick) => setState(() {
            this.dateTime = timepick;
            // jadwal = dateTime as String;
          }),
        ),
      );

  Widget buildTimePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.time,
          minuteInterval: 10,
          // use24hFormat: false,
          onDateTimeChanged: (timePick) => setState(() {
            this.dateTime = timePick;
          }),
        ),
      );

  DateTime getDateTime() {
    var now = DateTime.now();

    return DateTime(now.year, now.month, now.day, now.hour, 0);
  }
}
