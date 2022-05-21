import 'dart:async';
import 'dart:io';

import 'package:customer/Controllers/AuthController.dart';
import 'package:customer/Models/Auth.dart';
import 'package:customer/View/Auth/Login/sendotp.dart';
import 'package:customer/View/Auth/Register/Register.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
// ignore_for_file: prefer_const_constructors

// ignore: use_key_in_widget_constructors
class SendOtp extends StatefulWidget {
  @override
  State<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  void initState() {
    canSubmit = false;
    super.initState();
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            // ignore: sized_box_for_whitespace
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // color: Colors.yellow,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 10),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('gambar/login.png'),
                          ),
                        ),
                      ),
                      //
                      SizedBox(
                        height: 10,
                      ),
                      //
                      Text(
                        'Masuk Akun',
                        style: TextStyle(fontSize: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  // color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextFormField(
                                controller: email,
                                onChanged: (vale) {
                                  if (vale.length == 0) {
                                    setState(() {
                                      canSubmit = false;
                                    });
                                  } else {
                                    setState(() {
                                      canSubmit = true;
                                    });
                                  }
                                },
                                autocorrect: false,

                                // textAlign: TextAlign.left,
                                // ignore: unnecessary_new
                                decoration: new InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 20, right: 20, top: 5),
                                  hintText: 'Email atau No. Handpone',
                                  hintStyle: TextStyle(color: softGrey),
                                  prefixIcon: Icon(
                                    Icons.perm_identity_rounded,
                                    size: 30,
                                    color: darkGrey,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(25.0),
                                      ),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            //
                            SizedBox(
                              height: 20,
                            ),
                            //
                            canSubmit
                                ? GestureDetector(
                                    onTap: () {
                                      addData();
                                      setState(() {
                                        loading = !loading;
                                      });
                                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Dashboard()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Container(
                                        child: const Center(
                                            child: Text('Kirim OTP',
                                                style: TextStyle(
                                                    color: Colors.white))),
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: primary),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Dashboard()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Container(
                                        child: const Center(
                                            child: Text('Kirim OTP',
                                                style: TextStyle(
                                                    color: Colors.white))),
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: darkGrey),
                                      ),
                                    ),
                                  ),
                            //
                            SizedBox(
                              height: 10,
                            ),
                            //
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text('Dont have an account '),
                            //     // ignore: avoid_unnecessary_containers
                            //     GestureDetector(
                            //       onTap: (){
                            //         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Register()));
                            //       },
                            //       child: Container(
                            //         child: Text(
                            //           'Sign Up ',
                            //           style: TextStyle(
                            //             color: Colors.blue,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum Punya Akun ?',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // ignore: avoid_unnecessary_containers
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Register()));
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             SendOtp()),
                        //     (Route<dynamic> route) => false);
                      },
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: Text(
                          'Daftar ',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          //
          //  GestureDetector(
          //    onTap:(){

          //    },
          //    child: Center(
          //               child: Padding(
          //               padding: const EdgeInsets.only(
          //                   left: 50.0, right: 50, top: 70),
          //               child: Container(
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(10),
          //                       color: Colors.indigo.withOpacity(0.7)),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Loading(
          //                           indicator: BallPulseIndicator(),
          //                           size: 30,
          //                           color: Colors.white,
          //                         ),
          //                         SizedBox(width: 24),
          //                         Text('Menunggu Pembayaran',
          //                             style: TextStyle(
          //                                 fontSize: 16,
          //                                 color: Colors.white,
          //                                 fontWeight: FontWeight.w500)),
          //                       ],
          //                     ),
          //                   )),
          //             )),
          //  )
        ],
      ),
    );
  }

  bool canSubmit = false;
  bool iscomplate = false;
  //
  TextEditingController email = TextEditingController();
  //
  addData() async {
    // var random = randomAlphaNumeric(32).toLowerCase();
    // String myUrl = "http://45.13.132.61:3000/reseller/signup";
    try {
      Auth auth = await AuthController.postLoginAuthToApi(email: email.text);
      SweetAlert.show(
        context,
        subtitle: "Waiting!",
        style: SweetAlertStyle.loading,
      );
      print(auth.code);
      if (auth.code == 200) {
        final preps = await SharedPreferences.getInstance();

        preps.setString('secret_code', auth.data!.secretCode!);

        setState(() {
          // pengenalid = jsonObj['customer_id'];
          // _incrementCounter();
        });

        Future.delayed(const Duration(seconds: 4), () {
          setState(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SendOtpNumber(
                        email: email.text, code: auth.data!.secretCode!)),
                (Route<dynamic> route) => false);
          });
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(17),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Maaf!!!',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Masukkan Data Anda Dengan Benar',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                      )),
                  Positioned(
                    // bottom: 10,
                    top: 0,
                    left: 16,
                    right: 16,
                    child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset('gambar/login.png')),
                  )
                ],
              ),
            );
          },
        );
      }
    } on SocketException catch (_) {
      return SweetAlert.show(
        context,
        subtitle: "No Internet Connection!",
        style: SweetAlertStyle.error,
      );
      // throw Failed(code: 101, response: "no connection");r
    } on TimeoutException {
      return SweetAlert.show(
        context,
        subtitle: "Connection Timeout!",
        style: SweetAlertStyle.error,
      );
    }

    // String myUrl = "https://olla.ws/api/customer/v1/login";
    // http.post(Uri.parse(Uri.encodeFull(myUrl)), headers: {
    //   'Accept': 'application/json',
    //   "x-token-olla": KEY.APIKEY,
    //   // "imei": "123456"
    // }, body: {
    //   "email": email.text,
    // }).then((response) async {
    //   var jsonObj = json.decode(response.body);
    //   var secret = jsonObj['data']['secret_code'];

    //   // print('$statusinactive');
    //   // return print('$data');
    //   //   return showDialog(
    //   //       context: context,
    //   //       barrierDismissible: false,
    //   //       builder: (BuildContext context) {
    //   //         return WillPopScope(
    //   //           onWillPop: () async => false,
    //   //           child: GestureDetector(onTap: () {
    //   //             Navigator.pop(context);
    //   //             // Navigator.pushAndRemoveUntil(
    //   //             //     context,
    //   //             //     MaterialPageRoute(
    //   //             //         builder: (BuildContext context) => HomeScreen()),
    //   //             //     (Route<dynamic> route) => false);
    //   //           }, child: StatefulBuilder(
    //   //             builder: (BuildContext context, StateSetter setState) {
    //   //               return SimpleDialog(
    //   //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   //                 contentPadding: EdgeInsets.zero,
    //   //                 titlePadding: EdgeInsets.only(bottom: 0),
    //   //                 title: Column(
    //   //                   children: [
    //   //                     Container(
    //   //                       decoration: BoxDecoration(
    //   //                       color:Colors.deepPurple[400],
    //   //                         borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10))
    //   //                       ),
    //   //                       height:20,
    //   //                     ),
    //   //                     SizedBox(height:15),
    //   //                     Text('Akun Belum Aktiv'),
    //   //                     SizedBox(height:15),
    //   //                     RaisedButton(
    //   //                       child:Text('Verifikasi Akun'),
    //   //                       onPressed: (){
    //   //                         // _launchMap();
    //   //                       },
    //   //                     ),
    //   //                     SizedBox(height:15),
    //   //                   ],
    //   //                 )
    //   //               );
    //   //             },
    //   //           )),
    //   //         );
    //   //       });
    //   // } else {}
    // });
//
//
  }

  //
  void alert() async {
    SweetAlert.show(
      context,
      subtitle: "Cancel!",
      style: SweetAlertStyle.error,
    );
  }
}
