import 'package:discount_calc_new/common/colors.dart';
import 'package:discount_calc_new/common/strings.dart';
import 'package:discount_calc_new/custom/dc_radiobutton.dart';
import 'package:discount_calc_new/custom/dc_result.dart';
import 'package:discount_calc_new/custom/dc_textfield.dart';
import 'package:discount_calc_new/utils/helper.dart';
import 'package:flutter/material.dart';

class CalculatorBody extends StatefulWidget {
  @override
  _CalculatorBodyState createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  final itemPriceController = TextEditingController();
  final itemDiscountController = TextEditingController();

  double payableAmount = 0.0;
  double savingAmount = 0.0;

  int selectedRadio = 0;
  bool discountValueError = false;

  @override
  void initState() {
    super.initState();
    discountValueError = false;
    selectedRadio = 0;
    itemPriceController.addListener(_calculateDiscount);
    itemDiscountController.addListener(_calculateDiscount);

  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
          Strings.appName,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: cardColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            elevation: 5,
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(
                        unselectedWidgetColor: textColor,
                        disabledColor: textColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DCRadioButton(
                          // title: 'Best App development framework',
                          label_1: Strings.radioLabelPerecent,
                          label_2: Strings.radioLabelFlat,
                          selectedRadio: selectedRadio,
                          onRadioChanged: (int? selectionValue) {
                            setState(() {
                              selectedRadio = selectionValue!;
                              setSelectedRadio(selectedRadio);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DCTextField(
                    discountValueError: false,
                    label: Strings.TFLabelItemPrice,
                    controller: itemPriceController,
                    maxLength: 10,
                    onClearPressed: () {
                      debugPrint('ON CLEAR CLICKED item price');
                      itemPriceController.clear();
                      setState(() {
                        payableAmount = 0.0;
                        savingAmount = 0.0;
                      });
                    },
                  ),
                  SizedBox(height: 15.0),
                  DCTextField(
                    // discountValueError: discountValueError ? discountValueError : false,
                    discountValueError: discountValueError,
                    label: Strings.TFLabelDiscount,
                    controller: itemDiscountController,
                    // maxLength: 2,
                    onClearPressed: () {
                      debugPrint('ON CLEAR CLICKED discount');
                      itemDiscountController.clear();
                      setState(() {
                        payableAmount = 0.0;
                        savingAmount = 0.0;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: cardColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            elevation: 5,
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  DCResultField(
                      displayLabelTxt: Strings.resultLabelSave,
                      labelFontSize: 22.0,
                      amntFontSize: 26.0,
                      value: savingAmount),
                  SizedBox(height: 15.0),
                  DCResultField(
                      displayLabelTxt: Strings.resultLabelPayable,
                      labelFontSize: 25.0,
                      amntFontSize: 30.0,
                      value: payableAmount)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _calculateDiscount() {
    double itemPrice = double.parse(
        itemPriceController.text.isNotEmpty
            ? itemPriceController.text
            : '0');
    double discount = double.parse(itemDiscountController.text.isNotEmpty
        ? itemDiscountController.text
        : '0');

    if ((isValidNumber(itemPrice))) {
      if ((isValidDiscountNumber(discount))) {
        if (selectedRadio == 0) {
          double cuttingPrice = (itemPrice * discount) / 100;

          setState(() {
            discountValueError = false;
            payableAmount = (itemPrice - cuttingPrice);
            savingAmount = cuttingPrice;


            debugPrint(' if 0 isValidDiscountNumber $discountValueError');
            debugPrint('Cutting Price: $cuttingPrice');
            debugPrint('Saving Amount: $savingAmount');
            debugPrint('Percentage Discount: $payableAmount');
          });
        } else {
          setState(() {
            discountValueError = false;
            payableAmount = (itemPrice - discount);
            savingAmount = discount;


            debugPrint(' if 1 isValidDiscountNumber $discountValueError');
            debugPrint('Flat Discount: $payableAmount');
          });
        }
      }else if(discount >= 100){
        setState(() {
          // print('else discount length: $discount.toString().length');
          discountValueError = true;
          debugPrint(' else isValidDiscountNumber $discountValueError');
        });
      }
 
      }    
  }

  // // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      _calculateDiscount();
      debugPrint('Radio seletion changed $val');
    });
  }
}
