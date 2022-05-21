import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SlideBanner extends StatefulWidget {
  @override
  _SlideBannerState createState() => _SlideBannerState();
}

class _SlideBannerState extends State<SlideBanner> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 160,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (BuildContext context, i) {
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
              child: loading
                  ? Container(
                      // height: 20,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        // border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://olla.ws/images/slide-banner/${list[i]}'),
                            fit: BoxFit.cover),
                      ),
                    )
                  : Shimmer.fromColors(
                      child: Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                        ),
                      ),
                      baseColor: Colors.grey[100]!,
                      highlightColor: Colors.grey[300]!,
                      direction: ShimmerDirection.ltr,
                    ),
            );
            // :Shimmer.fromColors(
            //                         child: Padding(
            //                           padding: const EdgeInsets.only(left:8,right:8,bottom: 8),
            //                           child: Container(
            //                            decoration: BoxDecoration(
            //                               color: Colors.grey,
            //                              borderRadius: BorderRadius.circular(10)
            //                            ),
            //                             // height: 50,
            //                            width: 220,
            //                           ),
            //                         ),
            //                         baseColor: Colors.grey[100],
            //                         highlightColor: Colors.grey[300],
            //                         direction: ShimmerDirection.ltr,
            //                       );
          },
          // shrinkWrap: true,
          //   scrollDirection: Axis.horizontal,
          //   children: [
          //  Padding(
          //    padding: const EdgeInsets.only(right: 3),
          //    child: Container(
          //      height: 20,
          //      width: 200,
          //      color: Colors.red,
          //    ),
          //  ),
          //   Padding(
          //    padding: const EdgeInsets.only(right: 3),
          //     child: Container(
          //      height: 20,
          //      width: 200,
          //      color: Colors.green,
          //  ),
          //   ),
          //  Padding(
          //    padding: const EdgeInsets.only(right: 3),
          //    child: Container(
          //       height: 20,
          //      width: 200,
          //      color: Colors.blue,
          //    ),
          //  ),
          //  Padding(
          //     padding: const EdgeInsets.only(right: 3),
          //    child: Container(
          //       height: 20,
          //      width: 200,
          //      color: Colors.black,
          //    ),
          //  ),
          //    Padding(
          //      padding: const EdgeInsets.only(right: 3),
          //      child: Container(
          //       height: 20,
          //      width: 200,
          //      color: Colors.red,
          //  ),
          //    ),
          //   Padding(
          //      padding: const EdgeInsets.only(right: 3),
          //     child: Container(
          //       height: 20,
          //      width: 200,
          //      color: Colors.green,
          //  ),
          //   ),
          //  Padding(
          //      padding: const EdgeInsets.only(right: 3),
          //    child: Container(
          //       height: 20,
          //      width: 200,
          //      color: Colors.blue,
          //    ),
          //  ),
          //  Padding(
          //    padding: const EdgeInsets.only(right: 3),
          //    child: Container(
          //      height: 20,
          //      width: 200,
          //      color: Colors.black,
          //    ),
          //  ),
          // ],
        ),
      ),
    );
  }

  //SlideBnnaer
  late List data;
  late String customer;
  late String data1;
  late String data2;
  late String data3;
  late String data4;
  late String data5;
  late String data6;
  late String data7;
  late List list;
  getDataSlidBanner() async {
    var response = await http.get(
        Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/slide-banner')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      data = converDataToJson['data'];
      data1 = converDataToJson['data'][4]['image'];
      data2 = converDataToJson['data'][5]['image'];
      data3 = converDataToJson['data'][6]['image'];
      data4 = converDataToJson['data'][7]['image'];
      data5 = converDataToJson['data'][8]['image'];
      data6 = converDataToJson['data'][9]['image'];
      //  data7=converDataToJson['data'][10]['image']??'';
      // ignore: avoid_print
      list = [data1, data2, data3, data4, data5, data6];
      print(data7);
    });
    return "Success";
  }

  @override
  void initState() {
    getDataSlidBanner();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = true;
      });
    });
    super.initState();
  }
}
