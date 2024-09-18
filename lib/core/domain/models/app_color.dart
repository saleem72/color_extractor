//

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppColor extends Equatable {
  final String hex;
  final String rgb;
  final String token;
  final int value;

  const AppColor({
    required this.hex,
    required this.rgb,
    required this.token,
    required this.value,
  });

  @override
  List<Object?> get props => [hex];

  Color get color => Color(int.parse(hex));

  String colorSyntax(String title) =>
      'static const Color $title$value = Color($hex);';
}
