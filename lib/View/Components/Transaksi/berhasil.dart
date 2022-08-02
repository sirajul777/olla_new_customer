import 'dart:convert';

import 'package:customer/Service/API/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Berhasil extends StatefulWidget {
  @override
  State<Berhasil> createState() => _BerhasilState();
}

class _BerhasilState extends State<Berhasil> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // shrinkWrap: true,
        itemCount: datalist == null ? 0 : datalist.length,
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
                    Text('- ${datalist[index]['message']}',
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
                          datalist[index]['expired_payment'],
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

  @override
  void initState() {
    super.initState();
    getDataProses();
  }

  //
  late List datalist;
  late String customer;
  getDataProses() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(Uri.parse(Uri.encodeFull('${KEY.BASE_URL}/order?is_finished=1')), headers: {
      "Accept": "application/json",
      "x-token-olla": KEY.APIKEY,
      "Authorization": "Bearer $customer",
    });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      datalist = converDataToJson['data'];

      // ignore: avoid_print
      print(converDataToJson);
    });
    return "Success";
  }
}
