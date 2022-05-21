import 'package:customer/View/Auth/Login/send_otp.dart';
import 'package:customer/View/Auth/Register/Register.dart';

import 'package:flutter/material.dart';

class DaftarMasuk extends StatefulWidget {
  @override
  State<DaftarMasuk> createState() => _DaftarMasukState();
}

class _DaftarMasukState extends State<DaftarMasuk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('gambar/login.png'),
              ),
            ),
          ),
          //
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('gambar/image3.png'),
              ),
            ),
          ),
          //
          Flexible(
            child: Container(
                child: Text(
              'Daftar & Masuk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 70, right: 70, top: 10),
              child: Text(
                "Silahkan daftar atau login terlebih dahulu untuk bisa menikmati layanan dari kami ",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 13, height: 2.0, color: Colors.black54),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blue,
                ),
                child: Center(
                    child: Text(
                  'Daftar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 150,
                color: Colors.grey[200],
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Atau',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 150,
                height: 1,
                color: Colors.grey[200],
              ),
            ],
          ),
          //
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SendOtp()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blue[50],
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(
                    child: Text(
                  'Masuk',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
