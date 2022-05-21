import 'package:customer/View/Components/appProperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DibawahBanner extends StatefulWidget {
  @override
  State<DibawahBanner> createState() => _DibawahBannerState();
}

class _DibawahBannerState extends State<DibawahBanner> {
  @override
  bool loading = false;
  Widget build(BuildContext context) {
    return loading
        ? Padding(
            padding: EdgeInsets.only(
                left: (ScreenUtil().setWidth(10.w)),
                right: (ScreenUtil().setWidth(10.w)),
                bottom: 20.h,
                top: 3.h),
            child: Container(
              padding: EdgeInsets.only(top: 5.w, bottom: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: lightBlue),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.h),
                      // width: MediaQuery.of(context)
                      //         .size
                      //         .width /
                      //     2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Pesan Tukang',
                                style: TextStyle(
                                  color: blackBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.w,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: Text(
                                'di Kota Anda',
                                style: TextStyle(
                                    color: blackBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.w,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: GestureDetector(
                                onTap: (() {}),
                                child: Text(
                                  'Cari Tukang',
                                  style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )
                          ]),
                    ),
                    Container(
                      // margin: EdgeInsets.only(
                      //     top: 40.h, left: 20.w),
                      // row image circle
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: whiteTransparent,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'image/jakarta.png',
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                    width: 60.w,
                                    height: 60.w,
                                  )),
                              Container(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: Text(
                                  'Jakarta',
                                  style: TextStyle(
                                      color: blackBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.w,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: whiteTransparent,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'image/tangerang.png',
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                    width: 60.w,
                                    height: 60.w,
                                  )),
                              Container(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: Text(
                                  'Tangerang',
                                  style: TextStyle(
                                      color: blackBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.w,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.all(5.h),
                              child: GestureDetector(
                                onTap: (() {}),
                                child: Text(
                                  '+3',
                                  style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.w,
                                      decoration: TextDecoration.underline),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                //todo akhir row atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.w),
                      height: 155.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          image: const DecorationImage(
                              image: AssetImage(
                                'image/test.jpg',
                              ),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 20.h, left: 5.w, bottom: 20.h, right: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: Text(
                              'Tukang Teladan',
                              style: TextStyle(
                                  color: blackBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.w,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: Text(
                              'Aby Abdullah',
                              style: TextStyle(
                                  color: blackBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.w,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Container(
                              // width: 20.w,
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                color: darkYellow,
                              ),
                              Container(
                                padding: EdgeInsets.all(5.h),
                                child: Text(
                                  '5.0',
                                  style: TextStyle(
                                      color: darkYellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.w,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.only(
                                //     bottom: 5.h),
                                child: Text(
                                  'Sumbawa',
                                  style: TextStyle(
                                      color: softGrey,
                                      // fontWeight:
                                      //     FontWeight.bold,
                                      fontSize: 13.w,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                )
              ]),
            ),
          )
        : Shimmer.fromColors(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue[50]!),
                    color: Colors.grey[50]),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pesan Tukang',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'di Kota Anda',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 18),
                          Text('Cari Tukang',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),

                          SizedBox(
                            height: 15,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(color: Colors.grey[200]),
                                  image: DecorationImage(
                                      image: AssetImage('gambar/bg.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tukang Teladan',
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Hariyono Makmur',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey[200]!),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'gambar/bintang.png'),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '5.0',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Jakarta',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ],
                          )
                          //
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(''),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      image: DecorationImage(
                                          image:
                                              AssetImage('gambar/gambar.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Jakarta',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      image: DecorationImage(
                                          image:
                                              AssetImage('gambar/gambar1.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Tangerang',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '+3',
                                    style: TextStyle(
                                      color: Colors.blue[400],
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            baseColor: Colors.grey[100]!,
            highlightColor: Colors.grey[300]!,
            direction: ShimmerDirection.ltr,
          );
    //  Container(
    //    color: Colors.red,
    //    child: Padding(
    //        padding: const EdgeInsets.all(18),
    //        child: ListView(
    //          shrinkWrap: true,
    //          physics: NeverScrollableScrollPhysics(),
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               ListTile(
    //                 title:Text('Pesan Tukang',style: TextStyle(color:Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
    //                 subtitle:Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Stack(
    //                       children: [
    //                         Text('di Kota Anda',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
    //                         Padding(
    //                           padding: const EdgeInsets.only(top:40.0),
    //                           child: Text('Cari Tukang',style: TextStyle(color:Colors.blue[400],fontWeight: FontWeight.w600,fontSize: 20, decoration:TextDecoration.underline,),),
    //                         )
    //                       ],
    //                     ),
    //                     SizedBox(height: 30,)
    //                   ],
    //                 ),
    //                 trailing:  Stack(
    //                   overflow: Overflow.visible,
    //                   children: [
    //                     Row(
    //                      mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         Container(
    //                                                   width: 60,
    //                                                   height: 60,
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius: BorderRadius.circular(35),
    //                                                     image: DecorationImage(
    //                                                         image: AssetImage('gambar/gambar.png'),
    //                                                         fit: BoxFit.cover),
    //                                                   ),
    //                                                 ),

    //                                                 SizedBox(width:20),
    //                                                 //
    //                                                 Container(
    //                                                   width: 60,
    //                                                   height: 60,
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius: BorderRadius.circular(35),
    //                                                     image: DecorationImage(
    //                                                         image: AssetImage('gambar/gambar1.png'),
    //                                                         fit: BoxFit.cover),
    //                                                   ),
    //                                                 ),
    //                                                  SizedBox(width:10),
    //                                                 //
    //                                                 Text('+3',style: TextStyle(color:Colors.blue[400],fontWeight: FontWeight.w600, decoration:TextDecoration.underline,),),
    //                       ],
    //                     ),
    //                     Positioned(
    //                       top:60,
    //                       child: Row(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           Padding(
    //                             padding: const EdgeInsets.only(left:8.0),
    //                             child: Text('Jakarta',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w500,fontSize: 12),),
    //                           ),
    //                            SizedBox(width:35),
    //                           Text('Tangerang',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w500,fontSize: 12),)
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               //
    //               //
    //               SizedBox(height: 1,),
    //               Row(
    //                 children: [
    //                   Container(
    //                     margin: EdgeInsets.only(left:15),
    //                                                       width: 160,
    //                                                       height: 160,
    //                                                       decoration: BoxDecoration(
    //                                                         borderRadius: BorderRadius.circular(10),
    //                                                         border: Border.all(color: Colors.grey[200]),
    //                                                         image: DecorationImage(
    //                                                             image: AssetImage('gambar/bg.png'),
    //                                                             fit: BoxFit.cover),
    //                                                       ),
    //                                                     ),
    //                                                     SizedBox(width: 20,),
    //                                                     //
    //                                                     Column(
    //                                                       crossAxisAlignment: CrossAxisAlignment.start,
    //                                                       children: [
    //                                                         Text('Tukang Teladan',style: TextStyle(color:Colors.blue[900],fontWeight: FontWeight.w500,fontSize: 15),),
    //                                                          SizedBox(height: 10,),
    //                                                          Text('Hariyono Makmur',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
    //                                                          SizedBox(height: 10,),
    //                                                          //
    //                                                           Row(
    //                                                             children: [
    //                                                               Container(
    //                                                       width: 10,
    //                                                       height: 10,
    //                                                       decoration: BoxDecoration(
    //                                                         borderRadius: BorderRadius.circular(10),
    //                                                         border: Border.all(color: Colors.grey[200]),
    //                                                         image: DecorationImage(
    //                                                                 image: AssetImage('gambar/bintang.png'),
    //                                                                 fit: BoxFit.cover),
    //                                                       ),
    //                                                     ),
    //                                                     SizedBox(width: 5,),
    //                                                     Text('5.0',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 12),),
    //                                                     SizedBox(width: 5,),
    //                                                     Text('Jakarta',style: TextStyle(color: Colors.grey,fontSize: 12),)
    //                                                             ],
    //                                                           ),
    //                                                       ],
    //                                                     ),

    //                 ],
    //               ),
    //                                                 SizedBox(height: 50,)
    //             ],
    //           ),
    //         ],
    //        ),
    //      ),
    //  );
  }

  //
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = true;
      });
    });
    super.initState();
  }
}
