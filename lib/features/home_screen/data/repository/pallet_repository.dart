//

import 'package:color_extractor/core/data/dtos/material_color_dto.dart';
import 'package:color_extractor/core/domain/models/material_color_source.dart';
import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:color_extractor/core/extensions/color_to_material/color_extension.dart';
import 'package:color_extractor/features/home_screen/data/repository/home_repository.dart';
import 'package:flutter/material.dart';

class PalletRepository {
  MaterialColor? colorFromSource(MaterialColorSource source) {
    if (source.type == MaterialColorSourceType.hex) {
      return source.value.toColorLocal().toMaterialColor();
    }

    try {
      final materialColorDto = materialColorDtoFromJson(source.value);
      final colors = materialColorDto.map((e) => e.toModel()).toList();
      final color50 = colors.hexForValue(50);
      final color100 = colors.hexForValue(100);
      final color200 = colors.hexForValue(200);
      final color300 = colors.hexForValue(300);
      final color400 = colors.hexForValue(400);
      final color500 = colors.hexForValue(500);
      final color600 = colors.hexForValue(600);
      final color700 = colors.hexForValue(700);
      final color800 = colors.hexForValue(800);
      final color900 = colors.hexForValue(900);

      return MaterialColor(color500.toColorLocal().value, {
        50: color50.toColorLocal(),
        100: color100.toColorLocal(),
        200: color200.toColorLocal(),
        300: color300.toColorLocal(),
        400: color400.toColorLocal(),
        500: color500.toColorLocal(),
        600: color600.toColorLocal(),
        700: color700.toColorLocal(),
        800: color800.toColorLocal(),
        900: color900.toColorLocal(),
      });
    } catch (error) {
      return null;
    }
  }

  Future<bool> writeFile(String content) async {
    return false;
    // try {
    //   final directory = await getDownloadDirectory();

    //   final download = directory.path;
    //   log('Downloads: $download');
    //   final file = File('$download/theming.dart');
    //   await file.writeAsString(content);
    //   return true;
    // } catch (e) {
    //   log('Error', name: 'PalletRepository', error: e);
    //   return false;
    // }
  }
}
