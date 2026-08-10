import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:discount_calc_new/screens/discount_calculator_screen.dart';

// Replace with your actual import path for DiscountCalculatorScreen
// import 'package:your_app_name/screens/discount_calculator_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _checkForUpdate();
  }

  // Asynchronous check for Google Play Store updates
  Future<void> _checkForUpdate() async {
    try {
      final AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        // Triggers the immediate full-screen Google Play update dialog
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      // Prevents app crash if internet is down or running local debug build
      debugPrint('In-App Update check failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: mainBackScaffoldColor,
      // body: CalculatorBody(),
      body: DiscountCalculatorScreen(),
    );
  }
}