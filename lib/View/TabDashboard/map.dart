import 'package:flutter/material.dart';

class Map extends StatefulWidget{
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(child: Text('Map')),
    );
  }
}