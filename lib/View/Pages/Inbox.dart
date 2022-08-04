import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Inbox extends StatefulWidget {
  Inbox({Key? key}) : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  late ScrollController _controller;
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  late List? data;
  bool loading = false;
  Future getDataGrid() async {
    var response = await http.get(
        Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/brodcast')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    if (response.statusCode == 200) {
      setState(() {
        var converDataToJson = json.decode(response.body);
        data = converDataToJson['data_banner'];
        // ignore: avoid_print
        // print(converDataToJson);
      });
    }
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getDataGrid();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.only(top: 17, bottom: 10),
          child: Center(
              child: Text(
            "Inbox",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
      body: SafeArea(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: //body
                    ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.all(16),
                              child: Card(
                                  elevation: 4.0,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 200.0,
                                        child: Ink.image(
                                          image: NetworkImage(
                                              data![index]['banner_foto']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    data![index]['banner_name'],
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                      data![index]
                                                          ['description'],
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      )),
                                                )
                                              ])),
                                    ],
                                  )));
                        }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
