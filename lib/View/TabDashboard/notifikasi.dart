import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore_for_file: prefer_const_constructors
class Notifikasi extends StatefulWidget {
  String name;
  // Get Key Data
  Notifikasi({Key? key, required this.name}) : super(key: key);
  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  @override
  Widget build(BuildContext context) {
    //  time = DateFormat(
    //                                             "EEEE, dd MMMM yyyy", "id_ID")
    //                                         .format(_myDateTime);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm ').format(now);
    String tanggal = DateFormat("dd/MMMM/yyyy", "id_ID").format(now);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                // ignore: avoid_unnecessary_containers
                child: Container(
                  height: MediaQuery.of(context).size.height / 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.blue[50],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
              ),
              GestureDetector(
                onTap: () {
                  // print(datalist);
                },
                child: Text(
                  "Notifikasi",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'comfortaa',
                  ),
                ),
              ),
              //
              SizedBox(
                width: 130,
              ),
              //
              // Column(
              //   // ignore: prefer_const_literals_to_create_immutables
              //   children: [
              //     Icon(
              //       Icons.add_alert_rounded,
              //       color: Colors.white,
              //     ),
              //   ],
              // )
            ],
          ),
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.transparent,
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[200]!)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Login',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue)),
                  SizedBox(height: 10),
                  Flexible(
                      child: Text('Anda Login Sebagai ${widget.name}',
                          style:
                              TextStyle(fontSize: 20, color: Colors.black54))),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(formattedDate,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[300])),
                      SizedBox(
                        width: 5,
                      ),
                      Text('-',
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[300])),
                      SizedBox(
                        width: 5,
                      ),
                      Text(tanggal,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[300])),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
