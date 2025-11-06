import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardNumberField extends StatefulWidget {
  const CardNumberField({super.key});

  @override
  State<CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<CardNumberField> {
  bool _enterFull = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text("Enter full card number"),
          value: _enterFull,
          onChanged: (value) {
            setState(() {
              _enterFull = value;
              _controller.clear();
            });
          },
        ),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          maxLength: _enterFull ? 16 : 4,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: "Card Number",
            prefixText: _enterFull ? "" : "XXXX XXXX XXXX ",
            hintText: _enterFull ? "Enter 16-digit number" : "1234",
            counterText: "",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
