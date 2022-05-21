import 'dart:async';

import 'package:customer/View/Auth/Login/otpnumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatefulWidget {
  String email1;
  String code1;
// Get Key Data
  Login({Key? key, required this.email1, required this.code1})
      : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 60.0,
          ),
        ),
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
            builder: (BuildContext context) =>
                OtpNumber(email2: widget.email1, code2: widget.code1)),
      );
    });
  }
}
