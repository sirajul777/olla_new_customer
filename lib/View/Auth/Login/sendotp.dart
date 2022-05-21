import 'dart:async';

import 'package:customer/Models/Auth.dart';
import 'package:customer/View/Auth/Login/loading.dart';
import 'package:flutter/material.dart';

class SendOtpNumber extends StatefulWidget {
  String email;
  String code;
  Auth? auth;
// Get Key Data
  SendOtpNumber({Key? key, required this.email, required this.code, this.auth})
      : super(key: key);

  @override
  State<SendOtpNumber> createState() => _SendOtpNumberState();
}

class _SendOtpNumberState extends State<SendOtpNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: Colors.blue[800]),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  // margin: EdgeInsets.only(
                  //     top: MediaQuery.of(context).size.height / 3),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('gambar/splashscreen.png'),
                    ),
                  ),
                ),
              ),
              // Loading(
              //   indicator: BallPulseIndicator(),
              //   size: 50,
              //   color: Colors.grey[400],
              // ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() async {
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Login(
            email1: widget.email,
            code1: widget.code,
          ),
        ),
      );
    });
  }
}
