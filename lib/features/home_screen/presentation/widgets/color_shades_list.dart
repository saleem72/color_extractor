//

import 'package:color_extractor/features/home_screen/domain/models/color_rgb_structure.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:color_extractor/features/home_screen/presentation/widgets/rgb_color_tile.dart';
import 'package:flutter/material.dart';

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
    final degrees = colorDegrees.reversed.toList();
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
