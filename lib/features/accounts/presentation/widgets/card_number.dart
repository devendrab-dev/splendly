import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardNumberField extends StatefulWidget {
  const CardNumberField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<CardNumberField> {
  bool _enterFull = false;
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
              widget.controller.clear();
            });
          },
        ),
        TextFormField(
          controller: widget.controller,
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
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "This field is required";
            }
            if (_enterFull && value.length != 16) {
              return "Must be exactly 16 digits";
            } else if (!_enterFull && value.length != 4) {
              return "Must be exactly 4 digits";
            }
            return null;
          },
        ),
      ],
    );
  }
}
