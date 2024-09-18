// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_decode_result.dart';
import 'package:dartz/dartz.dart';
import 'package:my_core/my_core.dart';

import 'package:color_extractor/features/home_screen/domain/models/color_hsl_structure.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_rgb_structure.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_rgb_with_name.dart';
import 'package:color_extractor/features/home_screen/domain/models/hsl_holder.dart';
import 'package:color_extractor/features/home_screen/domain/models/ze_result.dart';

import 'helpers.dart';
import 'numbers.dart';

class StringToColor {
  final V = math.pow(2, -16);

  Either<Failure, ColorDecodeResult> call(String value) {
    try {
      final rgb = rgbStructure(value);
      final mainColors = createVariation(rgb);
      return right(mainColors);
      // Gf(hsl);
    } catch (e) {
      return left(GeneralFailure(message: e.toString()));
    }
  }

  ColorHSLStructure hslStructure(ColorRGBStructure a) {
    double value = math.max(math.max(a.red, a.green), a.blue);
    double c = math.min(math.min(a.red, a.green), a.blue);
    double hue = 0;
    double saturation = 0;
    if (value - c > V) {
      saturation = (value - c) / value;
      if (value == a.red) {
        hue = 60 * (a.green - a.blue) / (value - c);
      } else if (value == a.green) {
        hue = 60 * (a.blue - a.red) / (value - c) + 120;
      } else if (value == a.blue) {
        (hue = 60 * (a.red - a.green) / (value - c) + 240);
      }
    }
    hue = ((hue + 360) % 360).roundToDouble();
    if (hue == 0) {
      hue = 1;
    }
    // return new Be(d,e,b,a.alpha)
    // return new Be(hue,saturation,value,alpha)
    // Be(a,b,c,d){d=void 0===d?1:d;this.hue=a;this.saturation=b;this.value=c;this.alpha=d;

    isValidNumber(hue, 360, "hue");
    isValidNumber(saturation, 1, "saturation");
    isValidNumber(value, 1, "value");
    isValidNumber(a.alpha, 1, "alpha");
    final be = ColorHSLStructure(
      hex: a.hex,
      hue: hue,
      saturation: saturation,
      value: value,
      alpha: a.alpha,
    );
    return be;
  }

  /// Sol_Step 1 convert string into numbers red green blue
  ColorRGBStructure rgbStructure(String value) {
    if (6 != value.length && 8 != value.length) {
      throw Exception('Invalid hex color string: $value');
    }
    List<String> segments = value.slices(2);
    if (segments.length == 3) {
      segments.add('FF');
    }

    final red = hexStringToInt(segments[0]) / 255;
    final green = hexStringToInt(segments[1]) / 255;
    final blue = hexStringToInt(segments[2]) / 255;
    final alpha = hexStringToInt(segments[3]) / 255;
    isValidNumber(red, 1, 'red');
    isValidNumber(green, 1, 'green');
    isValidNumber(blue, 1, 'blue');
    isValidNumber(alpha, 1, 'alpha');
    final color = ColorRGBStructure(
        hex: value,
        red: red,
        green: green,
        blue: blue,
        alpha: alpha,
        isSelected: false);
    return color;
  }

  // was mg
  ColorDecodeResult createVariation(ColorRGBStructure b) {
    // final List<ColorRGBWithName> c = [];

    final primaryShades = materialShades(b);
    final primary =
        ColorRGBWithName(rgb: b, shades: primaryShades, name: "PRIMARY");
    // c.add(primary);
    var d = functionSe(functionYeSmall(functionZeSmall(b), 180));

    final complementaryShades = materialShades(d);
    final complementary = ColorRGBWithName(
        rgb: d, shades: complementaryShades, name: "Complementary");
    // c.add(complementary);

    var zeStrut = functionZeSmall(b);

    final analogous1Model = functionSe(functionYeSmall(zeStrut, -30));
    final analogous1Shades = materialShades(analogous1Model);
    final analogous1 = ColorRGBWithName(
        rgb: analogous1Model, shades: analogous1Shades, name: "Analogous 1");
    // c.add(analogous1);

    final analogous2Model = functionSe(functionYeSmall(zeStrut, 30));
    final analogous2Shades = materialShades(analogous2Model);
    final analogous2 = ColorRGBWithName(
        rgb: analogous2Model, shades: analogous2Shades, name: "Analogous 2");
    // c.add(analogous2);

    zeStrut = functionZeSmall(b);
    final triadic1Model = functionSe(functionYeSmall(zeStrut, 60));
    final triadic1Shades = materialShades(triadic1Model);
    final triadic1 = ColorRGBWithName(
        rgb: triadic1Model, shades: triadic1Shades, name: "Triadic 1");
    // c.add(triadic1);

    final triadic2Model = functionSe(functionYeSmall(zeStrut, 120));
    final triadic2Shades = materialShades(triadic2Model);
    final triadic2 = ColorRGBWithName(
        rgb: triadic2Model, shades: triadic2Shades, name: "Triadic 2");
    // c.add(triadic2);
    final result = ColorDecodeResult(
      primary: primary,
      complementary: complementary,
      analogous1: analogous1,
      analogous2: analogous2,
      triadic1: triadic1,
      triadic2: triadic2,
    );
    // return c;
    return result;
  }

  // was ye
  HSLHolder functionYeSmall(a, b) {
    return HSLHolder.fromDoubles(
        (a.hue + b + 360) % 360, a.saturation, a.g, a.alpha);
  }

  // was ze
  HSLHolder functionZeSmall(ColorRGBStructure a) {
    var b = math.max(math.max(a.red, a.green), a.blue),
        c = math.min(math.min(a.red, a.green), a.blue),
        d = 0.0,
        e = 0.0,
        h = functionI(.5 * (b + c), 0, 1);

    if (b - c > V) {
      b == a.red
          ? d = 60 * (a.green - a.blue) / (b - c)
          : b == a.green
              ? d = 60 * (a.blue - a.red) / (b - c) + 120
              : b == a.blue
                  ? (d = 60 * (a.red - a.green) / (b - c) + 240)
                  : b;

      e = 0;
      e < h && .5 >= h
          ? e = functionI((b - c) / (2 * h), 0, 1)
          : e = functionI((b - c) / (2 - 2 * h), 0, 1);
    }

    d = ((d + 360) % 360).roundToDouble();
    return HSLHolder.fromDoubles(d, e, h, a.alpha);
  }

  // was se
  ColorRGBStructure functionSe(HSLHolder a) {
    var b = (1 - (2 * a.g - 1).abs()) * a.saturation;
    return functionRe(a.hue, a.alpha, b, math.max(0, a.g - b / 2));
  }

  // was qe
  double functionQe(a) {
    return .04045 >= a ? a / 12.92 : math.pow((a + .055) / 1.055, 2.4);
  }

  // was Ee
  double functionEe(double a) {
    var b = 6 / 29, c = 1 / (3 * math.pow(b, 2));
    final result = a > math.pow(b, 3) ? math.pow(a, 1 / 3) : c * a + 4 / 29;

    return result.toDouble();
  }

  // was De
  NumberItem functionDe(ColorRGBStructure a) {
    var b = functionQe(a.red),
        c = functionQe(a.green),
        d = functionQe(a.blue),
        e = .2126729 * b + .7151522 * c + .072175 * d;
    return NumberItem(
      116 * functionEe(e) - 16,
      500 *
          (functionEe((.4124564 * b + .3575761 * c + .1804375 * d) / .95047) -
              functionEe(e)),
      200 *
          (functionEe(e) -
              functionEe(
                  (.0193339 * b + .119192 * c + .9503041 * d) / 1.08883)),
      d: a.alpha,
    );
  }

  // was Je
  double functionJe(double a, b) {
    if (1E-4 > a.abs() && 1E-4 > b.abs()) return 0;
    a = 180 * math.atan2(a, b) / math.pi;
    return 0 <= a ? a : a + 360;
  }

  // was Ze
  ZeResult functionZeCapital(a, List<List<NumberItem>>? b) {
    b = b ?? listKe;
    if (b.isEmpty || b[0].isEmpty) {
      throw Exception("Invalid golden palettes");
    }

    var c = double.maxFinite, d = b[0], e = -1;
    for (var h = 0; h < b.length; h++) {
      for (var f = 0; f < b[h].length && 0 < c; f++) {
        var g = b[h][f],
            l = (g.g + a.g) / 2,
            m = math.sqrt(math.pow(g.a, 2) + math.pow(g.b, 2)),
            n = math.sqrt(math.pow(a.a, 2) + math.pow(a.b, 2)),
            p = (m + n) / 2;
        p = .5 *
            (1 -
                math.sqrt(math.pow(p, 7) / (math.pow(p, 7) + math.pow(25, 7))));
        var q = g.a * (1 + p);
        double r = a.a * (1 + p);
        var t = math.sqrt(math.pow(q, 2) + math.pow(g.b, 2)),
            v = math.sqrt(math.pow(r, 2) + math.pow(a.b, 2));
        p = v - t;
        var x = (t + v) / 2;
        q = functionJe(g.b, q);
        r = functionJe(a.b, r);
        t = 2 *
            math.sqrt(t * v) *
            math.sin((1E-4 > m.abs() || 1E-4 > n.abs()
                    ? 0
                    : 180 >= (r - q).abs()
                        ? r - q
                        : r <= q
                            ? r - q + 360
                            : r - q - 360) /
                2 *
                math.pi /
                180);
        m = 1E-4 > m.abs() || 1E-4 > n.abs()
            ? 0
            : 180 >= (r - q).abs()
                ? (q + r) / 2
                : 360 > q + r
                    ? (q + r + 360) / 2
                    : (q + r - 360) / 2;
        n = 1 + .045 * x;
        v = 1 +
            .015 *
                x *
                (1 -
                    .17 * math.cos((m - 30) * math.pi / 180) +
                    .24 * math.cos(2 * m * math.pi / 180) +
                    .32 * math.cos((3 * m + 6) * math.pi / 180) -
                    .2 * math.cos((4 * m - 63) * math.pi / 180));
        var aaa = math.sqrt(math.pow(
                (a.g - g.g) /
                    (1 +
                        .015 *
                            math.pow(l - 50, 2) /
                            math.sqrt(20 + math.pow(l - 50, 2))),
                2) +
            math.pow(p / n, 2) +
            math.pow(t / v, 2) +
            p /
                n *
                math.sqrt(math.pow(x, 7) / (math.pow(x, 7) + math.pow(25, 7))) *
                math.sin(60 *
                    math.exp(-math.pow((m - 275) / 25, 2)) *
                    math.pi /
                    180) *
                -2 *
                (t / v));
        if (aaa < c) {
          (c = aaa, d = b[h], e = f);
        }
      }
    }
    return ZeResult(uc: d, tc: e);
  }

  // was Ge
  SHLModel functionGe(a) {
    return SHLModel(a.g, math.sqrt(math.pow(a.a, 2) + math.pow(a.b, 2)),
        (180 * math.atan2(a.b, a.a) / math.pi + 360) % 360,
        d: a.alpha);
  }

  // was I
  double functionI(num a, num b, num c) {
    // return math.min(math.max(a,b),c);
    final result = math.min(math.max(a.toDouble(), b.toDouble()), c.toDouble());

    return result;
  }

  // was Ie
  double functionIe(double a) {
    var b = 6 / 29, c = 3 * math.pow(b, 2);
    return a > b ? math.pow(a, 3).toDouble() : c * (a - 4 / 29).toDouble();
  }

  // was He
  double functionHe(a) {
    // return.0031308>=a?12.92*a:1.055*Math.pow(a,1/2.4)-.055
    if (0.0031308 >= a) {
      final result = 12.92 * a;
      return result;
    } else {
      final result = 1.055 * math.pow(a, 1 / 2.4) - .055;
      return result;
    }
  }

  // was Ye
  List<ColorRGBStructure> materialShades(ColorRGBStructure a) {
    final list = listKe;
    var c = functionDe(a);
    final zeResult = functionZeCapital(c, list);
    var randomList = zeResult.uc;

    var d = zeResult.tc;
    var e = randomList[d],
        h = functionGe(e),
        f = functionGe(c),
        g = 30 > functionGe(randomList[5]).chroma,
        l = h.lightness - f.lightness,
        m = h.chroma - f.chroma,
        n = h.hue - f.hue,
        p = listLe[d],
        q = listMe[d],
        r = 100.0;

    final map = randomList.asMap();
    final result = map.map((index, item) {
      var t = functionGe(item);
      var x = t.lightness - listLe[index] / p * l;
      x = math.min(x, r);
      var v = SHLModel(
          functionI(x, 0, 100),
          math.max(
              0,
              g
                  ? t.chroma - m
                  : t.chroma - m * math.min(listMe[index] / q, 1.25)),
          (t.hue - n + 360) % 360);
      r = math.max(v.lightness - 1.7, 0);
      var temp = v.hue * math.pi / 180;
      var numberItem = NumberItem(
          v.lightness, v.chroma * math.cos(temp), v.chroma * math.sin(temp),
          d: v.alpha);
      var u = (v.lightness + 16) / 116;
      var anotherDouble = .95047 * functionIe(u + numberItem.a / 500);
      x = functionIe(u);
      u = 1.08883 * functionIe(u - numberItem.b / 200);

      final redHe = functionHe(
          3.2404542 * anotherDouble + -1.5371385 * x + -.4985314 * u);
      final red = functionI(redHe, 0, 1);
      final greenHe =
          functionHe(-.969266 * anotherDouble + 1.8760108 * x + .041556 * u);
      final green = functionI(greenHe, 0, 1);
      final blueHe =
          functionHe(.0556434 * anotherDouble + -.2040259 * x + 1.0572252 * u);
      final blue = functionI(blueHe, 0, 1);
      return MapEntry(
        index,
        ColorRGBStructure.fromDoubles(
          red,
          green,
          blue,
          v.alpha,
          isSelected: item == e,
        ),
      );
    });

    return result.values.whereType<ColorRGBStructure>().toList();
  }

  // was re
  ColorRGBStructure functionRe(double a, b, c, d) {
    var e = d, h = d;
    a = a % 360 / 60;
    var f = c * (1 - (a % 2 - 1).abs());
    switch (a.floor()) {
      case 0:
        e += c;
        h += f;
        break;
      case 1:
        e += f;
        h += c;
        break;
      case 2:
        h += c;
        d += f;
        break;
      case 3:
        h += f;
        d += c;
        break;
      case 4:
        e += f;
        d += c;
        break;
      case 5:
        e += c;
        d += f;
    }
    return ColorRGBStructure.fromDoubles(e, h, d, b);
  }

  int hexStringToInt(String hex) {
    if (!hex.isValidHex()) {
      throw Exception('Invalid hex color string: $hex');
    }
    return int.parse(hex, radix: 16);
  }
}

extension StringSlice on String {
  List<String> slices(int length) {
    final b = List<String>.generate(this.length, (index) => this[index]);

    return b.slices(length).map((e) => e.join()).toList();
  }

  bool isValidHex() {
    final temp = RegExp('[0-9a-fA-F]');
    return temp.hasMatch(this);
  }
}
