import 'package:customer/View/slide/daftar_masuk.dart';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class HomeSlide extends StatefulWidget {
  @override
  State<HomeSlide> createState() => _HomeSlideState();
}

class _HomeSlideState extends State<HomeSlide> {
  //
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(Slide(
        title: 'Pilih Apa Yang Kamu Mau Perbaiki ',
        // styleTitle: TextStyle(
        //         color: Colors.black,
        //         fontSize: 30.0,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'RobotoMono'),
        description: "Kami siap melayani dan datang kerumah Anda untuk memperbaiki kerusakan yang Ada ",
        // styleDescription: TextStyle(
        //         color: Colors.black,
        //         fontSize: 12.0,
        //        ),
        //  directionColorBegin: Alignment.topLeft,
        // directionColorEnd: Alignment.bottomRight,
        pathImage: 'gambar/image1.png'));
    slides.add(Slide(
        title: 'Cari Tukang Yang Jelas',
        description: "Pilih tukang rekomendasi kami untuk menyelesaikan masalah Anda",
        //      directionColorBegin: Alignment.topLeft,
        // directionColorEnd: Alignment.bottomRight,
        pathImage: 'gambar/image2.png'));
    // slides.add(Slide(
    //   title: 'Daftar & Masuk',
    //   description:
    //       "Silahkan daftar atau login terlebih dahulu untuk bisa menikmati layanan dari kami ",
    //   pathImage: 'gambar/image3.png',
    //   centerWidget: Text('fhksdfhksdhfkjs'),
    // ));
  }

//
  void onDonePress() {
    // Do what you want
    Navigator.push(context, MaterialPageRoute(builder: (context) => DaftarMasuk()));
    // );
  }

//
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60, top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Image.asset(
                  'gambar/login.png',
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Image.asset(
                  '${currentSlide.pathImage}',
                  matchTextDirection: true,
                  width: 300.0,
                  height: 250.0,
                  fit: BoxFit.contain,
                ),
              ),
              Flexible(
                child: Container(
                    child: Text(
                  '${currentSlide.title}',
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
                    '${currentSlide.description}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, height: 2.0, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      backgroundColorAllSlides: Colors.white,
      // renderSkipBtn: Text("Skip"),
      renderNextBtn: Container(
          height: 40,
          // width: 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
          child: Center(
              child: Text(
            "Lewati",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ))),
      renderDoneBtn: Container(
          height: 40,
          // width: 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
          child: Center(
              child: Text(
            "Lewati",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ))),
      onDonePress: this.onDonePress,
      colorActiveDot: Colors.blue,
      showDotIndicator: true,
      colorDot: Colors.blue,
      sizeDot: 10,
      // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: this.renderListCustomTabs(),
      scrollPhysics: BouncingScrollPhysics(),
      // showDoneBtn: false,
      // hideStatusBar: false,
    );
  }
}
