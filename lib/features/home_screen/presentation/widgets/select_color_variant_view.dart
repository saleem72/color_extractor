//

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:color_extractor/core/presentation/widgets/app_text_field.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_variant.dart';
import 'package:flutter/material.dart';

class SelectColorVariantView extends StatefulWidget {
  const SelectColorVariantView({
    super.key,
    required this.onSelection,
  });
  final Function(ColorVariant variant) onSelection;
  @override
  State<SelectColorVariantView> createState() => _SelectColorVariantViewState();
}

class _SelectColorVariantViewState extends State<SelectColorVariantView> {
  ColorType type = ColorType.values.first;
  ColorShade shade = ColorShade.values.first;
  ColorType onType = ColorType.values.first;
  ColorShade onShade = ColorShade.values.first;
  final TextEditingController _color = TextEditingController();
  final TextEditingController _onColor = TextEditingController();

  @override
  void dispose() {
    _color.dispose();
    _onColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              'Color:',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ColorType>(
                  value: type,
                  style: context.textTheme.bodyMedium,
                  items: ColorType.values
                      .map<DropdownMenuItem<ColorType>>((e) => DropdownMenuItem(
                            key: ValueKey(e),
                            value: e,
                            child: Text(e.name.capitalize()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      type = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Shade:',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ColorShade>(
                  value: shade,
                  style: context.textTheme.bodyMedium,
                  items: ColorShade.values
                      .map<DropdownMenuItem<ColorShade>>(
                          (e) => DropdownMenuItem(
                                key: ValueKey(e),
                                value: e,
                                child: Text(e.name.capitalize()),
                              ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    if (value == null) {
                      return;
                    }
                    shade = value;
                  }),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Hex value:',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                controller: _color,
                hint: 'Hex',
                isDense: true,
                borderRadius: 6,
                style: context.textTheme.bodyMedium,
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'on Color:',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ColorType>(
                  value: onType,
                  style: context.textTheme.bodyMedium,
                  items: ColorType.values
                      .map<DropdownMenuItem<ColorType>>((e) => DropdownMenuItem(
                            key: ValueKey(e),
                            value: e,
                            child: Text(e.name.capitalize()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      onType = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'on Shade:',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ColorShade>(
                  value: onShade,
                  style: context.textTheme.bodyMedium,
                  items: ColorShade.values
                      .map<DropdownMenuItem<ColorShade>>(
                          (e) => DropdownMenuItem(
                                key: ValueKey(e),
                                value: e,
                                child: Text(e.name.capitalize()),
                              ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    if (value == null) {
                      return;
                    }
                    onShade = value;
                  }),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Hex value:',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                controller: _onColor,
                hint: 'Hex',
                isDense: true,
                borderRadius: 6,
                style: context.textTheme.bodyMedium,
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            FilledButton(
              onPressed: () {
                widget.onSelection(ColorVariant(
                  type: type,
                  shade: shade,
                  color: _color.text.trim().isEmpty ? null : _color.text.trim(),
                  onType: onType,
                  onShade: onShade,
                  onColor: _onColor.text.trim().isEmpty
                      ? null
                      : _onColor.text.trim(),
                ));
                context.navigator.pop();
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                context.navigator.pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
