bool isValidNumber(double value) {
  print('helper isValidNumber: $value');
  return value > 0 && !value.isNegative;

}

bool isValidDiscountNumber(double value) {
  print('helper isValidDiscount: $value');
  return value > 0 && value < 101 && !value.isNegative;
  
}
