import 'package:discount_calc_new/common/strings.dart';
import 'package:discount_calc_new/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}