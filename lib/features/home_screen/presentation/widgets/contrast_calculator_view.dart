//

import 'dart:developer';

import 'package:color_extractor/core/domain/models/contrast_level.dart';
import 'package:color_extractor/core/extensions/color_to_material/color_extension.dart';

import 'package:flutter/material.dart';
import 'package:my_core/my_core.dart';

class ContrastCalculatorView extends StatefulWidget {
  const ContrastCalculatorView({super.key});

  @override
  State<ContrastCalculatorView> createState() => _ContrastCalculatorViewState();
}

class _ContrastCalculatorViewState extends State<ContrastCalculatorView> {
  final TextEditingController _foregroundColor = TextEditingController();
  final TextEditingController _backgroundColor = TextEditingController();
  String contrastRatio = '';
  String error = '';
  ContrastLevel? contrastLevel;

  @override
  void dispose() {
    _foregroundColor.dispose();
    _backgroundColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
      ),
      child: Column(
        children: [
          Text(
            'Check contrast',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
            controller: _foregroundColor,
            decoration: InputDecoration(
              labelText: 'Foreground',
              labelStyle: context.textTheme.bodySmall?.copyWith(
                height: 0.6,
              ),
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(color: Colors.teal),
              // ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _backgroundColor,
            decoration: InputDecoration(
              labelText: 'Background',
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(color: Colors.teal),
              // ),
              labelStyle: context.textTheme.bodySmall?.copyWith(
                height: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _calcContrast,
            child: const Text('Contrast'),
          ),
          const SizedBox(height: 16),
          contrastRatio.isNotEmpty
              ? Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: contrastLevel?.color ?? Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        contrastRatio,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: contrastLevel?.onColor ?? Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        contrastLevel?.label ?? '',
                        style: context.textTheme.titleLarge?.copyWith(
                          // fontWeight: FontWeight.bold,
                          color: contrastLevel?.onColor ?? Colors.black,
                        ),
                      )
                    ],
                  ))
              : const SizedBox.shrink(),
          error.isNotEmpty ? Text('🔥 error: $error') : const SizedBox.shrink(),
        ],
      ),
    );
  }

  void _calcContrast() {
    try {
      final foregroundColor = _foregroundColor.text.trim().toColor();
      final backgroundColor = _backgroundColor.text.trim().toColor();
      final ratio = foregroundColor.contrastRatio(backgroundColor);
      setState(() {
        contrastRatio = ratio.toStringAsFixed(2);
        contrastLevel = ContrastLevel.fromValue(ratio);
        error = '';
      });
    } catch (e) {
      log("🔥 error:", name: 'contrast', error: e);
      setState(() {
        error = e.toString();
        contrastLevel = null;
        contrastRatio = '';
      });
    }
  }
}
