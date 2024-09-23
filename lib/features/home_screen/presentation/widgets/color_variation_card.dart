//

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/core/extensions/color_to_material/golden_palettes_definition.dart';
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
                AppPopupMenu(rgbColor: variation.primary.color),
              ],
            ),
            const SizedBox(height: 8),
            ColorShadesList(color: variation.primary),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'COMPLEMENTARY',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppPopupMenu(rgbColor: variation.complementary.color),
              ],
            ),
            const SizedBox(height: 8),
            ColorShadesList(color: variation.complementary),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Analogous',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'First',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppPopupMenu(rgbColor: variation.analogous1.color),
              ],
            ),
            ColorShadesList(color: variation.analogous1),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Second',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppPopupMenu(rgbColor: variation.analogous2.color),
              ],
            ),
            ColorShadesList(color: variation.analogous2),
            const SizedBox(height: 16),
            Text(
              'Triadic',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'First',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppPopupMenu(rgbColor: variation.triadic1.color),
              ],
            ),
            ColorShadesList(
              color: variation.triadic1,
              showValues: false,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'First',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppPopupMenu(rgbColor: variation.triadic2.color),
              ],
            ),
            ColorShadesList(color: variation.triadic2),
          ],
        ),
      ),
    );
  }
}
