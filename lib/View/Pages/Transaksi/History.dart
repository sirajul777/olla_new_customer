import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  String? customer;
  List? datahistory;
  bool? loading;
  History({Key? key, this.customer, this.datahistory, this.loading});
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    if (!widget.loading!) {
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
          // controller: _controller,
          // shrinkWrap: true,
          // physics: const AlwaysScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          itemCount: widget.datahistory == null ? 0 : widget.datahistory!.length,
          itemBuilder: (BuildContext context, index) {
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
                      Text(widget.datahistory![index]['message'] ?? '',
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
                            widget.datahistory![index]['expired_payment'] ?? '',
                            style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6), height: 1.3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
