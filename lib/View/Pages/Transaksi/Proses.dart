import 'dart:ffi';

import 'package:customer/Service/API/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Proses extends StatefulWidget {
  String? customer;
  List? datalist;
  bool? loading;
  Proses({Key? key, required this.customer, this.datalist, this.loading});

  @override
  State<Proses> createState() => _ProsesState();
}

class _ProsesState extends State<Proses> {
  int _pageSize = 6;
  int _start = 0;
  final PagingController<int, dynamic> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    try {
      var newItems = await widget.datalist!.getRange(_start, _pageSize);
      // var isLastPage = ;
      print(widget.datalist!.length);
      print("size page" + '$_pageSize');
      if (_pageSize == widget.datalist!.length) {
        Positioned(
            bottom: 0,
            top: 0,
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 60.0,
              ),
            ));
        Future.delayed(Duration(seconds: 3), (() {
          _pagingController.appendLastPage(newItems.toList());
          // _start = _pageSize;
        }));

        print(newItems.length);
      } else {
        Positioned(
            bottom: 0,
            top: 0,
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 60.0,
              ),
            ));

        Future.delayed(Duration(seconds: 3), (() {
          var nextPageKey = pageKey + newItems.length;
          _pagingController.appendPage(newItems.toList(), nextPageKey);

          // setState(() {
          //   _start += _pageSize;
          //   _pageSize += _start + newItems.length;
          // });
        }));
        print(newItems.length);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loading!) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: const Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 60.0,
            ),
          ),
        ),
      );
    } else {
      return RefreshIndicator(
          onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
              ),
          child: PagedListView<int, dynamic>(
            // shrinkWrap: true,
            // clipBehavior: Clip.none,
            // loadingListingBuilder: (
            //   context,
            //   itemBuilder,
            //   itemCount,
            //   progressIndicatorBuilder,
            // ) =>
            //     SliverGrid(
            //   gridDelegate: gridDelegate,
            //   delegate: _buildSliverDelegate(
            //     itemBuilder,
            //     itemCount,
            //     statusIndicatorBuilder: progressIndicatorBuilder,
            //   ),
            // ),
            // errorListingBuilder: (
            //   context,
            //   itemBuilder,
            //   itemCount,
            //   errorIndicatorBuilder,
            // ) =>
            //     SliverGrid(
            //   gridDelegate: gridDelegate,
            //   delegate: _buildSliverDelegate(
            //     itemBuilder,
            //     itemCount,
            //     statusIndicatorBuilder: errorIndicatorBuilder,
            //   ),
            // ),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<dynamic>(
                // newPageProgressIndicatorBuilder:,
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue[100]!,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item!['order_id'] ?? '',
                              style: TextStyle(fontSize: 13, color: Colors.blue, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(item!['message'] ?? '',
                                style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6))),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Text('- expired_payment',
                                    style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6))),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  item!['expired_payment'] ?? '',
                                  style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6), height: 1.3),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ));

      ListView.builder(
          clipBehavior: Clip.none,
          shrinkWrap: true,
          itemCount: widget.datalist == null ? 0 : widget.datalist!.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue[100]!,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.datalist![index]['order_id'] ?? '',
                        style: TextStyle(fontSize: 13, color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(widget.datalist![index]['message'] ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6))),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text('- expired_payment',
                              style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6))),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.datalist![index]['expired_payment'] ?? '',
                            style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6), height: 1.3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
