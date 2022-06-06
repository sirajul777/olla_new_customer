import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/Count/count.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Home/OrderDetail.dart';
import 'package:customer/View/Pages/AturJadwal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
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
  List<bool>? isChecked;
  Future<bool> showButtonLanjut() async {
    if (idharga.length != 0 || idharga.isNotEmpty || selectData.length != 0) {
      selectData.forEach((data) {
        print(data);
      });
      idharga.forEach((id) {
        print(id);
      });
      setState(() {
        _showLanjutButton = true;
      });
    } else {
      setState(() {
        _showLanjutButton = false;
      });
    }
    return true;
  }

  // mengaktifkan cehcklist
  bool ceklist = false;
  void checked({int? index}) async {
    setState(() {
      isChecked![index!] = !isChecked![index];
      isChecked!.length == 1 ? ceklist = !ceklist : null;
      var valuetru = isChecked!.every((element) => element == true);
      if (valuetru) {
        setState(() {
          ceklist = !ceklist;
        });
      } else {
        setState(() {
          ceklist = false;
        });
      }
    });
  }

  // untuk menghitung total harga
  List<int> harga = [];
  late String? totalharga = '0';
  late List<int> qty = [];
  Future<void> finalharga({int? indexs, bool? all}) async {
    var cektrue = isChecked!.every((el) => el == true);
    var cekfalse = isChecked!.every((el) => el == false);

    if (cektrue) {
      for (var i = 0; i < selectData.length; i++) {
        if (isChecked![i] == true) {
          var string = idharga[i]['price'];
          String variabel = string.replaceAll('.', '');
          int dataharga = int.parse(variabel);

          setState(() {
            harga[i] = 0;
            harga[i] = dataharga * qty[i];
          });
        }
      }
    } else if (cekfalse) {
      for (var i = 0; i < iddatta.length; i++) {
        setState(() {
          harga[i] = 0;
        });
      }
    } else {
      if (isChecked![indexs!] == true) {
        var string = iddatta[indexs]['price'];
        String variabel = string.replaceAll('.', '');
        int dataharga = int.parse(variabel);
        for (var i = 0; i < iddatta.length; i++) {
          if (isChecked![i] == false) {
            setState(() {
              harga[i] = 0;
            });
          }
        }
        setState(() {
          harga[indexs] = dataharga * qty[indexs];
        });
        print('this');
      } else {
        // var string = datacartproduct![indexs]['price'];
        // String variabel = string.replaceAll('.', '');
        // int dataharga = int.parse(variabel);
        setState(() {
          harga[indexs] = 0;
        });
      }
    }

    // toto menambah jumlah
    void addQty(int index) async {
      setState(() {
        qty[index] += 1;
      });
      finalharga(indexs: index);
    }

    // counter mengurangi jumlah
    void minQty(int index) async {
      if (qty[index] != 0) {
        if (qty[index] == 1) {
          setState(() {
            qty[index] = 1;
          });
        } else {
          setState(() {
            qty[index] -= 1;
          });
        }
      }
      finalharga(indexs: index);
    }

    Future<String> setQty() async {
      for (var i = 0; i < selectData.length; i++) {
        setState(() {
          qty[i] = int.parse(selectData[i]['quantity']);
        });
      }
      print(qty);
      return 'sukses';
    }

    var jumlah = harga.reduce((value, element) => value + element);
    print(jumlah);
    final Currency rp = Currency.create('IDR', 2, symbol: 'Rp ', pattern: '0.000', invertSeparators: true);
    var money = Money.parseWithCurrency('$jumlah', rp).toString();
    if (jumlah != 0) {
      setState(() {
        totalharga = '$money';
      });
    } else {
      setState(() {
        totalharga = '$jumlah';
      });
    }
  }

  List selectData = [];
  List iddatta = [];
  List idcomment = [];
  List idharga = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
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
                                color: Colors.black,
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
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'comfortaa',
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
                  floatingActionButton: _showLanjutButton
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              //        String text = _controllerMap.values
                              //     .where((element) => element.text != "")
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
                              iddatta.isNotEmpty
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => Aturjadwal(
                                                alamat: '$Address',
                                                longitude: '${position.longitude}',
                                                latitude: '${position.latitude}',
                                                id: '${widget.id}',
                                                datahalaman: selectData,
                                                iddata: iddatta,
                                                iddharga: idharga,
                                                iddnama: idcomment,
                                                // koment: text.trim(),
                                                // angka:1,

                                                // list: '${datalist![i]['name']}',
                                              )
                                          // OrderDetail(
                                          //   alamat: '$Address',
                                          //   longitude:
                                          //       '${position.longitude}',
                                          //   latitude:
                                          //       '${position.latitude}',
                                          //   id: '${widget.id}',
                                          //   datahalaman:
                                          //       selectData,
                                          //   iddata: iddatta,
                                          //   iddharga: idharga,
                                          //   iddnama: idcomment,
                                          //   // koment: text.trim(),
                                          //   // angka:1,

                                          //   // list: '${datalist![i]['name']}',
                                          // )
                                          ))
                                  : showDialog(
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
                                                child: Center(child: Text('Data tidak bole kosong!!!'))),
                                          ],
                                        );
                                      });
                              //  Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (BuildContext context) => Second(
                              //                         tanggal: selectData

                              //                         // list: '${datalist![i]['name']}',
                              //                       )));
                              // print(krisdianto);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.08,
                                decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                    child: Text('Selanjutnya',
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500))),
                              ),
                            ),
                          ),
                        )
                      : null,
                  body: SingleChildScrollView(
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
                                    decoration:
                                        BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
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
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pilih Tindakan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            //    const SizedBox(height: 10),
                            // const Divider(),
                            // const SizedBox(height: 10),
                            Column(
                              children: datalist!.map<Widget>((e) {
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
                                                child: CheckboxListTile(
                                                    title: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(e['name']),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                                                                  textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      height: 1.5, color: Colors.grey, fontSize: 12),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Center(
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        // margin: EdgeInsets.only(
                                                                        //     top: MediaQuery.of(context).size.height / 20),
                                                                        width: 30,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(
                                                                          image: DecorationImage(
                                                                            image: AssetImage('gambar/rupiah.png'),
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
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),

                                                                      Text(
                                                                        NumberFormat.currency(
                                                                                locale: 'id',
                                                                                symbol: 'Rp ',
                                                                                decimalDigits: 0)
                                                                            .format(int.parse(e['price_min'])),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w700,
                                                                            color: Colors.yellow[600]),
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
                                                    value: selectData.indexOf(e) < 0 ? false : true,
                                                    onChanged: (bool? newValue) {
                                                      if (selectData.indexOf(e) < 0) {
                                                        setState(() {
                                                          selectData.add(e);
                                                          iddatta.add(e['id']);
                                                          idcomment.add(e['name']);
                                                          idharga.add(int.parse(e['price_min']));
                                                        });
                                                      } else {
                                                        setState(() {
                                                          selectData.removeWhere((element) => element == e);
                                                          iddatta.removeWhere((element) => element == e['id']);
                                                          idcomment.removeWhere((element) => element == e['name']);
                                                          idharga.removeWhere(
                                                              (element) => element == int.parse(e['price_min']));
                                                        });
                                                      }
                                                      //  print(idcomment);
                                                      //  print(selectData);

                                                      // iddatta = e['id'.toString()];
                                                      showButtonLanjut();

                                                      print(idharga);
                                                    }),
                                              ),
                                              Positioned(
                                                bottom: 16,
                                                //  left: 0,
                                                right: 30,
                                                //  top:10,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // setState(
                                                    //     () {
                                                    //   isChecked![index] =
                                                    //       !isChecked![index];
                                                    //   isChecked!.length ==
                                                    //           1
                                                    //       ? ceklist =
                                                    //           !ceklist
                                                    //       : null;
                                                    //   var valuetru = isChecked!.every((element) =>
                                                    //       element ==
                                                    //       true);
                                                    //   if (valuetru) {
                                                    //     setState(
                                                    //         () {
                                                    //       ceklist =
                                                    //           !ceklist;
                                                    //     });
                                                    //   } else {
                                                    //     setState(
                                                    //         () {
                                                    //       ceklist =
                                                    //           false;
                                                    //     });
                                                    //   }
                                                    // });
                                                    checked(index: 1);
                                                    finalharga(indexs: 1);
                                                  },
                                                  child: Container(
                                                    height: 22.h,
                                                    width: 22.w,
                                                    decoration: BoxDecoration(
                                                        color: isChecked![1] ? primary : transparent,
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(color: primary, width: 2.w)),
                                                    child: Center(
                                                        child: isChecked![1]
                                                            ? Icon(
                                                                Icons.done,
                                                                size: 20,
                                                                color: isChecked![1] ? white : primary,
                                                              )
                                                            : const SizedBox()),
                                                  ),
                                                ),
                                              ),
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
                              }).toList(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 45.h),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
            ],
          ),
        ));
  }

//
  int _itemCount = 0;
  //
  @override
  void initState() {
    getDataListHome();
    super.initState();
    setQty();
    // iddatta;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = true;
      });
    });
  }

  Future<String> setQty() async {
    for (var i = 0; i < datalist!.length; i++) {
      setState(() {
        qty[i] = int.parse(datalist![i]['quantity']);
      });
    }
    print(qty);
    return 'sukses';
  }

  //
  late List? datalist = [];

  getDataListHome() async {
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

  Widget _futureBuilder() {
    return FutureBuilder(
      future: _retrieveData(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) {
          return Align(
            alignment: Alignment.topCenter,
            child: Text('No item'),
          );
        }
        final data = snapshot.data;
        return ListView.builder(
          itemCount: datalist! == null ? 0 : datalist!.length,
          padding: const EdgeInsets.only(top: 20.0, left: 8, right: 8),
          itemBuilder: (BuildContext context, int index) {
            final controller = _getControllerOf(data![index]);
            final textField = TextField(
              maxLines: 2,
              controller: controller,
              style: TextStyle(fontSize: 17),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  contentPadding: EdgeInsets.all(8),
                  hintText: datalist![index]['name'],
                  hintStyle: TextStyle(fontSize: 12)),
            );
            return Container(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 40,
                          // child: Icon(Icons.toll_outlined),
                          child: GestureDetector(
                            onTap: () {
                              showimage(context, 'https://olla.ws/images/package/${datalist![index]['images']}');
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                image: DecorationImage(
                                    image: NetworkImage('https://olla.ws/images/package/${datalist![index]['images']}'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              datalist![index]['name'],
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              children: [
                                Count(),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rp.',
                                      style: TextStyle(fontSize: 18, color: Colors.red),
                                    ),
                                    Text(
                                      datalist![index]['price_max'],
                                      style: TextStyle(fontSize: 18, color: Colors.red),
                                    ),
                                    //  Text(NumberFormat.currency(locale:'id',symbol:'Rp.',decimalDigits: 0 ).format(200000)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //TextField
                  Container(margin: EdgeInsets.only(right: 8), height: 50, child: textField),
                  SizedBox(
                    height: 10,
                  ),
                  //
                  Divider(
                    thickness: 1,
                    color: Colors.blue[100],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
  Widget _okButton() {
    //
    return GestureDetector(
      onTap: () async {
        String text = _controllerMap.values
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        await _showUpdateDialog(text);
        setState(() {
          _controllerMap.forEach((key, controller) {
            int index = _controllerMap.keys.toList().indexOf(key);
            key = controller.text;
            _data[index] = controller.text;
          });
        });
        Position position = await _getGeoLocationPosition();
        GetAddressFromLatLong(position);
        print('$Address');
        print('${position.latitude}');
        print('${position.longitude}');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => OrderDetail(
                      alamat: '$Address',
                      longitude: '${position.longitude}',
                      latitude: '${position.latitude}',
                      id: '${widget.id}',
                      koment: text.trim(),
                      angka: 1,

                      // list: '${datalist![i]['name']}',
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(color: Colors.yellow[800], borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text('Selanjutnya',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500))),
        ),
      ),
    );
    // return ElevatedButton(
    //   onPressed: () async {
    //     String text = _controllerMap.values
    //         .where((element) => element.text != "")
    //         .fold("", (acc, element) => acc += "${element.text}\n");
    //     await _showUpdateDialog(text);
    //     setState(() {
    //       _controllerMap.forEach((key, controller) {
    //         int index = _controllerMap.keys.toList().indexOf(key);
    //         key = controller.text;
    //         _data[index] = controller.text;
    //       });
    //     });
    //   },
    //   child: Text('yes'),
    // );
  }
}

// class Second extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return datalist!==null?0: datalist!.map<Widget>((hobby) {
//                       if (hobby['description'] == true) {
//                         return Card(
//                           elevation: 3,
//                           color: Colors.amber,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(hobby['name']),
//                           ),
//                         );
//                       }

//                       return Container();
//                     }).toList();
//   }
// }
