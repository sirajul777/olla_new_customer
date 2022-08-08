import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Pages/Transaksi/History.dart';
import 'package:customer/View/Pages/Transaksi/Proses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Transaski extends StatefulWidget {
  @override
  State<Transaski> createState() => _TransaskiState();
}

class _TransaskiState extends State<Transaski> with SingleTickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    getDataorder();
    getDataProses().whenComplete(() => getHistory().whenComplete(() {
          getDataFinish().whenComplete((() => setState(() {
                loading = true;
              })));
        }));
    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     loading = true;
    //   });
    // });
    _tabController = TabController(vsync: this, length: 2);
    _tabController!.addListener(_handleTabSelection);
  }

  Future getDataFinish() async {
    var response = await http.get(Uri.parse(Uri.encodeFull('${KEY.BASE_URL}/order?is_finished=1')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer ${customer!}",
    });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      history = converDataToJson['data'];
      // print(converDataToJson);
    });
    // print(datalist);
    return "Success";
  }

// data history
  late List? history;
  Future getHistory() async {
    var response =
        await http.get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order?is_canceled=1')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer ${customer!}",
    });
    var converDataToJson = json.decode(response.body);
    if (converDataToJson['data'].length != 0) {
      setState(() {
        history!.add(converDataToJson['data']);
      });
    } else {
      print(converDataToJson['data'].length);
    }

    return "Success";
  }

  void _handleTabSelection() async {
    setState(() {});
  }

  String? customer;
  Future getDataorder() async {
    final prefs1 = await SharedPreferences.getInstance();
    setState(() {
      customer = prefs1.getString('customer')!;
    });
  }

  bool loading = false;
  //
  List? datalist;
  // get data proses transaksi
  Future getDataProses() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer ${customer!}",
    });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      datalist = converDataToJson['data'];

      // ignore: avoid_print
      // print(datalist);
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
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
      // TabController _tabController = TabController(length: 3, vsync: this);
      // a
      return Center(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
              ),
              child: Scaffold(
                  appBar: null,
                  body: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Column(children: [
                        Container(
                          color: white,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                          padding: EdgeInsets.all(15),
                          child: Center(
                              child: Text(
                            'Transaksi',
                            style: TextStyle(color: darkGrey, fontSize: 18.sp),
                          )),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height,
                            // constraints: BoxConstraints(
                            //   minHeight: double.infinity,
                            // ),
                            // height: double.infinity,

                            child: NestedScrollView(
                              // scrollBehavior: ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.glow),
                              clipBehavior: Clip.none,
                              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                                return [
                                  SliverAppBar(
                                    backgroundColor: white,
                                    pinned: true,
                                    flexibleSpace: FlexibleSpaceBar(
                                      collapseMode: CollapseMode.pin,
                                      background: Container(
                                        child: TabBar(
                                          controller: _tabController,
                                          labelColor: darkGrey,
                                          unselectedLabelColor: Colors.grey,
                                          indicatorColor: primary,
                                          tabs: [
                                            Container(
                                                // width: double.maxFinite,
                                                // height: MediaQuery.of(context).size.height / 40,
                                                // decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.circular(8),
                                                //     border: Border.all(color: _tabController!.index == 0 ? Colors.blue : Colors.grey)),
                                                child: Tab(
                                              text: 'Aktifitas',
                                            )),
                                            //
                                            Container(
                                                // width: double.maxFinite,
                                                // height: MediaQuery.of(context).size.height / 40,
                                                // decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.circular(8),
                                                //     border: Border.all(color: _tabController!.index == 1 ? Colors.blue : Colors.grey)),
                                                child: Tab(
                                              text: 'Histori',
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ];
                              }),
                              body: TabBarView(
                                // physics: NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                children: [
                                  Proses(
                                    customer: customer,
                                    datalist: datalist,
                                    loading: loading,
                                  ),
                                  History(
                                    customer: customer,
                                    loading: loading,
                                    datahistory: history,
                                  )
                                ],
                              ),
                            ))
                      ])))));
    }
  }
}
