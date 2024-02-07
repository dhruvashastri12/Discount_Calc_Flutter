import 'package:discount_calc_new/common/colors.dart';
import 'package:discount_calc_new/common/strings.dart';
import 'package:discount_calc_new/screens/home/calculator_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackScaffoldColor,
      appBar: AppBar(
        backgroundColor: bodyScaffoldColor,
        title: Text(
          Strings.appName,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
            child: Container(
              color: bodyScaffoldColor,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(0.0)),
      ),
      body: CalculatorBody(),
    );
  }
}
