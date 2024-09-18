//

import 'package:flutter/material.dart';
import 'package:my_core/my_core.dart';

import 'dropdown_text_field.dart';

class DropdownTextFieldWithLabel extends StatelessWidget {
  const DropdownTextFieldWithLabel({
    super.key,
    required this.onSelection,
    required this.controller,
    required this.label,
    required this.hint,
    required this.options,
    this.dropdownStyle,
    this.textfieldStyle,
  });
  final TextEditingController controller;
  final String label;
  final String hint;
  final List<String> options;
  final Function(String) onSelection;
  final TextStyle? dropdownStyle;
  final TextStyle? textfieldStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        DropdownTextField(
          controller: controller,
          hint: hint,
          onSelection: (value) => onSelection(value),
          options: options,
          textfieldStyle: textfieldStyle ??
              context.textTheme.bodySmall?.copyWith(
                fontSize: 12,
              ),
          dropdownStyle: dropdownStyle ??
              context.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
