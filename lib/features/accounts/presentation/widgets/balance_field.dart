// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class BalanceField extends StatelessWidget {
//   final TextEditingController balanceController;

//   const BalanceField({super.key, required this.balanceController});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: balanceController,
//       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
//         _MaxDigitsExcludingDecimalFormatter(9),
//       ],
//       decoration: const InputDecoration(counterText: "", hintText: "Balance"),
//     );
//   }
// }

// class _MaxDigitsExcludingDecimalFormatter extends TextInputFormatter {
//   final int maxDigits;

//   _MaxDigitsExcludingDecimalFormatter(this.maxDigits);

//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     final text = newValue.text;

//     if ('.'.allMatches(text).length > 1) {
//       return oldValue;
//     }

//     final digitCount = text.replaceAll('.', '').length;

//     if (digitCount > maxDigits) {
//       return oldValue;
//     }

//     return newValue;
//   }
// }
