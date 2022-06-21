// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  StepOrder({Key? key, this.invoice, this.orderid, this.seluruhdata})
      : super(key: key);
  @override
  State<StepOrder> createState() => _StepOrderState();
}

class _StepOrderState extends State<StepOrder> {
  bool tampil = false;
  late List<bool> _selectedIndex;
  late Timer timer;
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
      return SafeArea(
          top: false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark),
            child: Stack(
              children: [
                Scaffold(
                    backgroundColor: white,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     // Navigator.pop(context);
                          //     // getDataListorderStep();
                          //     // getDataListRate();
                          //   },
                          //   // ignore: avoid_unnecessary_containers
                          //   child: Container(
                          //     height: MediaQuery.of(context).size.height / 25,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(3),
                          //       color: Colors.blue[50],
                          //     ),
                          //     child: Center(
                          //       child: Icon(
                          //         Icons.arrow_back_ios_outlined,
                          //         color: Colors.black,
                          //         size: 20,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 80,
                          // ),
                          GestureDetector(
                            onTap: () async {
                              getDataListHome();
                            },
                            child: Text(widget.invoice!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.withOpacity(0.7),
                                )),
                          ),
                        ],
                      ),
                      automaticallyImplyLeading: false,
                      // backgroundColor: Colors.transparent,
                      // shape:
                      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    ),
                    body: SingleChildScrollView(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(right: 10.w),
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                // color: blackBlue,
                                image: DecorationImage(
                                    image: AssetImage('gambar/image3.png'),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                          ),
                          partner == null
                              ? Container(
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Container(
                                        margin: EdgeInsets.only(top: 20.w),
                                        // decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(10),
                                        //     color: blackBlue),

                                        child: Text('Sedang mencari Teknisi',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: primary,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      Center(
                                        child: Container(
                                          // height: MediaQuery.of(context).size.height,
                                          padding: EdgeInsets.only(top: 20.w),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // color: Colors.red,
                                          child: const Center(
                                            child: SpinKitFadingCircle(
                                              color: Colors.blue,
                                              size: 60.0,
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
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Container(
                                          margin: EdgeInsets.only(top: 10.w),
                                          padding: EdgeInsets.all(15.w),
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'gambar/partner.png'),
                                                      fit: BoxFit.fitHeight),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        partner != null
                                                            ? partner!['name']
                                                            : '',
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '${workingdate!} - ${workingtime!}',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'gambar/pesanpartner.png'),
                                                            fit: BoxFit
                                                                .fitHeight),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'gambar/telponpartner.png'),
                                                            fit: BoxFit
                                                                .fitHeight),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, right: 20.w),
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            //  width: 100,
                                            //  height: 100,
                                            child: TimelineTile(
                                              afterLineStyle: LineStyle(
                                                  color: isdone == 1
                                                      ? Colors.green
                                                      : softGrey,
                                                  thickness: 3),
                                              indicatorStyle: IndicatorStyle(
                                                  color: isdone == 1
                                                      ? Colors.green
                                                      : softGrey,
                                                  width: 15),
                                              isFirst: true,
                                              endChild: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      awal,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      'tukang telah mengambil order',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
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
                                              beforeLineStyle: LineStyle(
                                                  color: isdone == 1
                                                      ? Colors.green
                                                      : softGrey,
                                                  thickness: 3),
                                              afterLineStyle: LineStyle(
                                                  color: isdonekedua == 1
                                                      ? Colors.green
                                                      : softGrey,
                                                  thickness: 3),
                                              indicatorStyle: IndicatorStyle(
                                                  color: isdonekedua == 1
                                                      ? Colors.green
                                                      : softGrey,
                                                  width: 15),
                                              endChild: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${kedua}',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    isdonekedua == 1
                                                        ? Text(
                                                            Address,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                          )
                                                        : Text(
                                                            'menunggu tukang sampai lokasi anda',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
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
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20.w,
                                                                right: 20.w,
                                                                top: 20.w,
                                                                bottom: 10.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              'Pekerjaan',
                                                              style: TextStyle(
                                                                  color:
                                                                      blackBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                            Icon(
                                                              Icons.expand_more,
                                                              color: blackBlue,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                    ],
                                                  )),
                                              showWork
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 30.w),
                                                      child: Container(
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                orderansemua ==
                                                                        null
                                                                    ? 0
                                                                    : orderansemua
                                                                        .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    i) {
                                                              return Column(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _selectedIndex[i] =
                                                                            !_selectedIndex[i];
                                                                      });
                                                                      print(i);
                                                                      print(
                                                                          _selectedIndex);
                                                                    },
                                                                    child: Row(
                                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              15,
                                                                          height:
                                                                              15,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: AssetImage('gambar/pesanan.png'), fit: BoxFit.fitHeight),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              2,
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .circle,
                                                                          size:
                                                                              5,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              2,
                                                                        ),
                                                                        Flexible(
                                                                            child:
                                                                                Text(
                                                                          orderansemua[i]
                                                                              [
                                                                              'service_name'],
                                                                          style:
                                                                              TextStyle(fontSize: 13),
                                                                        )),
                                                                        SizedBox(
                                                                          width:
                                                                              3,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            40.0,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          //  width: 100,
                                                                          //  height: 50,
                                                                          child:
                                                                              TimelineTile(
                                                                            isFirst:
                                                                                true,
                                                                            beforeLineStyle:
                                                                                LineStyle(color: isdonekedua == 1 ? Colors.green : softGrey, thickness: 3),
                                                                            afterLineStyle:
                                                                                LineStyle(color: orderansemua[i]['steps'][0]['is_done'] == 1 ? Colors.green : softGrey, thickness: 3),
                                                                            indicatorStyle:
                                                                                IndicatorStyle(color: orderansemua[i]['steps'][0]['is_done'] == 1 ? Colors.green : softGrey, width: 15),
                                                                            endChild:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    orderansemua[i]['steps'][0]['step_name'],
                                                                                    style: TextStyle(fontSize: 12),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 4,
                                                                                  ),
                                                                                  orderansemua[i]['steps'][0]['is_done'] == 1
                                                                                      ? Container(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                            image: DecorationImage(image: NetworkImage(orderansemua[i]['steps'][0]['images']), fit: BoxFit.cover),
                                                                                          ),
                                                                                        )
                                                                                      : Container(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: Image.asset(
                                                                                            'gambar/foto.png',
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        //
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            orderansemua[i]['is_done'] == 1
                                                                                ? '${orderansemua[i]['time']}'
                                                                                : '',
                                                                            style:
                                                                                TextStyle(color: primary),
                                                                          ),
                                                                        )

                                                                        //
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  //
                                                                  Divider(
                                                                    thickness:
                                                                        1,
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ))
                                        : SizedBox(),
                                  ],
                                )

//
//
//                       partner != null
//                           ?

//                       partner != null
//                           ? Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: SizedBox(
//                                 //  width: 100,
//                                 //  height: 50,
//                                 child: TimelineTile(
//                                   isFirst: true,
//                                   isLast: true,
//                                   beforeLineStyle: LineStyle(
//                                       color: isdoneterakhir == 1
//                                           ? Colors.green
//                                           : softGrey,
//                                       thickness: 3),
//                                   afterLineStyle: LineStyle(
//                                     color: isdoneterakhir == 1
//                                         ? Colors.green
//                                         : Colors.yellow,
//                                   ),
//                                   indicatorStyle: IndicatorStyle(
//                                       color: isdoneterakhir == 1
//                                           ? Colors.green
//                                           : Colors.yellow,
//                                       width: 15),
//                                   endChild: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Text(
//                                       terakhir,
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : SizedBox(),
//                       //
//                       SizedBox(
//                         height: 8,
//                       ),
//                       statusorder == 3
//                           ? GestureDetector(
//                               onTap: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return Dialog(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(
//                                                 15.0)), //this right here
//                                         child: Container(
//                                           height: 230,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(10.0),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   'Beri Review',
//                                                   style: TextStyle(
//                                                       color: Colors.grey),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 8,
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     RatingBar.builder(
//                                                       initialRating: 0,
//                                                       minRating: 0,
//                                                       direction:
//                                                           Axis.horizontal,

//                                                       //  allowHalfRating: true,
//                                                       //  unratedColor: Colors.grey,
//                                                       //  glowColor: Colors.red,
//                                                       itemCount: 5,
//                                                       itemPadding:
//                                                           EdgeInsets.symmetric(
//                                                               horizontal: 4.0),
//                                                       itemBuilder:
//                                                           (context, _) => Icon(
//                                                         Icons.star,
//                                                         color: Colors.amber,
//                                                       ),
//                                                       onRatingUpdate: (rating) {
//                                                         setState(() {
//                                                           bintang = rating;
//                                                         });
//                                                         //  print(bintang);
//                                                       },
//                                                     ),
// // Text('${bintang}'.replaceAll('.0', ''))
//                                                   ],
//                                                 ),
// //
//                                                 Container(
//                                                   // width: MediaQuery.of(context).size.width,
//                                                   // height: MediaQuery.of(context).size.height / 10,
//                                                   decoration: BoxDecoration(
//                                                       // color: Colors.blue[50],
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               25)),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 10.0,
//                                                             right: 10,
//                                                             top: 15),
//                                                     child: TextField(
//                                                       // controller: email,
//                                                       // textAlign: TextAlign.left,
//                                                       // ignore: unnecessary_new
//                                                       decoration:
//                                                           new InputDecoration(
//                                                         fillColor:
//                                                             Colors.blue[50],
//                                                         filled: true,
//                                                         contentPadding:
//                                                             EdgeInsets.only(
//                                                                 left: 10,
//                                                                 right: 0,
//                                                                 top: 20),
//                                                         hintText:
//                                                             'Tulis review disini',
//                                                         //        prefixIcon:  Padding(
//                                                         //   padding: const EdgeInsets.all(20.0),
//                                                         //   child: Image.asset(
//                                                         //     'gambar/email.png',
//                                                         //     width: 25,
//                                                         //     height: 25,
//                                                         //     fit: BoxFit.fill,
//                                                         //   ),
//                                                         // ),
//                                                         hintStyle: TextStyle(
//                                                             color: Colors.grey,
//                                                             fontSize: 12),
//                                                         border:
//                                                             OutlineInputBorder(
//                                                                 borderRadius:
//                                                                     const BorderRadius
//                                                                         .all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           10.0),
//                                                                 ),
//                                                                 borderSide:
//                                                                     BorderSide
//                                                                         .none),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     addData();
//                                                   },
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 150.0,
//                                                             right: 10,
//                                                             top: 10),
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(15),
//                                                           color:
//                                                               Colors.blue[300]),
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .only(
//                                                                 left: 0,
//                                                                 right: 0,
//                                                                 top: 12,
//                                                                 bottom: 12),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             Container(
//                                                               width: 20,
//                                                               height: 20,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 image: DecorationImage(
//                                                                     image: AssetImage(
//                                                                         'gambar/simpan.png'),
//                                                                     fit: BoxFit
//                                                                         .fitHeight),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                               width: 15,
//                                                             ),
//                                                             Text(
//                                                               'simpan',
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 14),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     });
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 15.0, right: 15),
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(25),
//                                       color: Colors.blue,
//                                     ),
//                                     width: MediaQuery.of(context).size.width,
//                                     child: Center(
//                                         child: Padding(
//                                       padding: const EdgeInsets.all(15.0),
//                                       child: Text(
//                                         'Beri Review',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     ))),
//                               ),
//                             )
//                           : SizedBox(),
//                       //
//                       statusorder == 3
//                           ? Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 15.0, right: 15, top: 8),
//                               child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(25),
//                                     color: Colors.red,
//                                   ),
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Center(
//                                       child: Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Text(
//                                       'Kirim Laporan',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ))),
//                             )
//                           : SizedBox(),
//                       //
//                       SizedBox(
//                         height: 5,
//                       ),
                        ],
                      ),
                      // Positioned(
                      //     // top: 10.h,
                      //     top: MediaQuery.of(context).size.height,
                      //     bottom: 0,
                      //     left: 0,
                      //     right: 0,
                      //     child: Text('batal order')),
                    ))),
              ],
            ),
          ));
    }
  }

  var bintang;
//   //
  bool showWork = false;
  bool isloading = false;
  @override
  void initState() {
    getDataListHome();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isloading = !isloading;
      });
    });
    Timer.periodic(Duration(seconds: 50), (timer) {
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

  //
  var partner;
  late String customer;
  late int statusorder;
  late String? workingdate;
  late String? workingtime;
  getDataListHome() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(
        Uri.parse(Uri.encodeFull(
            'https://olla.ws/api/customer/v1/order-detail/${988}')),
        headers: {
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
  late String awal;
  late List orderansemua;
  late int isdone;
  late int isdonekedua;
  late String kedua;
  late String terakhir;
  late int isdoneterakhir;
  late String latitudekedua;
  late String longitudekedua;
  getDataListorderStep() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(
        Uri.parse(Uri.encodeFull(
            'https://olla.ws/api/customer/v1/order-step/${988}')),
        headers: {
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
    orderansemua = converDataToJsonsteporder['stepMiddle'];
    _selectedIndex =
        List<bool>.filled(orderansemua.length, false, growable: true);
    setState(() {
      print(orderansemua);
      awal =
          converDataToJsonsteporder['stepStart'][0]['step_name']; //ambil order
      isdone = converDataToJsonsteporder['stepStart'][0]
          ['is_done']; //isdone ambil order
      latitude = converDataToJsonsteporder['stepStart'][0]
          ['latitude']; //latitude ambil order
      longitude = converDataToJsonsteporder['stepStart'][0]
          ['longitude']; //longitude ambil order
      kedua = converDataToJsonsteporder['stepStart'][1]
          ['step_name']; //sampai rumah pelanggan
      isdonekedua = converDataToJsonsteporder['stepStart'][1]
          ['is_done']; //isdone sampai rumah pelanggan
      latitudekedua = converDataToJsonsteporder['stepStart'][1]
          ['latitude']; //latitude sampai rumah
      longitudekedua = converDataToJsonsteporder['stepStart'][1]
          ['longitude']; //longitude sampai rumah
      terakhir = converDataToJsonsteporder['stepEnd'][0]['step_name'];
      isdoneterakhir = converDataToJsonsteporder['stepEnd'][0]['is_done'];
      //  orderan=orderansemua['service_name'];
      print(converDataToJsonsteporder);
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
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(latitudekedua), double.parse(longitudekedua));
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
    var response = await http.get(
        Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/rate/25')),
        headers: {
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
          context,
          MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
          (Route<dynamic> route) => false);
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
