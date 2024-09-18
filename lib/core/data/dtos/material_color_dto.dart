// To parse this JSON data, do
//
//     final materialColorDto = materialColorDtoFromJson(jsonString);

import 'dart:convert';

import 'package:color_extractor/core/domain/models/app_color.dart';

List<MaterialColorDto> materialColorDtoFromJson(String str) =>
    List<MaterialColorDto>.from(
        json.decode(str).map((x) => MaterialColorDto.fromJson(x)));

String materialColorDtoToJson(List<MaterialColorDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialColorDto {
  String hex;
  String rgb;
  String token;

  MaterialColorDto({
    required this.hex,
    required this.rgb,
    required this.token,
  });

  factory MaterialColorDto.fromJson(Map<String, dynamic> json) =>
      MaterialColorDto(
        hex: json["hex"],
        rgb: json["rgb"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "hex": hex,
        "rgb": rgb,
        "token": token,
      };

  AppColor toModel() => AppColor(
        hex: hex.replaceAll('#', '0xFF'),
        rgb: rgb,
        token: token,
        value: int.parse(token.split('-').last),
      );
}
