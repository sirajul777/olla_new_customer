import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  String? customer;
  History(this.customer);
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
      return ListView.builder(
          // shrinkWrap: true,
          itemCount: datalist == null ? 0 : datalist!.length,
          itemBuilder: (BuildContext context, index) {
            if (datalist![index] == '[]') {
              return SizedBox();
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue[100]!,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pesanan Jasa Service',
                          style: TextStyle(fontSize: 13, color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(datalist![index]['message'] ?? '',
                            style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6))),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Text('- tanggal :', style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6))),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              datalist![index]['expired_payment'] ?? '',
                              style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6), height: 1.3),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataProses().whenComplete(() {
      return getHistory().whenComplete(() {
        setState(() {
          loading = true;
        });
      });
    });
  }

  bool loading = false;

  //
  late List? datalist;
  Future getDataProses() async {
    var response = await http.get(Uri.parse(Uri.encodeFull('${KEY.BASE_URL}/order?is_finished=1')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer ${widget.customer}",
    });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      datalist = converDataToJson['data'];
      // print(converDataToJson);
    });
    print(datalist);
    return "Success";
  }

  late List? history;
  Future getHistory() async {
    var response =
        await http.get(Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/v1/order?is_canceled=1')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer ${widget.customer}",
    });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      datalist!.add(converDataToJson['data']);

      // ignore: avoid_print
      // print(converDataToJson);
    });
    print(datalist!.last);
    return "Success";
  }
}
