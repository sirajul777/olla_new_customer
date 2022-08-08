import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:customer/Service/API/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SlideBannerAtas extends StatefulWidget {
  List? databanner;
  SlideBannerAtas({this.databanner});
  @override
  _SlideBannerAtasState createState() => _SlideBannerAtasState();
}

class _SlideBannerAtasState extends State<SlideBannerAtas> {
  @override
  bool loading = false;

  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,

          initialPage: 1,
          // enableInfiniteScroll: true,
          // reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          // autoPlayAnimationDuration: Duration(milliseconds: 800),
          // autoPlayCurve: Curves.fastOutSlowIn,
          // enlargeCenterPage: true,

          scrollDirection: Axis.horizontal,
          height: MediaQuery.of(context).size.height / 3.6,
        ),
        itemCount: widget.databanner == null ? 0 : widget.databanner!.length,
        itemBuilder: (context, index, realIndex) {
          final urlImage = 'https://olla.ws/images/slide-banner/${widget.databanner![index]['image']}';
          return buildImage(urlImage, index);
        },
      ),
    );
  }

  //

  Widget buildImage(String urlImage, int index) => Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4, bottom: 2, top: 2),
        child: Container(
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage('${urlImage}'), fit: BoxFit.cover)),
          // child: Image.network('${urlImage}',fit: BoxFit.fitWidth,),
        ),
      );
}
//

