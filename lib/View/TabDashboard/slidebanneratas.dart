import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:customer/Service/API/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// class SlideBannerAtas extends StatefulWidget {
//   @override
//   _SlideBannerAtasState createState() => _SlideBannerAtasState();
// }

// class _SlideBannerAtasState extends State<SlideBannerAtas> {
//    bool loading =false;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         height: 160,
//         child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//                      itemCount: data==null?0: data.length,
//           itemBuilder: (BuildContext context, i) {
//             return Padding(
//               padding: const EdgeInsets.only(left:8,right:8,top: 10),
//               child: loading?Container(
//                 // height: 20,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.2),
//           spreadRadius: 1,
//           blurRadius: 5,
//           offset: Offset(0, 3), // changes position of shadow
//         ),
//     ],
//                   // border: Border.all(color: Colors.lightBlue),
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                       image: NetworkImage(
//                           'https://olla.ws/images/slide-banner/${data[i]['image']}'),
//                       fit: BoxFit.cover),
//                 ),
//               ) :Shimmer.fromColors(
//                       child: Container(
//                         width: 250,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                       baseColor: Colors.grey[100],
//                       highlightColor: Colors.grey[300],
//                       direction: ShimmerDirection.ltr,
//                     ),
//             );
//             // :Shimmer.fromColors(
//             //                         child: Padding(
//             //                           padding: const EdgeInsets.only(left:8,right:8,bottom: 8),
//             //                           child: Container(
//             //                            decoration: BoxDecoration(
//             //                               color: Colors.grey,
//             //                              borderRadius: BorderRadius.circular(10)
//             //                            ),
//             //                             // height: 50,
//             //                            width: 220,
//             //                           ),
//             //                         ),
//             //                         baseColor: Colors.grey[100],
//             //                         highlightColor: Colors.grey[300],
//             //                         direction: ShimmerDirection.ltr,
//             //                       );
//           },
//           // shrinkWrap: true,
//           //   scrollDirection: Axis.horizontal,
//           //   children: [
//           //  Padding(
//           //    padding: const EdgeInsets.only(right: 3),
//           //    child: Container(
//           //      height: 20,
//           //      width: 200,
//           //      color: Colors.red,
//           //    ),
//           //  ),
//           //   Padding(
//           //    padding: const EdgeInsets.only(right: 3),
//           //     child: Container(
//           //      height: 20,
//           //      width: 200,
//           //      color: Colors.green,
//           //  ),
//           //   ),
//           //  Padding(
//           //    padding: const EdgeInsets.only(right: 3),
//           //    child: Container(
//           //       height: 20,
//           //      width: 200,
//           //      color: Colors.blue,
//           //    ),
//           //  ),
//           //  Padding(
//           //     padding: const EdgeInsets.only(right: 3),
//           //    child: Container(
//           //       height: 20,
//           //      width: 200,
//           //      color: Colors.black,
//           //    ),
//           //  ),
//           //    Padding(
//           //      padding: const EdgeInsets.only(right: 3),
//           //      child: Container(
//           //       height: 20,
//           //      width: 200,
//           //      color: Colors.red,
//           //  ),
//           //    ),
//           //   Padding(
//           //      padding: const EdgeInsets.only(right: 3),
//           //     child: Container(
//           //       height: 20,
//           //      width: 200,
//           //      color: Colors.green,
//           //  ),
//           //   ),
//           //  Padding(
//           //      padding: const EdgeInsets.only(right: 3),
//           //    child: Container(
//           //       height: 20,
//           //      width: 200,
//           //      color: Colors.blue,
//           //    ),
//           //  ),
//           //  Padding(
//           //    padding: const EdgeInsets.only(right: 3),
//           //    child: Container(
//           //      height: 20,
//           //      width: 200,
//           //      color: Colors.black,
//           //    ),
//           //  ),
//           // ],
//         ),
//       ),
//     );
//   }
//   //SlideBnnaer
//   List data;
//   String customer;
//   getDataSlidBanner() async {

//     var response = await http.get(
//         Uri.parse(Uri.encodeFull(
//             'https://olla.ws/api/customer/slide-banner')),
//         headers: {
//           "Accept": "application/json",
//           "x-token-olla": KEY.APIKEY,
//         });
//     //
//     setState(() {
//       var converDataToJson = json.decode(response.body);
//       data = converDataToJson['data'];
//       // ignore: avoid_print
//       // print('$data');
//     });
//     return "Success";
//   }

//   @override
//   void initState() {
//     getDataSlidBanner();
//      Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         loading = true;
//       });
//       });
//     super.initState();
//   }
// }
class SlideBannerAtas extends StatefulWidget {
  @override
  _SlideBannerAtasState createState() => _SlideBannerAtasState();
}

class _SlideBannerAtasState extends State<SlideBannerAtas> {
  @override
  bool loading = false;

  Widget build(BuildContext context) {
    return Center(
      child: data == null
          ? Text('')
          : CarouselSlider.builder(
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
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage =
                    'https://olla.ws/images/slide-banner/${data[index]['image']}';
                return buildImage(urlImage, index);
              },
            ),
    );
  }

  //
  late List data;
  late String customer;

  getDataSlidBanner() async {
    var response = await http.get(
        Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/slide-banner')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      data = converDataToJson['data'];

      // print(data);
      // print(data);
      // ignore: avoid_print
      // print('$data');
    });
    return "Success";
  }

  @override
  void initState() {
    getDataSlidBanner();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = true;
      });
    });
    super.initState();
  }

  Widget buildImage(String urlImage, int index) => loading
      ? Padding(
          padding:
              const EdgeInsets.only(left: 4.0, right: 4, bottom: 2, top: 2),
          child: Container(
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('${urlImage}'), fit: BoxFit.cover)),
            // child: Image.network('${urlImage}',fit: BoxFit.fitWidth,),
          ),
        )
      : Shimmer.fromColors(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 2.0, right: 2, bottom: 2, top: 2),
            child: Container(
              width: MediaQuery.of(context).size.width,
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
