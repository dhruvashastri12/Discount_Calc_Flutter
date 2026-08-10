import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscountCalculatorScreen extends StatefulWidget {
  const DiscountCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<DiscountCalculatorScreen> createState() => _DiscountCalculatorScreenState();
}

class _DiscountCalculatorScreenState extends State<DiscountCalculatorScreen> {
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  bool isEditingOriginal = true;
  bool isPercentage = true; // radio selection
  String displayValue = '';
  double discount = 0.0, finalPrice = 0.0, savedAmount = 0.0;

  // final Color accentText = const Color(0xFF544A7D);
  // static const Color accentBg = Color(0xFFCFD468);

  // final Color accentText = const Color(0xFF394C47);
  // static const Color accentBg = Color(0xFFFACCBE);

  final Color accentText = const Color(0xFFFFE8C6);
  static const Color accentBg = Color(0xFF0F6C7A);

  bool _showBanner = true;

  // Play Store URL
  final Uri _playStoreUrl = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.ds12.smartdiscountcalculator',
  );

  // Function to open the URL in Play Store / Browser
  Future<void> _openPlayStore() async {
    if (!await launchUrl(_playStoreUrl, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $_playStoreUrl');
    }
  }

  void _calculate() {
    final originalPrice = double.tryParse(originalPriceController.text) ?? 0.0;
    final discountValue = double.tryParse(discountController.text) ?? 0.0;

    if (originalPrice <= 0 || discountValue < 0) {
      savedAmount = 0;
      finalPrice = originalPrice;
      setState(() {});
      return;
    }

    if (isPercentage) {
      savedAmount = (originalPrice * discountValue) / 100;
    } else {
      savedAmount = discountValue.clamp(0, originalPrice);
    }
    finalPrice = originalPrice - savedAmount;
    setState(() {});
  }

  void _onKeyTap(String value) {
    setState(() {
      if (value == 'AC') {
        displayValue = '';
        originalPriceController.clear();
        discountController.clear();
        savedAmount = 0;
        finalPrice = 0;
        FocusScope.of(context).unfocus();
        isEditingOriginal = true;
        return;
      }
      if (value == 'Cancel') {
        if (displayValue.isNotEmpty) displayValue = displayValue.substring(0, displayValue.length - 1);
      } else if (RegExp(r'^\d$').hasMatch(value)) {
        displayValue += value;
      }

      final controller = isEditingOriginal ? originalPriceController : discountController;
      controller.text = displayValue;
      _calculate();
    });
  }

  Widget _buildKey(String label, {Color? bg, Color? fg}) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: () => _onKeyTap(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: bg ?? Colors.white,
          foregroundColor: fg ?? Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    ),
  );

  Widget _numPadRow(List<String> keys) =>
      Row(children: keys.map((k) => _buildKey(k, bg: (k == 'AC' || k == 'Cancel') ? accentBg : null, fg: (k == 'AC' || k == 'Cancel') ? accentText : null)).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Discount Calculator"), titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), backgroundColor: accentBg),
      body: Column(
        children: [
          // Sticky Banner Notification
          if (_showBanner)
            Container(
              width: double.infinity,
              color: Colors.amber.shade900,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.white),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'App Notice',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _showBanner = false),
                        child: const Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Hey, this app might be unavailable soon! A new app with Expense Tracking, History Saving, and more is available.',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  
                  // Action Button to Open Link
                  ElevatedButton.icon(
                    onPressed: _openPlayStore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.amber.shade900,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text(
                      'Download New App',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

          // 2. Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // 🔹 Original Price
                  TextField(
                    controller: originalPriceController,
                    maxLength: 10,
                    decoration: const InputDecoration(labelText: "Original Price", border: OutlineInputBorder(), counterText: ""),
                    readOnly: true,
                    onTap: () => setState(() {
                      isEditingOriginal = true;
                      displayValue = originalPriceController.text;
                    }),
                  ),
                  const SizedBox(height: 8),
            
                  // 🔹 Flat / Percentage toggle — now recalculates on change
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio<bool>(
                            value: false,
                            groupValue: isPercentage,
                            onChanged: (v) {
                              setState(() {
                                isPercentage = v ?? true;
                              });
                              _calculate(); // ✅ Added recalculation here
                            },
                          ),
                          const Text("Flat"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: isPercentage,
                            onChanged: (v) {
                              setState(() {
                                isPercentage = v ?? true;
                              });
                              _calculate(); // ✅ Added recalculation here
                            },
                          ),
                          const Text("Percentage"),
                        ],
                      ),
                    ],
                  ),
            
                  // 🔹 Discount input
                  TextField(
                    controller: discountController,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: isPercentage ? "Discount (%)" : "Discount (₹)",
                      border: const OutlineInputBorder(),
                      counterText: "",
                    ),
                    readOnly: true,
                    onTap: () => setState(() {
                      isEditingOriginal = false;
                      displayValue = discountController.text;
                    }),
                  ),
                  const SizedBox(height: 8),
            
                  // 🔹 Discount quick buttons (work for both Flat and Percentage)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [5, 10, 25, 50, 75].map((e) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentBg,
                              foregroundColor: accentText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              setState(() {
                                discountController.text = e.toString();
                                displayValue = e.toString();
                              });
                              _calculate(); // ✅ Always recalculate for both Flat and Percentage
                            },
                            child: Text(
                              "$e",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
            
                  const SizedBox(height: 12),
            
                  // 🔹 Result card
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 6,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          child: Center(
                            child: Text("You Save: ₹${savedAmount.toStringAsFixed(2)}",
                                style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: accentBg,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          child: Center(
                            child: Text("Payable Amount: ₹${finalPrice.toStringAsFixed(2)}",
                                style: TextStyle(color: accentText, fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
            
                  // 🔹 Keypad
                  Column(
                    children: [
                      _numPadRow(['1', '2', '3']),
                      _numPadRow(['4', '5', '6']),
                      _numPadRow(['7', '8', '9']),
                      _numPadRow(['Cancel', '0', 'AC']),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
