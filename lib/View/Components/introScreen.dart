import 'package:customer/View/Auth/Login/landingAuth.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({Key? key}) : super(key: key);

  @override
  _IntroscreenState createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  final introscreendate = GetStorage();

  void endIntroPge(context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LandingAuth()),
        (Route<dynamic> route) => false);

    introscreendate.write('welcome', true);
  }

  @override
  Widget build(BuildContext context) {
    final List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        title: '',
        bodyWidget: SafeArea(
            top: false,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  statusBarColor: white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.dark),
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
                            margin: EdgeInsets.only(top: 3.5.h, bottom: 3.5.h),
                            width: 94,
                            height: 94,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('gambar/login.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 1.5,
                    margin: EdgeInsets.only(top: 5.h),
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: const Image(
                      alignment: Alignment.center,
                      image: AssetImage('image/ac.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Pilih Apa Yang Kamu Mau Perbaiki',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.w,
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    'Kami siap melayani dan datang ke rumah Anda untuk memperbaiki kerusakan yang Ada',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                      fontSize: 12.w,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )),
      ),
      PageViewModel(
          title: '',
          bodyWidget: SafeArea(
            top: false,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  statusBarColor: white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.dark),
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
                            margin: EdgeInsets.only(top: 3.5.h, bottom: 3.5.h),
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
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 1.5,
                    margin: EdgeInsets.only(top: 5.h),
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: const Image(
                      alignment: Alignment.center,
                      image: AssetImage('image/air.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Cari Tukang Yang Jelas',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.w,
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    'Pilih tukang terbaik recommendasi kami untuk menyelesaikan masalah Anda',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                      fontSize: 12.w,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )),
    ];
    return IntroductionScreen(
      globalBackgroundColor: white,
      pages: listPagesViewModel,
      onDone: () {
        // When done button is press
        endIntroPge(context);
      },
      onSkip: () {
        // when skit is clicked
        endIntroPge(context);
      },
      // showBackButton: true,
      skipStyle: TextButton.styleFrom(
        // alignment: Alignment.bottomRight,
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      doneStyle: TextButton.styleFrom(
        backgroundColor: primary,
        // alignment: Alignment.bottomRight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      showNextButton: false,
      showDoneButton: true,
      showSkipButton: true,
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(10.0, 10.0),
          activeColor: primary,
          color: Colors.grey,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
      // back: const Icon(Icons.arrow_back),
      done: const Text("Selesai",
          style: TextStyle(fontWeight: FontWeight.w600, color: white)),
      skip: const Text("Lewati >",
          style: TextStyle(fontWeight: FontWeight.w600, color: white)),
      // next: const Text(" >",
      //     style: TextStyle(fontWeight: FontWeight.w600, color: white)),
    );
  }
}
