//

import 'package:collection/collection.dart';
import 'package:color_extractor/core/data/dtos/material_color_dto.dart';
import 'package:color_extractor/core/domain/models/app_color.dart';
import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:color_extractor/core/extensions/color_to_material/color_extension.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:dartz/dartz.dart';
import 'package:my_core/my_core.dart';

class HomeRepository {
  Either<Failure, List<AppColor>> decodeJson(String json) {
    try {
      final materialColorDto = materialColorDtoFromJson(json);
      final colors = materialColorDto.map((e) => e.toModel()).toList();
      return right(colors);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  Either<Failure, List<AppColor>> decodeHex(String hex) {
    try {
      final color = hex.toColor().toMaterialColor();
      final shades = color.shades;

      final colors = shades.asMap().map((index, e) => MapEntry(
          colorDegrees[index], AppColor.fromColor(e, colorDegrees[index])));
      return right(colors.values.toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  List<String> toMaterialColor(List<AppColor> colors, String title) {
    final lines = <String>[];
    lines.add('static const MaterialColor $title = MaterialColor(');
    lines.add('${colors.colorForValue(500).hex.toString()},');
    lines.add('{');
    lines.add(colors.colorStringForValue(50));
    lines.add(colors.colorStringForValue(100));
    lines.add(colors.colorStringForValue(200));
    lines.add(colors.colorStringForValue(300));
    lines.add(colors.colorStringForValue(400));
    lines.add(colors.colorStringForValue(500));
    lines.add(colors.colorStringForValue(600));
    lines.add(colors.colorStringForValue(700));
    lines.add(colors.colorStringForValue(800));
    lines.add(colors.colorStringForValue(900));
    lines.add('},');
    lines.add(');');

    return lines;
  }

  List<String> toListOfColors(List<AppColor> colors, String title) {
    final lines = <String>[];

    for (var color in colors) {
      lines.add(color.colorSyntax(title));
    }

    return lines;
  }
}

extension AppColorsArray on List<AppColor> {
  AppColor colorForValue(int value) {
    final color = firstWhereOrNull((element) => element.value == value);
    return color ??
        AppColor(
          hex: '0xFFFFFFFF',
          rgb: 'rgb(255, 255, 255)',
          token: value.toString(),
          value: value,
        );
  }

  String colorStringForValue(int value) {
    final color = firstWhereOrNull((element) => element.value == value) ??
        AppColor(
          hex: '0xFF$value',
          rgb: 'rgb(255, 255, 255)',
          token: value.toString(),
          value: value,
        );
    return '$value: Color(${color.hex}),';
  }

  String hexForValue(int value) {
    final color = firstWhereOrNull((element) => element.value == value) ??
        AppColor(
          hex: '0xFF$value',
          rgb: 'rgb(255, 255, 255)',
          token: value.toString(),
          value: value,
        );
    return color.hex.replaceAll('0xFF', '');
  }
}
