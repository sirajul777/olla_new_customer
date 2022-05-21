// import 'dart:async';
// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// class EasyLoading extends StatefulWidget{
//   @override
//   State<EasyLoading> createState() => _EasyLoadingState();
// }

// class _EasyLoadingState extends State<EasyLoading> {
//   @override
//  void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//     ..loadingStyle = EasyLoadingStyle.dark
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.yellow
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.yellow
//     ..textColor = Colors.yellow
//     ..maskColor = Colors.blue.withOpacity(0.5)
//     ..userInteractions = true
//     ..dismissOnTap = false;
//     // ..customAnimation = CustomAnimation();
// }
// //
// @override
// void initState(){
//   super.initState();
//   configLoading();
//   //
//   EasyLoading.addStatusCallback((status) {
//       print('EasyLoading Status $status');
//       if (status == EasyLoadingStatus.dismiss) {
//         _timer?.cancel();
//       }
//     });
//      EasyLoading.showSuccess('Use in initState');
// }
//  Timer _timer;
// @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body:   EasyLoading(),
//     );
//   }
// }