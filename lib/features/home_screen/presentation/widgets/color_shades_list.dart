//

import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:color_extractor/core/extensions/color_to_material/golden_palettes_definition.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:color_extractor/features/home_screen/presentation/widgets/rgb_color_tile.dart';
import 'package:flutter/material.dart';

class ColorShadesList extends StatelessWidget {
  const ColorShadesList({
    super.key,
    required this.color,
    this.showValues = true,
  });

  final MaterialColorWithIndex color;
  final bool showValues;

  @override
  Widget build(BuildContext context) {
    final degrees = colorDegrees.reversed.toList();
    final shades = color.color.shades.reversed.toList();
    return SizedBox(
      height: showValues ? 80 : 60,
      child: ListView.builder(
        itemCount: shades.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final rgbColor = shades[index];
          return RGBColorTile(
            isSelected: index == (9 - color.index),
            color: rgbColor,
            hex: rgbColor.hex,
            label: degrees[index].toString(),
            showValues: showValues,
          );
        },
      ),
    );
  }
}
