//

import 'package:flutter/material.dart';

class ColorTextField extends StatelessWidget {
  const ColorTextField({
    super.key,
    this.controller,
    required this.onChanged,
  });
  final Function(String value) onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    );
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        // border: ,
        isDense: true,
        errorBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border,
        disabledBorder: border,
        enabledBorder: border,
      ),
      onChanged: onChanged,
    );
  }
}
