//

import 'package:flutter/material.dart';
import 'package:my_core/my_core.dart';

import 'dropdown_text.dart';

class DropdownTextWithLabel extends StatelessWidget {
  const DropdownTextWithLabel({
    super.key,
    required this.onSelection,
    required this.label,
    required this.hint,
    required this.options,
  });
  final String label;
  final String hint;
  final List<String> options;
  final Function(String) onSelection;

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
        DropdownText(
          hint: hint,
          onSelection: onSelection,
          options: options,
        ),
      ],
    );
  }
}
