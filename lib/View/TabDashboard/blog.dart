import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer/View/Components/appProperties.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class Blog extends StatefulWidget {
  List? data;
  Blog({this.data});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: widget.data! == null
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
                itemCount: widget.data! == null ? 0 : widget.data!.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = '${widget.data![index]['foto']}';
                  return buildImage(urlImage, index);
                },
              ),
      ),
    );
  }

  //

  //
  Widget buildImage(String urlImage, int index) => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '${urlImage}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => new Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    child: const Center(
                      child: SpinKitFadingCircle(
                        color: softGrey,
                        size: 30.0,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Flexible(
                child: Text(
              widget.data![index]['title'],
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.w, color: darkGrey),
            )),
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   // color: Colors.red,
            //   child: const Center(
            //     child: SpinKitFadingCircle(
            //       color: softGrey,
            //       size: 30.0,
            //     ),
            //   ),
            // )
          ],
        ),
      );
//       : Shimmer.fromColors(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8.0, right: 8),
//             child: Container(
//               width: 250,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.grey[500],
//               ),
//             ),
//           ),
//           baseColor: Colors.grey[100]!,
//           highlightColor: Colors.grey[300]!,
//           direction: ShimmerDirection.ltr,
//         );
// //
}
