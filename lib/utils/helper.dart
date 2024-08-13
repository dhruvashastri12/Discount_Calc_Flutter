import 'package:flutter/material.dart';

bool isValidNumber(double value) {
  debugPrint('helper isValidNumber: $value');
  return value > 0 && !value.isNegative;

}

// bool isValidDiscountNumber(double value) {
//   print('helper isValidDiscount: $value');
//   return value > 0 && value < 100 && !value.isNegative;
  
// }
