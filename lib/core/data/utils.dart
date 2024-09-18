//

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Utils {
  Utils._internal();

  static pickColor(
    BuildContext context, {
    required Color initialColor,
    required Function(Color color) onColorChanged,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: ColorPicker(
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
              hexInputBar: true,
            ),
          ),
        );
      },
    );
  }
}
