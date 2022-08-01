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
        ? Container(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(
                    left: (ScreenUtil().setWidth(20.w)), right: (ScreenUtil().setWidth(20.w)), bottom: 20.h, top: 3.h),
                // padding: EdgeInsets.only(
                //   top: 5.w,
                // ),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: lightBlue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                      // width: MediaQuery.of(context)
                      //         .size
                      //         .width /
                      //     2,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                          child: Text(
                            'Pesan Tukang',
                            style: TextStyle(
                              color: darkGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Text(
                            'di Kota Anda',
                            style: TextStyle(
                                color: softGrey,
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
                                      color: darkGrey,
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
                                      color: darkGrey,
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
              ),
              Container(
                color: Color.fromARGB(255, 249, 249, 249),
                padding: EdgeInsets.only(
                    left: (ScreenUtil().setWidth(20.w)), right: (ScreenUtil().setWidth(20.w)), bottom: 20.h, top: 3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rekomendasi Mitra',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkGrey),
                          ),
                          Text('Lihat Semua',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.greenAccent,
                                decoration: TextDecoration.underline,
                              ))
                        ],
                      ),
                    ),
                    Text(
                      'Pilih mitra siaga kami',
                      style: TextStyle(color: softGrey, fontSize: 11.sp),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 15.w, bottom: 10.w),
                        // decoration: BoxDecoration(),
                        // margin: EdgeInsets.only(top: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.w),
                              height: 85.w,
                              width: 85.w,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(8),
                                  // color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color.fromARGB(255, 242, 242, 242), width: 1.5),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        'image/mitra1.png',
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 5.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 5.h),
                                    child: Text(
                                      'Aby Abdullah',
                                      style: TextStyle(
                                          color: darkGrey,
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
                                      Container(
                                        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 3.w, bottom: 3.w),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: darkYellow, width: 0.7),
                                            borderRadius: BorderRadius.circular(20.w)),
                                        child: Text(
                                          'Pompa air',
                                          style: TextStyle(
                                              color: darkYellow,
                                              // fontWeight:
                                              //     FontWeight.bold,
                                              fontSize: 9.w,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 3.w),
                                        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 3.w, bottom: 3.w),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: darkYellow, width: 0.7),
                                            borderRadius: BorderRadius.circular(20.w)),
                                        child: Text(
                                          'Pendingin ruangan',
                                          style: TextStyle(
                                              color: darkYellow,
                                              // fontWeight:
                                              //     FontWeight.bold,
                                              fontSize: 9.w,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      )

                                      // Container(
                                      //   // padding: EdgeInsets.only(
                                      //   //     bottom: 5.h),
                                      //   child: Text(
                                      //     'Sumbawa',
                                      //     style: TextStyle(
                                      //         color: softGrey,
                                      //         // fontWeight:
                                      //         //     FontWeight.bold,
                                      //         fontSize: 13.w,
                                      //         fontStyle: FontStyle.normal),
                                      //   ),
                                      // ),
                                    ],
                                  )),
                                  Row(
                                    children: [
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
                                      const Icon(
                                        Icons.star,
                                        color: darkYellow,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Container(
                                      // margin: EdgeInsets.only(left: 15.w),
                                      width: 60,
                                      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 3.w, bottom: 3.w),
                                      decoration:
                                          BoxDecoration(color: primary, borderRadius: BorderRadius.circular(20.w)),
                                      child: Center(
                                        child: Text(
                                          'Pilih',
                                          style: TextStyle(color: white, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                width: 16.w,
                                height: 16.w,
                                decoration: BoxDecoration(
                                    border: Border.all(color: softGrey, width: 1),
                                    borderRadius: BorderRadius.circular(20.w)),
                                margin: EdgeInsets.only(left: 20.w),
                                child: Center(
                                    child: Text(
                                  '>',
                                  style: TextStyle(color: softGrey, fontSize: 12.sp),
                                )))
                          ],
                        ))
                  ],
                ),
              )
              //todo akhir row atas
            ]),
          )
        : Shimmer.fromColors(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pesan Tukang',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
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
                          ]),
                      //)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(color: Colors.grey[200]),
                                  image: DecorationImage(image: AssetImage('gambar/bg.png'), fit: BoxFit.cover),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tukang Teladan',
                                    style:
                                        TextStyle(color: Colors.blue[900], fontWeight: FontWeight.w500, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Hariyono Makmur',
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey[200]!),
                                          image: DecorationImage(
                                              image: AssetImage('gambar/bintang.png'), fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '5.0',
                                        style:
                                            TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Jakarta',
                                        style: TextStyle(color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                '',
                                style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.w500, fontSize: 15),
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
                                      image: DecorationImage(image: AssetImage('gambar/gambar.png'), fit: BoxFit.cover),
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
                                      image:
                                          DecorationImage(image: AssetImage('gambar/gambar1.png'), fit: BoxFit.cover),
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
