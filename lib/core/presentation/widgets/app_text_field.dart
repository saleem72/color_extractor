//

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.hint,
    this.onChanged,
    this.backgroundColor = const Color(0xFFF6F6F6),
    this.isDense = false,
    this.borderRadius = 12,
    this.style,
    this.hintStyle,
  });
  final String hint;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Color backgroundColor;
  final bool isDense;
  final double borderRadius;
  final TextStyle? style;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        style: style ??
            context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
            ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle ??
              context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.onPrimaryContainer.withOpacity(0.6),
              ),
          isDense: isDense,
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
