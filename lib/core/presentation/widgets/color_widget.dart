//

import 'dart:developer';

import 'package:color_extractor/core/domain/models/material_color_source.dart';
import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:color_extractor/core/presentation/widgets/app_text_field.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'color_shades_view.dart';
import 'pallet_color_view.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({
    super.key,
    required this.color,
    required this.type,
    required this.onColorChange,
    this.controller,
  });
  final MaterialColor color;
  final ColorType type;
  final Function(MaterialColorSource) onColorChange;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            type.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Utils.pickColor(
                  //   context,
                  //   initialColor: color,
                  //   onColorChanged: (color) =>
                  //       onColorChange(color.toMaterialColor()),
                  // );
                  _showDialog(context, initialColor: color.shade500);
                },
                child: PalletColorView(
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ColorShadesView(
            color: color,
            label: type.title,
          )
        ],
      ),
    );
  }

  _showDialog(BuildContext context, {required Color initialColor}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(16),
          content: MaterialColorSelector(
            onSelection: onColorChange,
            initialColor: initialColor,
          ),
        );
      },
    );
  }

  void changeColor(Color value) {
    log('Color: ${value.value.toRadixString(16).toUpperCase()}');
  }
}

class MaterialColorSelector extends StatefulWidget {
  const MaterialColorSelector({
    super.key,
    required this.onSelection,
    required this.initialColor,
  });
  final Color initialColor;
  final Function(MaterialColorSource source) onSelection;

  @override
  State<MaterialColorSelector> createState() => _MaterialColorSelectorState();
}

class _MaterialColorSelectorState extends State<MaterialColorSelector> {
  final TextEditingController _hex = TextEditingController();
  late TextEditingController _pickerHex;
  final TextEditingController _json = TextEditingController();
  late Color initialColor;

  @override
  void initState() {
    super.initState();
    initialColor = widget.initialColor;
    _pickerHex = TextEditingController(
        text: widget.initialColor.value.toRadixString(16));
  }

  @override
  void dispose() {
    _hex.dispose();
    _json.dispose();
    _pickerHex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColorPicker(
          pickerColor: initialColor,
          onColorChanged: onColorChanged,
          colorPickerWidth: 300,
          pickerAreaHeightPercent: 0.7,
          // pickerAreaBorderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(22),
          //   topRight: Radius.circular(22),
          // ),
          labelTypes: const [],
          portraitOnly: true,
          // hexInputBar: true,
          hexInputController: _pickerHex,
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
                controller: _hex,
                hint: 'Hex',
                isDense: true,
                borderRadius: 6,
                style: context.textTheme.bodyMedium,
                onChanged: (value) {
                  setState(() {
                    initialColor = value.toColor() ?? Colors.grey;
                    _pickerHex.text = value;
                  });
                },
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              'From json:',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                controller: _json,
                hint: 'json',
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
        const SizedBox(height: 8),
        Row(
          children: [
            FilledButton(
              onPressed: () {
                _prepareData();
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
      ],
    );
  }

  _prepareData() {
    final hex = _hex.text.trim();
    final json = _json.text.trim();
    if (hex.isEmpty && json.isEmpty) {
      return;
    }

    MaterialColorSourceType type;
    String value;
    if (hex.isNotEmpty) {
      type = MaterialColorSourceType.hex;
      value = hex;
    } else {
      type = MaterialColorSourceType.json;
      value = json;
    }
    widget.onSelection(MaterialColorSource(
      type: type,
      value: value,
    ));
  }

  void onColorChanged(Color value) {
    setState(() {
      initialColor = value;
      _hex.text = value.hex;
    });
  }
}
