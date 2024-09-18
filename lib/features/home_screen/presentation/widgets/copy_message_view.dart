//

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home_bloc/home_bloc.dart';

class CopyMessageView extends StatelessWidget {
  const CopyMessageView({
    super.key,
    required this.show,
  });

  final bool show;

  @override
  Widget build(BuildContext context) {
    return show ? _buildWidget(context) : const SizedBox.shrink();
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
          shadowColor: context.colorScheme.primary.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.colorScheme.onPrimaryContainer,
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => context
                      .read<HomeBloc>()
                      .add(HomeCopyMaterialColorToClipboardEvent()),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(
                    'Copy Material color',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context
                      .read<HomeBloc>()
                      .add(HomeCopyListOfColorsToClipboardEvent()),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(
                    'Copy list of colors',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
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
