import 'package:discount_calc_new/screens/home/calculator_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: mainBackScaffoldColor,
      body:  CalculatorBody(),
    );
  }
}
