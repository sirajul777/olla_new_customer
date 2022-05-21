import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  @override
  List tanggal = [];

// Get Key Data
  Second({
    Key? key,
    required this.tanggal,
  }) : super(key: key);

  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  void initState() {
    super.initState();
    widget.tanggal;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.tanggal == null ? 0 : widget.tanggal.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(widget.tanggal[index]['name']);
            })
        // GestureDetector(
        //   onTap: (){
        //     print(widget.tanggal);
        //   },
        //   child:Center(child: Text('kjjhg'))
        // )
        );
  }
}
