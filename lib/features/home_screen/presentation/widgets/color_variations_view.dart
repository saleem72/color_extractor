//
import 'package:color_extractor/features/home_screen/domain/models/color_decode_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_core/views/failure_view.dart';

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/features/home_screen/data/helpers/string_to_color.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_rgb_structure.dart';
import 'package:color_extractor/features/home_screen/presentation/blocs/color_variations_bloc/color_variations_bloc.dart';

import 'rgb_color_tile.dart';

class ColorVariationsView extends StatelessWidget {
  const ColorVariationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorVariationsBloc(
        converter: StringToColor(),
      ),
      child: const ColorVariationsWidget(),
    );
  }
}

class ColorVariationsWidget extends StatelessWidget {
  const ColorVariationsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorVariationsBloc, ColorVariationsState>(
      builder: (context, state) {
        return Stack(
          children: [
            _buildContent(context, state),
            FailureView(
              failure: state.failure,
              onClose: () => context
                  .read<ColorVariationsBloc>()
                  .add(ColorVariationsClearFailureEvent()),
            )
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ColorVariationsState state) {
    final bloc = context.read<ColorVariationsBloc>();
    final variation = state.variation;
    return Row(
      children: [
        Expanded(
          child: variation == null
              ? const SizedBox.shrink()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      ColorVariationCard(variation: variation),
                    ],
                  ),
                ),
        ),
        SizedBox(
          width: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: bloc.hexInput,
                  onChanged: (value) => context
                      .read<ColorVariationsBloc>()
                      .add(ColorVariationsHexHasChangedEvent(value: value)),
                  decoration: InputDecoration(
                    hintText: 'enter you color as hex number',
                    hintStyle: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context
                    .read<ColorVariationsBloc>()
                    .add(ColorVariationsDecodeColorEvent()),
                child: const Text('Decode'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColorVariationCard extends StatelessWidget {
  const ColorVariationCard({
    super.key,
    required this.variation,
  });

  final ColorDecodeResult variation;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color palettes',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'PRIMARY',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ColorShadesList(shades: variation.primary.shades.reversed.toList()),
            const SizedBox(height: 16),
            Text(
              'COMPLEMENTARY',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ColorShadesList(
                shades: variation.complementary.shades.reversed.toList()),
            const SizedBox(height: 16),
            Text(
              'Analogous',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ColorShadesList(
              shades: variation.analogous1.shades.reversed.toList(),
              showValues: false,
            ),
            const SizedBox(height: 4),
            ColorShadesList(
                shades: variation.analogous2.shades.reversed.toList()),
            const SizedBox(height: 16),
            Text(
              'Triadic',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ColorShadesList(
              shades: variation.triadic1.shades.reversed.toList(),
              showValues: false,
            ),
            const SizedBox(height: 4),
            ColorShadesList(
                shades: variation.triadic2.shades.reversed.toList()),
          ],
        ),
      ),
    );
  }
}

class ColorShadesList extends StatelessWidget {
  const ColorShadesList({
    super.key,
    required this.shades,
    this.showValues = true,
  });

  final List<ColorRGBStructure> shades;
  final bool showValues;

  @override
  Widget build(BuildContext context) {
    final degrees =
        [50, 100, 200, 300, 400, 500, 600, 700, 800, 900].reversed.toList();
    return SizedBox(
      height: showValues ? 80 : 60,
      child: ListView.builder(
        itemCount: shades.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final rgbColor = shades[index];
          return RGBColorTile(
            isSelected: rgbColor.isSelected,
            color: rgbColor.color,
            hex: rgbColor.hex,
            label: degrees[index].toString(),
            showValues: showValues,
          );
        },
      ),
    );
  }
}
