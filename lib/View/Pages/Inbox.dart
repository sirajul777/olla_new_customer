import 'package:customer/View/Components/appProperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inbox extends StatefulWidget {
  Inbox({Key? key}) : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: null,
        body: SafeArea(
          top: false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.dark),
              child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('1'), Text('2')],
                  ))),
        ));
  }
}
