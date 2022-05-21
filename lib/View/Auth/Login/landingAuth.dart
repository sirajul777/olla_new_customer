import 'package:customer/View/Auth/Login/send_otp.dart';
import 'package:customer/View/Auth/Register/Register.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingAuth extends StatefulWidget {
  const LandingAuth({Key? key}) : super(key: key);

  @override
  _LandingAuthState createState() => _LandingAuthState();
}

class _LandingAuthState extends State<LandingAuth> {
  @override
  Widget build(BuildContext context) {
    return Material(
      // color: white,
      child: SafeArea(
          top: false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                statusBarColor: white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(color: white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 1.h, bottom: 3.5.h),
                          width: 94,
                          height: 94,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('image/login.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  // padding: EdgeInsets.all(20.w),
                  width: 180,
                  child: const Image(
                    alignment: Alignment.center,
                    image: AssetImage('image/tukang.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: Text(
                    'Daftar & Masuk',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Text(
                    'Silahkan daftar atau login terlebih dahulu untuk bisa menikmati layanan kami',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                      fontSize: 12.w,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SendOtp()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      child: const Center(
                          child: Text('Masuk',
                              style: TextStyle(color: Colors.white))),
                      height: 45,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primary),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Atau',
                    style: TextStyle(
                      color: darkGrey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.w,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Register()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      child: const Center(
                          child:
                              Text('Daftar', style: TextStyle(color: primary))),
                      height: 45,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: lightBlue),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
