import 'package:discount_calc_new/common/colors.dart';
import 'package:discount_calc_new/common/strings.dart';
import 'package:flutter/material.dart';

class DCTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onClearPressed;
  final String? label;
  final int? maxLength;
  final bool? discountValueError;

  const DCTextField(
      {Key? key, this.controller, this.onClearPressed, this.label, this.maxLength, this.discountValueError}):super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('DC_TF discountvalueerror: $discountValueError');
    return TextField(
      cursorColor: textColor,
      controller: controller,
      style: const TextStyle(
        color: textColor,
      ),
      maxLength: maxLength,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: const Icon(Icons.cancel, color: Colors.white24),
            onPressed: onClearPressed ?? () {}),
        labelText: label ?? '',
        labelStyle: const TextStyle(
          color: textColor,
          fontSize: 17.0,
        ),
        errorText: discountValueError!  ? Strings.discountvalueerrorText : null,
        focusedBorder: _getTFBorderDecoration,
        enabledBorder: _getTFBorderDecoration,
        errorBorder: _getTFBorderDecoration,
        focusedErrorBorder: _getTFBorderDecoration
      ),
    );
  }

  final _getTFBorderDecoration = const OutlineInputBorder(
          borderSide: BorderSide(color: textColor, width: 1.0),
        );
}
