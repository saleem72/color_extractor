//

import 'package:color_extractor/core/configuration/constants.dart';
import 'package:color_extractor/core/data/utils.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_scheme_holder.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_variant.dart';
import 'package:color_extractor/features/home_screen/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'scheme_color_tile_container.dart';

class ColorSchemeView extends StatelessWidget {
  const ColorSchemeView({
    super.key,
    required this.scheme,
  });
  final ColorSchemeHolder scheme;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.pickColor(
        context,
        initialColor: scheme.scaffoldBackground,
        onColorChanged: (color) =>
            context.read<HomeBloc>().add(HomeScaffoldColorChangedEvent(
                  value: color,
                  brightness: scheme.brightness,
                )),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.scaffoldBackground,
          borderRadius: AppConstants.borderRadius,
        ),
        child: Column(
          children: [
            _mainColors(context),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'background',
                    color: scheme.background,
                    onColor: scheme.onBackground,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeBackgroundChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'Surface',
                    color: scheme.surface,
                    onColor: scheme.onSurface,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeSurfaceChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'surfaceVariant',
                    color: scheme.surfaceVariant,
                    onColor: scheme.onSurfaceVariant,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeSurfaceVariantChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'outline',
                    color: scheme.outline,
                    onColor: scheme.onSurface,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeOutLineChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'outlineVariant',
                    color: scheme.outlineVariant,
                    onColor: scheme.onPrimary,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeOutLineVariantChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'inversePrimary',
                    color: scheme.inversePrimary,
                    onColor: scheme.onPrimary,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeInversePrimaryChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'inverseSurface',
                    color: scheme.inverseSurface,
                    onColor: scheme.onPrimary,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeInverseSurfaceChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'App Bar',
                    color: scheme.appBar,
                    onColor: scheme.onAppBar,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeAppBarChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SchemeColorTileContainer(
                    label: 'Shadows',
                    color: scheme.shadow,
                    onColor: scheme.background,
                    onColorChange: (variant) => context.read<HomeBloc>().add(
                        HomeShadowChangedEvent(
                            brightness: scheme.brightness, variant: variant)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainColors(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SchemeColorTile(
            label: ColorType.primary.title,
            mainColor: scheme.primary,
            onMainColor: scheme.onPrimary,
            containerColor: scheme.primaryContainer,
            onContainerColor: scheme.onPrimaryContainer,
            onMainColorChange: (variant) => context.read<HomeBloc>().add(
                HomePrimaryChangedEvent(
                    brightness: scheme.brightness, variant: variant)),
            onMainContainerChange: (variant) => context.read<HomeBloc>().add(
                HomePrimaryContainerChangedEvent(
                    brightness: scheme.brightness, variant: variant)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SchemeColorTile(
            label: ColorType.secondary.title,
            mainColor: scheme.secondary,
            onMainColor: scheme.onSecondary,
            containerColor: scheme.secondaryContainer,
            onContainerColor: scheme.onSecondaryContainer,
            onMainColorChange: (variant) => context.read<HomeBloc>().add(
                HomeSecondaryChangedEvent(
                    brightness: scheme.brightness, variant: variant)),
            onMainContainerChange: (variant) => context.read<HomeBloc>().add(
                HomeSecondaryContainerChangedEvent(
                    brightness: scheme.brightness, variant: variant)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SchemeColorTile(
            label: ColorType.tertiary.title,
            mainColor: scheme.tertiary,
            onMainColor: scheme.onTertiary,
            containerColor: scheme.tertiaryContainer,
            onContainerColor: scheme.onTertiaryContainer,
            onMainColorChange: (variant) => context.read<HomeBloc>().add(
                HomeTertiaryChangedEvent(
                    brightness: scheme.brightness, variant: variant)),
            onMainContainerChange: (variant) => context.read<HomeBloc>().add(
                HomeTertiaryContainerChangedEvent(
                    brightness: scheme.brightness, variant: variant)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SchemeColorTile(
            label: ColorType.error.title,
            mainColor: scheme.error,
            onMainColor: scheme.onError,
            containerColor: scheme.errorContainer,
            onContainerColor: scheme.onErrorContainer,
            onMainColorChange: (variant) => context.read<HomeBloc>().add(
                HomeErrorChangedEvent(
                    brightness: scheme.brightness, variant: variant)),
            onMainContainerChange: (variant) => context.read<HomeBloc>().add(
                HomeErrorContainerChangedEvent(
                    brightness: scheme.brightness, variant: variant)),
          ),
        ),
      ],
    );
  }
}

class SchemeColorTile extends StatelessWidget {
  const SchemeColorTile({
    super.key,
    required this.label,
    required this.mainColor,
    required this.onMainColor,
    required this.containerColor,
    required this.onContainerColor,
    required this.onMainColorChange,
    required this.onMainContainerChange,
  });
  final String label;
  final Color mainColor;
  final Color onMainColor;
  final Color containerColor;
  final Color onContainerColor;
  final Function(ColorVariant variant) onMainColorChange;
  final Function(ColorVariant variant) onMainContainerChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SchemeColorTileContainer(
            label: 'on $label',
            color: mainColor,
            onColor: onMainColor,
            onColorChange: onMainColorChange,
          ),
          const SizedBox(height: 8),
          SchemeColorTileContainer(
            label: 'on $label Container',
            color: containerColor,
            onColor: onContainerColor,
            onColorChange: onMainContainerChange,
          ),
        ],
      ),
    );
  }
}
