import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors
// ignore: use_key_in_widget_constructors
class Count extends StatefulWidget {
  // String title;
  // Count({this.title});
  @override
  // ignore: unnecessary_new
  _CountState createState() => new _CountState();
}

class _CountState extends State<Count> {
  int _itemCount = 0;
  List count = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (_itemCount > 0) {
                _itemCount--;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(5)),
            height: 20,
            width: 20,
            child: Icon(Icons.remove, size: 18, color: Colors.white),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(_itemCount.toString()),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              count.add(_itemCount++);
              print(count);
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              height: 20,
              width: 20,
              child: Icon(
                Icons.add,
                size: 18,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
