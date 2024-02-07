
import 'package:discount_calc_new/common/colors.dart';
import 'package:flutter/material.dart';

class DCRadioButton extends StatefulWidget {
  final int? selectedRadio;
  final String? label_1;
  final String? label_2;
  
  final void Function(int?)? onRadioChanged;

  DCRadioButton(
      {@required this.selectedRadio,
      @required this.label_1,
      @required this.label_2,
      @required this.onRadioChanged});

  @override
  _DCRadioButtonState createState() => _DCRadioButtonState();
}

class _DCRadioButtonState extends State<DCRadioButton> {
  int? selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: <Widget>[
      // Percentage radio button
      Radio(
        value: 0,
        activeColor: textColor,
        groupValue: widget.selectedRadio,
        onChanged: widget.onRadioChanged,
      ),
      Expanded(
        child: Text(
        (widget.label_1)!,
        style: const TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.w400, color: textColor),
        )
      ),
      // const SizedBox(
      //   width: 5,
      // ),

      // Flat amount radio button
      Radio(
        value: 1,
        activeColor: textColor,
        groupValue: widget.selectedRadio,
        onChanged: widget.onRadioChanged,
      ),
      Expanded(
        child: Text(
          (widget.label_2)!,
          style: const TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.w400, color: textColor),
        )
      )
    ])
    );
  }
}
