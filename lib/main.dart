import 'dart:async';

import 'package:customer/View/Auth/Login/landingAuth.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Components/introScreen.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:loading/indicator/ball_pulse_indicator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: prefer_const_constructors
void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        // designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        builder: (context, Widget) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Localizations Sample App',
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale(
                  'id',
                ), // English, no country code
              ],
              theme: ThemeData(fontFamily: 'Inter'),
              home: MyHomePage(),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  // final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final introscreendate = GetStorage();
  final introscreendate2 = GetStorage();
  // final introscreendate = GetStorage();
  void complate() async {
    final preferences = await SharedPreferences.getInstance();

    emailuser = preferences.getString('sukses') ?? '';
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      if (introscreendate.read('welcome')) {
        if (emailuser.isNotEmpty) {
          return Dashboard();
        } else {
          print(introscreendate2.read('customer'));
          return LandingAuth();
        }
      } else {
        return Introscreen();
      }
    }), (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    introscreendate.writeIfNull("welcome", false);
    _getGeoLocationPosition();
    Timer(Duration(seconds: 2), complate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
            top: false,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.dark),
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.5),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('gambar/login.png'),
                              ),
                            ),
                          ),
                          Loading(
                            indicator: BallPulseIndicator(),
                            size: 50,
                            color: primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  //
  // void startTimer() async{
  //    Timer(Duration(seconds: 2), () {
  //       Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => SendOtp(),
  //       ),
  //     );
  //    });
  // }

  late String emailuser = '';
  // void startTimer() async {
  //   SharedPreferences? preferences = await SharedPreferences.getInstance();

  //   emailuser = preferences.getString('sukses')!;

  //   Timer(Duration(seconds: 2), () {
  //     if (emailuser != '' && emailuser.characters == "200") {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) => Dashboard(),
  //         ),
  //       );
  //     } else {
  //       //   Navigator.of(context).pushReplacement(
  //       //   MaterialPageRoute(
  //       //     builder: (BuildContext context) => SendOtp(),
  //       //   ),
  //       // );

  //     }
  //     // emailuser==null?Navigator.of(context).pushReplacement(
  //     //   MaterialPageRoute(
  //     //     builder: (BuildContext context) => Login(),
  //     //   ),
  //     // ):Navigator.of(context).pushReplacement(
  //     //   MaterialPageRoute(
  //     //     builder: (BuildContext context) => Dashboard(),
  //     //   ),
  //     // );
  //   });
  // }

  //
  String location = 'Null, Press Button';
  String Address = 'search';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }
}
