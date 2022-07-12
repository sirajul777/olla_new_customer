import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class Blog extends StatefulWidget {
  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  bool loading = false;
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: data == null
            ? Text('')
            : CarouselSlider.builder(
                options: CarouselOptions(
                  // aspectRatio: 16/9,
                  viewportFraction: 0.7,

                  initialPage: 0,
                  // enableInfiniteScroll: true,
                  // reverse: false,
                  // autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  // autoPlayAnimationDuration: Duration(milliseconds: 800),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  // enlargeCenterPage: true,

                  scrollDirection: Axis.horizontal,

                  height: MediaQuery.of(context).size.height / 4.1,
                ),
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = '${data[index]['foto']}';
                  return buildImage(urlImage, index);
                },
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDatablog();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = true;
      });
    });
  }

  //
  late List data;
  late String customer;

  getDatablog() async {
    var response = await http.get(
        Uri.parse(
            Uri.encodeFull('https://master.olla.co.id/api/landingpage/blog')),
        headers: {
          "Accept": "application/json",
          "x-token-olla":
              'ab2a492367bc1f4fdbf9fe81d26b77488a0125858dcf61a21e33e86db0279840d46fa2cdeb011956b62691c8bb51ca8340c8a562f0f89e764d51f4df6948f2c7',
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      data = converDataToJson['blog'];

      print(data);
      // print(data);
      // ignore: avoid_print
      // print('$data');
    });
    return "Success";
  }

  //
  Widget buildImage(String urlImage, int index) => loading
      ? Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8,bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 180,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '${urlImage}',
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 3,
              ),
              Flexible(
                  child: Text(
                data[index]['title'],
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10),
              )),
            ],
          ),
        )
      : Shimmer.fromColors(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[500],
              ),
            ),
          ),
          baseColor: Colors.grey[100]!,
          highlightColor: Colors.grey[300]!,
          direction: ShimmerDirection.ltr,
        );
//
}
