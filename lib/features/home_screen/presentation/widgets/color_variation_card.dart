//

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_decode_result.dart';
import 'package:flutter/material.dart';

import 'app_popup_menu.dart';
import 'color_shades_list.dart';

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
            Row(
              children: [
                Text(
                  'PRIMARY',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppPopupMenu(rgbColor: variation.primary),
              ],
            ),
            const SizedBox(height: 8),
            ColorShadesList(shades: variation.primary.shades.reversed.toList()),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'COMPLEMENTARY',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppPopupMenu(rgbColor: variation.complementary),
              ],
            ),
            const SizedBox(height: 8),
            ColorShadesList(
                shades: variation.complementary.shades.reversed.toList()),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Analogous',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppPopupMenu(rgbColor: variation.analogous1),
              ],
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
