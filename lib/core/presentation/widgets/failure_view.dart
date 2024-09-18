//

import 'package:color_extractor/core/domain/errors/failure.dart';
import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class FailureView extends StatelessWidget {
  const FailureView({
    super.key,
    required this.failure,
    required this.onClearError,
  });

  final Failure? failure;
  final Function() onClearError;

  @override
  Widget build(BuildContext context) {
    return failure == null ? const SizedBox.shrink() : _buildWidget(context);
  }

  Container _buildWidget(BuildContext context) {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        child: Material(
          elevation: 4,
          shadowColor: context.colorScheme.error,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: context.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.colorScheme.onErrorContainer,
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error',
                      style: context.textTheme.displaySmall?.copyWith(
                        color: context.colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  failure?.message ?? '',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => onClearError(),
                  style: TextButton.styleFrom(
                    backgroundColor: context.colorScheme.error,
                    foregroundColor: context.colorScheme.onError,
                  ),
                  child: Text(
                    'Ok',
                    style: context.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
