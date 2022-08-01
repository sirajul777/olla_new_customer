// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepOrder extends StatefulWidget {
  String? invoice;
  int? orderid;
  List? seluruhdata;
  // String koment;
// Get Key Data
  StepOrder({Key? key, this.invoice, this.orderid, this.seluruhdata}) : super(key: key);
  @override
  State<StepOrder> createState() => _StepOrderState();
}

class _StepOrderState extends State<StepOrder> {
  bool tampil = false;
  late List<bool> _selectedIndex;
  late Timer timer;
  late DateTime? dateTime = DateTime.parse(workingdate!);
  // DateTime getDateTime() {
  //   var now = DateTime.parse(workingdate!);
  //   return DateTime(now.year, now.month, now.day, now.hour, now.second);
  // }

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
          body: SafeArea(
            top: false,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarColor: white,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.dark),
                child: Stack(children: [
                  SingleChildScrollView(
                      child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                getDataListHome();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                                padding: EdgeInsets.all(20),
                                child: Text(widget.invoice!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green.withOpacity(0.7),
                                    )),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(right: 10.w),
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              // color: blackBlue,
                              image: DecorationImage(image: AssetImage('gambar/image3.png'), fit: BoxFit.fitHeight),
                            ),
                          ),
                        ),
                        partner == null
                            ? Container(
                                child: Column(
                                  children: [
                                    Center(
                                        child: Container(
                                      padding: EdgeInsets.only(left: 40, right: 40),
                                      margin: EdgeInsets.only(top: 20.w),
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(10),
                                      //     color: blackBlue),

                                      child: Text('Sedang mencari Mitra terdekat,',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: primary,
                                            overflow: TextOverflow.fade,
                                          )),
                                    )),
                                    Center(
                                        child: Container(
                                      padding: EdgeInsets.only(left: 40, right: 40),
                                      margin: EdgeInsets.only(top: 5.w),
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(10),
                                      //     color: blackBlue),

                                      child: Text('harap tunggu sejenak.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: primary,
                                            overflow: TextOverflow.fade,
                                          )),
                                    )),
                                    Center(
                                      child: Container(
                                        // height: MediaQuery.of(context).size.height,
                                        padding: EdgeInsets.only(top: 20.w),
                                        width: MediaQuery.of(context).size.width,
                                        // color: Colors.red,
                                        child: const Center(
                                          child: SpinKitFadingCircle(
                                            color: Colors.blue,
                                            size: 40.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                                    child: Container(
                                        margin: EdgeInsets.only(top: 10.w),
                                        padding: EdgeInsets.all(15.w),
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: softGrey,
                                              blurRadius: 15.0,
                                              // has the effect of softening the shadow
//                    spreadRadius: 2.0,
                                              // has the effect of extending the shadow
                                              offset: Offset(
                                                1.0, // horizontal, move right 10
                                                5.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 10),
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('gambar/gambarprofile.png'),
                                                    fit: BoxFit.fitHeight),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      partner != null ? partner!['name'] : '',
                                                      style: TextStyle(
                                                          overflow: TextOverflow.clip,
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: darkGrey),
                                                    ),
                                                  ),
                                                  Container(
                                                      child: Row(children: [
                                                    Text(
                                                      '${dateTime!.day} '
                                                      '${_month[dateTime!.month - 1]} '
                                                      '${dateTime!.year}',
                                                      style: TextStyle(color: softGrey, fontSize: 11.sp),
                                                    ),
                                                    Text(
                                                      '- ${workingtime!}',
                                                      style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                                                    ),
                                                  ]))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: lightBlue, borderRadius: BorderRadius.circular(25)),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.forum_outlined,
                                                      color: Color.fromARGB(255, 59, 167, 255),
                                                      size: 20,
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: lightBlue, borderRadius: BorderRadius.circular(25)),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.phone_callback_outlined,
                                                      color: Color.fromARGB(255, 59, 167, 255),
                                                      size: 20,
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20.w,
                                  ),
                                  Container(
                                      child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w, bottom: 10.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                child: Text(
                                              'Bagikan status Pekerjaan',
                                              style: TextStyle(
                                                  fontSize: 12.sp, color: darkGrey, fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                        ),
                                      ),
                                      // Divider(
                                      //   thickness: 1,
                                      // ),
                                    ],
                                  )),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
                                      child: Container(
                                          padding: EdgeInsets.all(10.w),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: lightBlue, width: 1),
                                              borderRadius: BorderRadius.circular(20.w)),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      'Bagikan status pekerjaan yang sedang berlangsung.',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          overflow: TextOverflow.fade,
                                                          color: softGrey,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10.sp),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'Disini dapat melihat status pekerjaan.',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          overflow: TextOverflow.fade,
                                                          color: softGrey,
                                                          fontSize: 10.sp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: 16,
                                                height: 16,
                                                // padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20.w),
                                                    border: Border.all(color: softGrey, width: 1)),
                                                // padding: EdgeInsets.only(left: 5.w),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.share,
                                                  color: softGrey,
                                                  size: 9,
                                                )))
                                          ])),
                                    ),
                                  ),
                                  Container(
                                      child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 20.w,
                                          right: 20.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                child: Text(
                                              'Rincian status pekerjaan',
                                              style: TextStyle(
                                                  fontSize: 12.sp, color: darkGrey, fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                        ),
                                      ),
                                      // Divider(
                                      //   thickness: 1,
                                      // ),
                                    ],
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          //  width: 100,
                                          //  height: 100,
                                          child: TimelineTile(
                                            afterLineStyle:
                                                LineStyle(color: isdone == 1 ? Colors.green : softGrey, thickness: 3),
                                            indicatorStyle:
                                                IndicatorStyle(color: isdone == 1 ? Colors.green : softGrey, width: 15),
                                            isFirst: true,
                                            endChild: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${awal[0]['step_name']}",
                                                        style: TextStyle(
                                                            fontSize: 12, color: darkGrey, fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        "${awal[0]['time'] ?? ''}",
                                                        style: TextStyle(fontSize: 12, color: primary),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    'Mitra telah mengambil order',
                                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //
                                        SizedBox(
                                          child: TimelineTile(
                                            isLast: true,
                                            beforeLineStyle:
                                                LineStyle(color: isdone == 1 ? Colors.green : softGrey, thickness: 3),
                                            afterLineStyle: LineStyle(
                                                color: isdonekedua == 1 ? Colors.green : softGrey, thickness: 3),
                                            indicatorStyle: IndicatorStyle(
                                                color: isdonekedua == 1 ? Colors.green : softGrey, width: 15),
                                            endChild: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 0, top: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${awal[1]['step_name'] ?? ''}",
                                                        style: TextStyle(
                                                            fontSize: 12, color: darkGrey, fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        "${awal[1]['time'] ?? ''}",
                                                        style: TextStyle(fontSize: 12.sp, color: primary),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  isdonekedua == 1
                                                      ? Text(
                                                          Address,
                                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                                        )
                                                      : Text(
                                                          'menunggu tukang sampai lokasi anda',
                                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isdonekedua == 1
                                      ? Container(
                                          child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showWork = !showWork;
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 20.w, right: 20.w, top: 20.w, bottom: 10.w),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                              child: Text(
                                                            'Pekerjaan yang akan di lakukan',
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: darkGrey,
                                                                fontWeight: FontWeight.bold),
                                                          )),
                                                          SizedBox(),
                                                          SizedBox(),
                                                          SizedBox(),
                                                          SizedBox(),
                                                          SizedBox(),
                                                          Container(
                                                              padding: EdgeInsets.all(1),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20.w),
                                                                  border: Border.all(color: softGrey, width: 1)),
                                                              child: Icon(
                                                                Icons.expand_more,
                                                                color: softGrey,
                                                                size: 12,
                                                              )),
                                                          SizedBox()
                                                        ],
                                                      ),
                                                    ),
                                                    // Divider(
                                                    //   thickness: 1,
                                                    // ),
                                                  ],
                                                )),
                                            showWork
                                                ? Column(children: [
                                                    // step middle
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 30.w),
                                                      child: Container(
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: orderansemua == null ? 0 : orderansemua.length,
                                                            itemBuilder: (BuildContext context, i) {
                                                              return Column(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        _selectedIndex[i] = !_selectedIndex[i];
                                                                      });
                                                                      print(i);
                                                                      print(_selectedIndex);
                                                                    },
                                                                    child: Row(
                                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Container(
                                                                            width: 20.w,
                                                                            height: 20.w,
                                                                            decoration: BoxDecoration(
                                                                                color: darkYellow,
                                                                                borderRadius:
                                                                                    BorderRadius.circular(20)),
                                                                            child: Icon(
                                                                              Icons.task_alt,
                                                                              size: 14,
                                                                              color: white,
                                                                            )),
                                                                        SizedBox(
                                                                          width: 2,
                                                                        ),
                                                                        SizedBox(
                                                                          width: 2,
                                                                        ),
                                                                        Flexible(
                                                                            child: Text(
                                                                          orderansemua[i]['service_name'],
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp, color: darkGrey),
                                                                        )),
                                                                        SizedBox(
                                                                          width: 3,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.only(left: 20.0, bottom: 10),
                                                                    child: Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          child: TimelineTile(
                                                                            isFirst: true,
                                                                            beforeLineStyle: LineStyle(
                                                                                color: isdonekedua == 1
                                                                                    ? Colors.green
                                                                                    : softGrey,
                                                                                thickness: 4),
                                                                            afterLineStyle: LineStyle(
                                                                                color: orderansemua[i]['steps'][0]
                                                                                            ['is_done'] ==
                                                                                        1
                                                                                    ? Colors.green
                                                                                    : softGrey,
                                                                                thickness: 3),
                                                                            indicatorStyle: IndicatorStyle(
                                                                                indicatorXY: 0.3,
                                                                                color: orderansemua[i]['steps'][0]
                                                                                            ['is_done'] ==
                                                                                        1
                                                                                    ? Colors.green
                                                                                    : softGrey,
                                                                                width: 15),
                                                                            endChild: Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  left: 10.0,
                                                                                  right: 10,
                                                                                  bottom: 1,
                                                                                  top: 10),
                                                                              child: Column(
                                                                                crossAxisAlignment:
                                                                                    CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment:
                                                                                        MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                          width: MediaQuery.of(context)
                                                                                                  .size
                                                                                                  .width /
                                                                                              1.9,
                                                                                          child: Text(
                                                                                            orderansemua[i]['steps'][0]
                                                                                                ['step_name'],
                                                                                            style: TextStyle(
                                                                                                fontSize: 12,
                                                                                                color: softGrey),
                                                                                          )),
                                                                                      Text(
                                                                                        orderansemua[i]['steps'][0]
                                                                                            ['time'],
                                                                                        style: TextStyle(
                                                                                            fontSize: 12,
                                                                                            color: primary),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  orderansemua[i]['steps'][0]
                                                                                              ['is_done'] ==
                                                                                          1
                                                                                      ? Container(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius:
                                                                                                BorderRadius.circular(
                                                                                                    5),
                                                                                            image: DecorationImage(
                                                                                                image: NetworkImage(
                                                                                                    orderansemua[i]
                                                                                                            ['steps'][0]
                                                                                                        ['images']),
                                                                                                fit: BoxFit.cover),
                                                                                          ),
                                                                                        )
                                                                                      : Container(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: Icon(
                                                                                            Icons.image_outlined,
                                                                                            color: darkGrey,
                                                                                            size: 22,
                                                                                          )),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          //  width: 100,
                                                                          //  height: 50,
                                                                          child: TimelineTile(
                                                                            isLast: true,
                                                                            beforeLineStyle: LineStyle(
                                                                                color: isdonekedua == 1
                                                                                    ? Colors.green
                                                                                    : softGrey,
                                                                                thickness: 3),
                                                                            afterLineStyle: LineStyle(
                                                                                color: orderansemua[i]['steps'][1]
                                                                                            ['is_done'] ==
                                                                                        1
                                                                                    ? Colors.green
                                                                                    : softGrey,
                                                                                thickness: 2),
                                                                            indicatorStyle: IndicatorStyle(
                                                                                indicatorXY: 0.3,
                                                                                color: orderansemua[i]['steps'][1]
                                                                                            ['is_done'] ==
                                                                                        1
                                                                                    ? Colors.green
                                                                                    : softGrey,
                                                                                width: 15),
                                                                            endChild: Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  left: 10.0,
                                                                                  right: 10,
                                                                                  bottom: 1,
                                                                                  top: 10),
                                                                              child: Column(
                                                                                crossAxisAlignment:
                                                                                    CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment:
                                                                                        MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                          width: MediaQuery.of(context)
                                                                                                  .size
                                                                                                  .width /
                                                                                              1.9,
                                                                                          child: Text(
                                                                                            orderansemua[i]['steps'][1]
                                                                                                ['step_name'],
                                                                                            style: TextStyle(
                                                                                                fontSize: 12,
                                                                                                color: softGrey),
                                                                                          )),
                                                                                      Text(
                                                                                        orderansemua[i]['steps'][1]
                                                                                            ['time'],
                                                                                        style: TextStyle(
                                                                                            fontSize: 12,
                                                                                            color: primary),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  orderansemua[i]['steps'][1]
                                                                                              ['is_done'] ==
                                                                                          1
                                                                                      ? Container(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius:
                                                                                                BorderRadius.circular(
                                                                                                    5),
                                                                                            image: DecorationImage(
                                                                                                image: NetworkImage(
                                                                                                    orderansemua[i]
                                                                                                            ['steps'][1]
                                                                                                        ['images']),
                                                                                                fit: BoxFit.cover),
                                                                                          ),
                                                                                        )
                                                                                      : Container(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: Icon(
                                                                                            Icons.image_outlined,
                                                                                            color: darkGrey,
                                                                                            size: 22,
                                                                                          )),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        //

                                                                        //
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  //
                                                                ],
                                                              );
                                                            }),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 30.w, right: 40.w, bottom: 30.w, top: 5),
                                                      child: Container(
                                                          width: MediaQuery.of(context).size.width - 30,
                                                          child: Column(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _selectedIndex[0] = !_selectedIndex[0];
                                                                  });

                                                                  print(_selectedIndex);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                        width: MediaQuery.of(context).size.width / 2,
                                                                        child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                  margin: EdgeInsets.only(right: 5.w),
                                                                                  width: 20.w,
                                                                                  height: 20.w,
                                                                                  decoration: BoxDecoration(
                                                                                      color: darkYellow,
                                                                                      borderRadius:
                                                                                          BorderRadius.circular(20)),
                                                                                  child: Icon(
                                                                                    Icons.task_alt,
                                                                                    size: 14,
                                                                                    color: white,
                                                                                  )),
                                                                              Flexible(
                                                                                  child: Text(
                                                                                terakhir[0]['step_name'],
                                                                                style: TextStyle(
                                                                                    fontSize: 13, color: darkGrey),
                                                                              )),
                                                                            ])),
                                                                    Container(
                                                                        child: Text(
                                                                      terakhir[0]['time'],
                                                                      style: TextStyle(fontSize: 13, color: primary),
                                                                    )),
                                                                  ],
                                                                ),
                                                              ),

                                                              //

                                                              //
                                                            ],
                                                          )),
                                                    )
                                                  ])
                                                : SizedBox(),
                                            Padding(
                                              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w),
                                              child: Container(
                                                  child: Text(
                                                'Pemberitahuan',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: darkGrey, fontWeight: FontWeight.bold, fontSize: 12.sp),
                                              )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
                                              child: Container(
                                                  padding: EdgeInsets.all(10.w),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: lightBlue, width: 1),
                                                      borderRadius: BorderRadius.circular(20.w)),
                                                  child:
                                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                    Flexible(
                                                      child: Text(
                                                        'Tidak dapat membatalkan pesanan yang sedang berlangsung.',
                                                        textAlign: TextAlign.justify,
                                                        style: TextStyle(color: softGrey, fontSize: 11.sp),
                                                      ),
                                                    ),
                                                    Container(
                                                        width: 16,
                                                        height: 16,
                                                        // padding: EdgeInsets.all(2),
                                                        margin: EdgeInsets.only(left: 15.w, right: 7.w),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20.w),
                                                            border: Border.all(color: softGrey, width: 1)),
                                                        child: Center(
                                                            child: Text(
                                                          'i',
                                                          style: TextStyle(
                                                              color: softGrey,
                                                              // fontWeight: FontWeight.bold,
                                                              fontSize: 12.sp),
                                                        )))
                                                  ])),
                                            ),
                                            statusorder == 3
                                                ? GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(15.0)), //this right here

                                                              child: Container(
                                                                height: 230,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(10.0),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Center(
                                                                        child: Text(
                                                                          'Berikan ulasan',
                                                                          style: TextStyle(
                                                                              color: darkGrey,
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 8,
                                                                      ),

                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          RatingBar.builder(
                                                                            initialRating: 0,
                                                                            minRating: 0,
                                                                            direction: Axis.horizontal,
                                                                            itemCount: 5,
                                                                            itemPadding:
                                                                                EdgeInsets.symmetric(horizontal: 4.0),
                                                                            itemBuilder: (context, _) => Icon(
                                                                              Icons.star,
                                                                              color: Colors.amber,
                                                                            ),
                                                                            onRatingUpdate: (rating) {
                                                                              setState(() {
                                                                                bintang = rating;
                                                                              });

                                                                              //  print(bintang);
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),

//

                                                                      Container(
                                                                        decoration: BoxDecoration(

                                                                            // color: Colors.blue[50],

                                                                            borderRadius: BorderRadius.circular(25)),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 10.0, right: 10, top: 15),
                                                                          child: TextField(
                                                                            // controller: email,

                                                                            // textAlign: TextAlign.left,

                                                                            // ignore: unnecessary_new

                                                                            decoration: new InputDecoration(
                                                                              fillColor: Colors.blue[50],
                                                                              filled: true,
                                                                              contentPadding: EdgeInsets.only(
                                                                                  left: 10, right: 0, top: 20),
                                                                              hintText: 'Tulis ulasan kamu disini',
                                                                              hintStyle: TextStyle(
                                                                                  color: Colors.grey, fontSize: 12),
                                                                              border: OutlineInputBorder(
                                                                                  borderRadius: const BorderRadius.all(
                                                                                    Radius.circular(10.0),
                                                                                  ),
                                                                                  borderSide: BorderSide.none),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          addData();
                                                                        },
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 150.0, right: 10, top: 10),
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(15),
                                                                                color: Colors.blue[300]),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  left: 15,
                                                                                  right: 12,
                                                                                  top: 12,
                                                                                  bottom: 12),
                                                                              child: Row(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Container(
                                                                                    child: Icon(
                                                                                      Icons.note_add_outlined,
                                                                                      color: white,
                                                                                      size: 20,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'simpan',
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.white,
                                                                                        fontSize: 14),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                            color: Colors.blue,
                                                          ),
                                                          width: MediaQuery.of(context).size.width,
                                                          child: Center(
                                                              child: Padding(
                                                            padding: const EdgeInsets.all(15.0),
                                                            child: Text(
                                                              'Beri Ulasan',
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ))),
                                                    ),
                                                  )
                                                : SizedBox(),
                                            // SizedBox(
                                            //   height: 5,
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 8),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    color: redDanger,
                                                  ),
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Center(
                                                      child: Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Text(
                                                      'Kirim Laporan',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ))),
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),

                                            //

                                            //
                                          ],
                                        ))
                                      : SizedBox(),
                                ],
                              )
                      ],
                    ),
                  ))
                ])),
          ));
    }
  }

  var bintang;
  bool showWork = false;
  bool isloading = false;
  @override
  void initState() {
    getDataListHome();
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        isloading = !isloading;
      });
    });
    Timer.periodic(Duration(seconds: 30), (timer) {
      var data = getDataListHome();
      print(data);
      if (statusorder == 3) {
        timer.cancel();
      }
      getDataListHome();
    });
    //
    super.initState();

    // getDataListHome();
  }

//
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
  //
  var partner;
  late String customer;
  late int statusorder;
  late String? workingdate;
  late String? workingtime;
  getDataListHome() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http
        // .get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order-detail/${widget.orderid}')), headers: {
        .get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order-detail/${1066}')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer $customer",
    });
    //
    // if(converDataToJson=='null'){
    //   print('tidak ada');
    // }else{
    //   print('ada');
    // }

    var converDataToJson = json.decode(response.body);
    print(converDataToJson);
    var order_summary = converDataToJson['order_summary'];
    if (converDataToJson['partner'] != null) {
      setState(() {
        statusorder = converDataToJson['status_order'];
        // status = converDataToJson['payments']['status'];
        // gambar = converDataToJson['payments']['image'];
        // grandtotal = converDataToJson['grand_total'];
        workingdate = order_summary['schedule']['working_date'];
        workingtime = order_summary['schedule']['working_time'];
        partner = converDataToJson['partner'];
        // datalist = converDataToJson;
        // dateTime = order_summary['schedule']['working_date'];
        // ignore: avoid_print
        // print(converDataToJson['payments']['status']);
        print(partner);
        // print(converDataToJson);
        print(statusorder);
      });
      getDataListorderStep();
    }

    return converDataToJson;
  }

  //
  //ordr step
  // String partner;
  // String customer;
  late String latitude;
  late String longitude;
  late String orderan;
  late List awal;
  late List orderansemua;
  late int isdone;
  late int isdonekedua;

  late List terakhir;
  late int isdoneterakhir;
  late String latitudekedua;
  late String longitudekedua;
  getDataListorderStep() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http
        // .get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order-step/${widget.orderid}')), headers: {
        .get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order-step/${1066}')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer $customer",
    });
    //
    // if(converDataToJson=='null'){
    //   print('tidak ada');
    // }else{
    //   print('ada');
    // }
    var converDataToJsonsteporder = json.decode(response.body);
    print(converDataToJsonsteporder);
    orderansemua = converDataToJsonsteporder['stepMiddle'];
    _selectedIndex = List<bool>.filled(orderansemua.length, false, growable: true);
    print(orderansemua);
    setState(() {
      awal = converDataToJsonsteporder['stepStart']; //ambil order
      isdone = converDataToJsonsteporder['stepStart'][0]['is_done']; //isdone ambil order
      latitude = converDataToJsonsteporder['stepStart'][0]['latitude']; //latitude ambil order
      longitude = converDataToJsonsteporder['stepStart'][0]['longitude']; //longitude ambil order

      isdonekedua = converDataToJsonsteporder['stepStart'][1]['is_done']; //isdone sampai rumah pelanggan
      latitudekedua = converDataToJsonsteporder['stepStart'][1]['latitude']; //latitude sampai rumah
      longitudekedua = converDataToJsonsteporder['stepStart'][1]['longitude']; //longitude sampai rumah
      terakhir = converDataToJsonsteporder['stepEnd'];
      isdoneterakhir = converDataToJsonsteporder['stepEnd'][0]['is_done'];
      //  orderan=orderansemua['service_name'];

      // latitude = steporder[0]['time'];
      // invoice = converDataToJson['invoice'];
      // status = converDataToJson['payments']['status'];
      // gambar = converDataToJson['payments']['image'];
      // grandtotal = converDataToJson['grand_total'];
      // partner = converDataToJson['partner']['name'];
      // datalist = converDataToJson;

      // ignore: avoid_print
      // print(converDataToJson['payments']['status']);
      // print(orderansemua);
      // print(converDataToJsonsteporder);
      // print(awal);
    });
  }

  String location = 'Null, Press Button';
  String Address = 'Search';
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
    List<Placemark> placemarks =
        await placemarkFromCoordinates(double.parse(latitudekedua), double.parse(longitudekedua));
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street},';
    setState(() {});
  }

  //
  late int _selected;

  _onselected(int i) {
    setState(() => _selected = i);
  }

  //
  getDataListRate() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/rate/25')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer $customer",
    });
    //
    // if(converDataToJson=='null'){
    //   print('tidak ada');
    // }else{
    //   print('ada');
    // }
    setState(() {
      var converDataToJsonsteporder = json.decode(response.body);
      print(converDataToJsonsteporder);
    });
    return "Success";
  }

  //
  addData() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    // var random = randomAlphaNumeric(32).toLowerCase();
    // String myUrl = "http://45.13.132.61:3000/reseller/signup";
    String myUrl = "https://olla.ws/api/customer/v1/rate/${widget.orderid}";
    http.post(Uri.parse(Uri.encodeFull(myUrl)), headers: {
      'Accept': 'application/json',
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer $customer",
      // "imei": "123456"
    }, body: {
      // "order_id" : '${widget.orderid}',
      "partner_review_rate_id": '${bintang}'.replaceAll('.0', ''),
      "comment": "asdasd"
    }).then((response) async {
      var jsonObj = json.decode(response.body);
      print(jsonObj);
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (BuildContext context) => Dashboard()), (Route<dynamic> route) => false);
      //   if (response.statusCode == 200) {
      //     // print(jsonObj['customer_id']);
      //     setState(() {
      //       // pengenalid = jsonObj['customer_id'];
      //       // _incrementCounter();
      //     });
      //     print(jsonObj);

      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
      //         (Route<dynamic> route) => false);
      //     // setState(() {
      //     //   data = '${jsonObj['data']['verification_code']}';
      //     //   statusinactive = '${jsonObj['data']['status']}';
      //     //   namauser = '${jsonObj['data']['user_name']}';
      //     //   emailuser = '${jsonObj['data']['email']}';
      //     // });
      //   } else {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return Dialog(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           elevation: 0,
      //           backgroundColor: Colors.transparent,
      //           child: Stack(
      //             overflow: Overflow.visible,
      //             children: [
      //               Container(
      //                   height: 200,
      //                   width: double.infinity,
      //                   margin: EdgeInsets.only(top: 20),
      //                   decoration: BoxDecoration(
      //                       color: Colors.white,
      //                       shape: BoxShape.rectangle,
      //                       borderRadius: BorderRadius.circular(17),
      //                       boxShadow: [
      //                         BoxShadow(
      //                           color: Colors.black26,
      //                           blurRadius: 10.0,
      //                           offset: Offset(0.0, 10.0),
      //                         ),
      //                       ]),
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(top: 70.0),
      //                     child: Column(
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: [
      //                         SizedBox(
      //                           height: 10,
      //                         ),
      //                         Text('Maaf!!!',
      //                             style: TextStyle(
      //                                 fontFamily: 'Comfortaa',
      //                                 fontSize: 13,
      //                                 fontWeight: FontWeight.w900)),
      //                         SizedBox(
      //                           height: 10,
      //                         ),
      //                         Text('Masukkan Data Anda Dengan Benar',
      //                             style: TextStyle(
      //                                 fontFamily: 'Comfortaa',
      //                                 fontSize: 13,
      //                                 fontWeight: FontWeight.w900)),
      //                       ],
      //                     ),
      //                   )),
      //               Positioned(
      //                 // bottom: 10,
      //                 top: 0,
      //                 left: 16,
      //                 right: 16,
      //                 child: Container(
      //                     height: 80,
      //                     width: 80,
      //                     child: Image.asset('gambar/login.png')),
      //               )
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   }
      //   // print('$statusinactive');
      //   // return print('$data');
      //   //   return showDialog(
      //   //       context: context,
      //   //       barrierDismissible: false,
      //   //       builder: (BuildContext context) {
      //   //         return WillPopScope(
      //   //           onWillPop: () async => false,
      //   //           child: GestureDetector(onTap: () {
      //   //             Navigator.pop(context);
      //   //             // Navigator.pushAndRemoveUntil(
      //   //             //     context,
      //   //             //     MaterialPageRoute(
      //   //             //         builder: (BuildContext context) => HomeScreen()),
      //   //             //     (Route<dynamic> route) => false);
      //   //           }, child: StatefulBuilder(
      //   //             builder: (BuildContext context, StateSetter setState) {
      //   //               return SimpleDialog(
      //   //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //   //                 contentPadding: EdgeInsets.zero,
      //   //                 titlePadding: EdgeInsets.only(bottom: 0),
      //   //                 title: Column(
      //   //                   children: [
      //   //                     Container(
      //   //                       decoration: BoxDecoration(
      //   //                       color:Colors.deepPurple[400],
      //   //                         borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10))
      //   //                       ),
      //   //                       height:20,
      //   //                     ),
      //   //                     SizedBox(height:15),
      //   //                     Text('Akun Belum Aktiv'),
      //   //                     SizedBox(height:15),
      //   //                     RaisedButton(
      //   //                       child:Text('Verifikasi Akun'),
      //   //                       onPressed: (){
      //   //                         // _launchMap();
      //   //                       },
      //   //                     ),
      //   //                     SizedBox(height:15),
      //   //                   ],
      //   //                 )
      //   //               );
      //   //             },
      //   //           )),
      //   //         );
      //   //       });
      //   // } else {}
    });
//
//
  }
  //

}
