import 'package:discount_calc_new/common/colors.dart';
import 'package:discount_calc_new/common/strings.dart';
import 'package:discount_calc_new/screens/home/calculator_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackScaffoldColor,
      // appBar: AppBar(
      //   // backgroundColor: bodyScaffoldColor,
      //   title: const Text(
      //     Strings.appName,
      //     style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      //   ),
      //   flexibleSpace: Container(
      //                     decoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //             colors: mainBackScaffoldGradientColors,
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //           ),
      //         ),
      //   ),
      // ),
      body:  CalculatorBody()
        
    );
  }
}
