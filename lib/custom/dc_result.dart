import 'package:discount_calc_new/common/colors.dart';
import 'package:flutter/material.dart';

class DCResultField extends StatelessWidget {
  DCResultField({
    required this.displayLabelTxt,
    required this.labelFontSize,
    required this.amntFontSize,
    required this.value,
  });

  final double value;
  final String displayLabelTxt;
  final double labelFontSize;
  final double amntFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          displayLabelTxt ?? '',
          style: TextStyle(fontSize: labelFontSize, color: resultColor, fontWeight: FontWeight.w700),
          textAlign: TextAlign.left,
        ),
        // Expanded(
        Text(
          '${value ?? 0} Rs',
          style: TextStyle(
              color: textColor,
              fontSize: amntFontSize,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        // ),
      ],
    );
  }
}
