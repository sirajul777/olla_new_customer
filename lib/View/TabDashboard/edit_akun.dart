import 'dart:convert';
import 'package:customer/Service/API/api.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAkun extends StatefulWidget {
  @override
  State<EditAkun> createState() => _EditAkunState();
}

class _EditAkunState extends State<EditAkun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.blue[50],
                ),
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
              width: 100,
            ),
            GestureDetector(
              onTap: () {
                // dataku();
                getDataCustomer();
              },
              child: Text(
                'Edit Akun',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'comfortaa',
                ),
              ),
            ),
            //
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
      body: Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
            // color: Colors.blue[50],
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15),
          child: TextField(
            // controller: email,
            // textAlign: TextAlign.left,
            // ignore: unnecessary_new
            decoration: new InputDecoration(
              fillColor: Colors.blue[50],
              filled: true,
              contentPadding: EdgeInsets.only(left: 10, right: 0, top: 20),
              hintText: 'Tulis review disini',
              //        prefixIcon:  Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Image.asset(
              //     'gambar/email.png',
              //     width: 25,
              //     height: 25,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
      ),
    );
  }

  //
  late String customer;

  late String nama;
  late List profile;
  getDataCustomer() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(
        Uri.parse(Uri.encodeFull(
            'https://olla.ws/api/customer/v1/customer-profile/')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
          "Authorization": 'Bearer $customer',
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      print(converDataToJson);
      String namaa = converDataToJson['data'];
      // print(profile);
      print(namaa.toString());
      // data1 = converDataToJson['profile'][0]['name'];
      // // ignore: avoid_print
      // print('$data1');
      // print(nama);
    });
    return "Success";
  }
}
