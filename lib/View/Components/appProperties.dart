import 'package:flutter/material.dart';

const Color primary = Color.fromARGB(255, 3, 169, 245);
const Color lightBlue = Color.fromARGB(255, 241, 246, 251);
const Color darkBlue = Color.fromARGB(255, 1, 114, 220);
const Color blackBlue = Color.fromARGB(255, 46, 62, 92);
const Color mediumYellow = Color.fromARGB(255, 255, 190, 86);
const Color darkYellow = Color.fromARGB(255, 255, 181, 0);
const Color ligthgreen = Color.fromARGB(255, 68, 224, 149);
const Color transparent = Color.fromARGB(0, 255, 255, 255);
const Color darkGrey = Color.fromARGB(255, 70, 70, 70);
const Color softGrey = Color.fromARGB(255, 206, 205, 205);
const Color redDanger = Color.fromRGBO(236, 60, 3, 1);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color whiteTransparent = Color.fromARGB(94, 255, 255, 255);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(236, 60, 3, 1),
  Color.fromRGBO(234, 60, 3, 1),
  Color.fromRGBO(216, 78, 16, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}
