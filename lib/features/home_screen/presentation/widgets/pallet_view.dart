//

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/core/presentation/widgets/failure_view.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_scheme_holder.dart';
import 'package:color_extractor/features/home_screen/domain/models/pallet_status.dart';
import 'package:color_extractor/features/home_screen/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:color_extractor/features/home_screen/presentation/widgets/color_scheme_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pallet_row_view.dart';

class PalletView extends StatelessWidget {
  const PalletView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            _buildWidget(context, state),
            _showMessage(context, state.showClipMessage),
          ],
        );
      },
    );
  }

  Widget _showMessage(BuildContext context, bool showMessage) {
    return showMessage
        ? Container(
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.colorScheme.onPrimaryContainer,
                      )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Copied',
                            style: context.textTheme.displaySmall?.copyWith(
                              color: context.colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Theme was copied successfully',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.colorScheme.onErrorContainer,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => context
                            .read<HomeBloc>()
                            .add(HomeHideClipMessageEvent()),
                        style: TextButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: context.colorScheme.onPrimary,
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
          )
        : const SizedBox.shrink();
  }

  Widget _buildWidget(BuildContext context, HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildHeader(context),
          state.status == PalletStatus.display
              ? _buildDisplayMode(state)
              : _buildPreviewMode(context, state),
          FailureView(
            failure: state.failure,
            onClearError: () =>
                context.read<HomeBloc>().add(HomeClearErrorEvent()),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewMode(BuildContext context, HomeState state) {
    return Expanded(
      child: Container(
        color: const Color(0xFFE5E5E5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 430 / 932,
                  child: SchemePreviewWidget(
                    scheme: state.lightColorScheme,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 430 / 932,
                  child: SchemePreviewWidget(
                    scheme: state.darkColorScheme,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayMode(HomeState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const PalletRowView(),
            const SizedBox(height: 16),
            ColorSchemeView(scheme: state.lightColorScheme),
            const SizedBox(height: 16),
            ColorSchemeView(scheme: state.darkColorScheme),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  SizedBox _buildHeader(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () =>
                context.read<HomeBloc>().add(HomeToggleStatusEvent()),
            icon: Icon(
              Icons.preview,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          IconButton(
            onPressed: () =>
                context.read<HomeBloc>().add(HomeCopyPalletToClipboardEvent()),
            icon: Icon(
              Icons.copy,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class SchemePreviewWidget extends StatelessWidget {
  const SchemePreviewWidget({
    super.key,
    required this.scheme,
  });
  final ColorSchemeHolder scheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: scheme.scaffoldBackground,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 60,
                width: double.maxFinite,
                color: scheme.appBar,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Home',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: scheme.onAppBar,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  color: scheme.background,
                  shadowColor: scheme.shadow,
                  elevation: 4,
                  child: const SizedBox(
                    height: 100,
                    width: double.maxFinite,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                ),
                child: const Text(
                  'OK',
                  // style: context.textTheme.bodyLarge?.copyWith(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Hello world',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: scheme.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: scheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Can be',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: scheme.tertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Can be',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: scheme.onTertiary,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: scheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
