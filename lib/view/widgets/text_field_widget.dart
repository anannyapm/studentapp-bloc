import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController textController;
  final TextInputType typeValue;
  final int length = 2;

  const TextFieldWidget(
      {super.key,
      required this.hint,
      required this.label,
      required this.textController,
      this.typeValue = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: typeValue,
      maxLength: typeValue == TextInputType.number ? length : null,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
              )),
          hintText: hint,
          labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().isEmpty) {
          return '$label cannot be Empty!';
        } else {
          if (typeValue == TextInputType.text ||
              typeValue == TextInputType.name) {
            if (!RegExp(r'^\S$|^\S[ \S]*\S$').hasMatch(value.trim())) {
              return 'Please enter a valid word!';
            } else {
              return null;
            }
          } else if (typeValue == TextInputType.number) {
            if (int.tryParse(value) == null) {
              return 'Please enter a valid age!';
            } else {
              return null;
            }
          } else {
            return null;
          }
        }
      },
    );
  }
}
