import 'package:discount_calc_new/common/colors.dart';
import 'package:discount_calc_new/screens/home/calculator_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackScaffoldColor,
      body:  CalculatorBody(),
    );
  }
}
