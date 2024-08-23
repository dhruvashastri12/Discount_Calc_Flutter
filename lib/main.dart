import 'package:discount_calc_new/common/strings.dart';
import 'package:discount_calc_new/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}