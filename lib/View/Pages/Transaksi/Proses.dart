import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Proses extends StatefulWidget {
  String? customer;
  List? datalist;
  bool? loading;
  Proses({Key? key, required this.customer, this.datalist, this.loading});

  @override
  State<Proses> createState() => _ProsesState();
}

class _ProsesState extends State<Proses> {
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
          clipBehavior: Clip.none,
          shrinkWrap: true,
          itemCount: widget.datalist == null ? 0 : widget.datalist!.length,
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
                        widget.datalist![index]['order_id'] ?? '',
                        style: TextStyle(fontSize: 13, color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(widget.datalist![index]['message'] ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6))),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text('- expired_payment',
                              style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6))),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.datalist![index]['expired_payment'] ?? '',
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
