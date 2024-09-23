//

// import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'golden_palettes_definition.dart';

extension ColorToMaterial on Color {
  TonalPalette _generateTonalPalette(LABColor color, List<List<LABColor>>? b) {
    b = b ?? goldenPalettes;
    if (b.isEmpty || b[0].isEmpty) {
      throw Exception("Invalid golden palettes");
    }

    double transform(double a, double b) {
      if (1E-4 > a.abs() && 1E-4 > b.abs()) return 0;
      a = (180 * math.atan2(a, b)) / math.pi;
      return 0 <= a ? a : a + 360;
    }

    var c = double.maxFinite;
    var palette = b[0];
    var mainColorIndex = -1;
    for (var h = 0; h < b.length; h++) {
      for (var f = 0; f < b[h].length && 0 < c; f++) {
        var colorCurrent = b[h][f],
            avgLightness = (colorCurrent.lightness + color.lightness) / 2,
            //    Math.pow(colorCurrent.A, 2) + Math.pow(colorCurrent.B, 2)
            currentLabDist = math.sqrt(
                math.pow(colorCurrent.a, 2) + math.pow(colorCurrent.b, 2)),
            targetLabDist =
                math.sqrt(math.pow(color.a, 2) + math.pow(color.b, 2)),
            labDist = (currentLabDist + targetLabDist) / 2;
        labDist = .5 *
            (1 -
                math.sqrt(math.pow(labDist, 7) /
                    (math.pow(labDist, 7) + math.pow(25, 7))));
        var currentRefA = colorCurrent.a * (1 + labDist);
        double targetRefA = color.a * (1 + labDist);
        var currentRefDist = math
                .sqrt(math.pow(currentRefA, 2) + math.pow(colorCurrent.b, 2)),
            targetRefDist =
                math.sqrt(math.pow(targetRefA, 2) + math.pow(color.b, 2));
        labDist = targetRefDist - currentRefDist;
        var refDist = (currentRefDist + targetRefDist) / 2;
        currentRefA = transform(colorCurrent.b, currentRefA);
        targetRefA = transform(color.b, targetRefA);
        currentRefDist = 2 *
            math.sqrt(currentRefDist * targetRefDist) *
            math.sin((1E-4 > currentLabDist.abs() || 1E-4 > targetLabDist.abs()
                    ? 0
                    : 180 >= (targetRefA - currentRefA).abs()
                        ? targetRefA - currentRefA
                        : targetRefA <= currentRefA
                            ? targetRefA - currentRefA + 360
                            : targetRefA - currentRefA - 360) /
                2 *
                math.pi /
                180);
        currentLabDist =
            1E-4 > currentLabDist.abs() || 1E-4 > targetLabDist.abs()
                ? 0
                : 180 >= (targetRefA - currentRefA).abs()
                    ? (currentRefA + targetRefA) / 2
                    : 360 > currentRefA + targetRefA
                        ? (currentRefA + targetRefA + 360) / 2
                        : (currentRefA + targetRefA - 360) / 2;
        targetLabDist = 1 + .045 * refDist;
        targetRefDist = 1 +
            .015 *
                refDist *
                (1 -
                    .17 * math.cos((currentLabDist - 30) * math.pi / 180) +
                    .24 * math.cos(2 * currentLabDist * math.pi / 180) +
                    .32 * math.cos((3 * currentLabDist + 6) * math.pi / 180) -
                    .2 * math.cos((4 * currentLabDist - 63) * math.pi / 180));
        var result = math.sqrt(math.pow(
                (color.lightness - colorCurrent.lightness) /
                    (1 +
                        .015 *
                            math.pow(avgLightness - 50, 2) /
                            math.sqrt(20 + math.pow(avgLightness - 50, 2))),
                2) +
            math.pow(labDist / targetLabDist, 2) +
            math.pow(currentRefDist / targetRefDist, 2) +
            labDist /
                targetLabDist *
                math.sqrt(math.pow(refDist, 7) /
                    (math.pow(refDist, 7) + math.pow(25, 7))) *
                math.sin(60 *
                    math.exp(-math.pow((currentLabDist - 275) / 25, 2)) *
                    math.pi /
                    180) *
                -2 *
                (currentRefDist / targetRefDist));
        if (result < c) {
          (c = result, palette = b[h], mainColorIndex = f);
        }
      }
    }
    return TonalPalette(uc: palette, tc: mainColorIndex);
  }

  HCLColor _labColorToLchColor(LABColor a) {
    final lightness = a.lightness;
    final saturation = math.sqrt(math.pow(a.a, 2) + math.pow(a.b, 2));
    final hue = (180 * math.atan2(a.b, a.a) / math.pi + 360) % 360;
    final alpha = a.alpha;

    return HCLColor(
      lightness,
      saturation,
      hue,
      d: alpha,
    );
  }

  double _clipRange(double a, double b, double c) {
    final result = math.min(math.max(a, b), c);

    return result;
  }

  double _getRatio(double a) {
    var b = 6 / 29, c = 3 * math.pow(b, 2);
    return a > b ? math.pow(a, 3).toDouble() : c * (a - 4 / 29).toDouble();
  }

  Color _travelColor(HSVColor color, double degree) {
    // ((a.hue + b + 360) % 360, a.saturation, a.g, a.alpha);
    // const degree = 180;
    final newHueValue = (color.hue + degree + 360) % 360;
    return color.withHue(newHueValue).toColor();
  }

  LABColor _toLabColor() {
    double transformRGBValue(a) {
      return .04045 >= a ? a / 12.92 : math.pow((a + .055) / 1.055, 2.4);
    }

    double transform(double a) {
      var b = 6 / 29, c = 1 / (3 * math.pow(b, 2));
      final result = a > math.pow(b, 3) ? math.pow(a, 1 / 3) : c * a + 4 / 29;

      return result.toDouble();
    }

    var b = transformRGBValue(red / 255),
        c = transformRGBValue(green / 255),
        d = transformRGBValue(blue / 255),
        e = .2126729 * b + .7151522 * c + .072175 * d;
    return LABColor(
      116 * transform(e) - 16,
      500 *
          (transform((.4124564 * b + .3575761 * c + .1804375 * d) / .95047) -
              transform(e)),
      200 *
          (transform(e) -
              transform((.0193339 * b + .119192 * c + .9503041 * d) / 1.08883)),
      d: alpha / 255,
    );
  }

  MaterialColor _materialColorFromShades(List<Color> shades) {
    final colorDegrees = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    final swatch = colorDegrees
        .asMap()
        .map((key, degree) => MapEntry(degree, shades[key]));
    return MaterialColor(shades[5].value, swatch);
  }

  ShadeResult _createShades() {
    double transform(double a) {
      return 0.0031308 >= a ? 12.92 * a : 1.055 * math.pow(a, 1 / 2.4) - 0.055;
    }

    final list = goldenPalettes;
    var labColor = _toLabColor();
    final zeResult = _generateTonalPalette(labColor, list);

    var palette = zeResult.uc;
    var mainColorIndex = zeResult.tc;

    var mainLAB = palette[mainColorIndex];
    var mainHCL = _labColorToLchColor(mainLAB),
        currentHCL = _labColorToLchColor(labColor),
        chromaThreshold = 30 > _labColorToLchColor(palette[5]).chroma,
        deltaLightness = mainHCL.lightness - currentHCL.lightness,
        deltaChroma = mainHCL.chroma - currentHCL.chroma,
        deltaHue = mainHCL.hue - currentHCL.hue,
        refLightness = lightnessTable[mainColorIndex],
        refChroma = chromaTable[mainColorIndex],
        A = 100.0;

    final map = palette.asMap();
    final result = map.map((index, inputColor) {
      var colorHCL = _labColorToLchColor(inputColor);
      var newL = colorHCL.lightness -
          lightnessTable[index] / refLightness * deltaLightness;
      newL = math.min(newL, A);
      var color = HCLColor(
          _clipRange(newL, 0, 100),
          math.max(
              0,
              chromaThreshold
                  ? colorHCL.chroma - deltaChroma
                  : colorHCL.chroma -
                      deltaChroma *
                          math.min(chromaTable[index] / refChroma, 1.25)),
          (colorHCL.hue - deltaHue + 360) % 360);
      A = math.max(color.lightness - 1.7, 0);
      var hue = color.hue * math.pi / 180;
      var outputColor = LABColor(
        color.lightness,
        color.chroma * math.cos(hue),
        color.chroma * math.sin(hue),
        d: color.alpha,
      );
      var diffLightness = (color.lightness + 16) / 116;
      var scalar = .95047 * _getRatio(diffLightness + outputColor.a / 500);
      newL = _getRatio(diffLightness);
      // diffL = 1.08883 * getRatio(diffL - outputColor.B / 200);
      diffLightness = 1.08883 * _getRatio(diffLightness - outputColor.b / 200);

      final redRange = transform(
          3.2404542 * scalar + -1.5371385 * newL + -.4985314 * diffLightness);
      final red = _clipRange(redRange, 0, 1);
      final greenRange = transform(
          -.969266 * scalar + 1.8760108 * newL + .041556 * diffLightness);
      final green = _clipRange(greenRange, 0, 1);
      final blueRange = transform(
          .0556434 * scalar + -.2040259 * newL + 1.0572252 * diffLightness);
      final blue = _clipRange(blueRange, 0, 1);
      // if (inputColor == mainLAB) {
      //   // log('index: $index');
      //   target = index;
      // }
      return MapEntry(
        index,
        RGBColor(
          red: red,
          green: green,
          blue: blue,
          alpha: color.alpha,
          isSelected: inputColor == mainLAB,
        ),
      );
    });
    final shades = result.values.toList();
    final target = shades.indexWhere((element) => element.isSelected);
    final shadeResult = ShadeResult(
      selected: target,
      shades: shades.map((e) => e.color).toList(),
    );
    return shadeResult;
  }

  MaterialColor toMaterialColor() {
    final shades = _createShades().shades;
    final colorDegrees = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    final swatch = colorDegrees
        .asMap()
        .map((key, degree) => MapEntry(degree, shades[key]));
    return MaterialColor(shades[5].value, swatch);
  }

  ColorDecodeResult createVariation() {
    final hsv = HSVColor.fromColor(this);

    final primaryResult = _createShades();
    final primary = MaterialColorWithIndex(
      color: _materialColorFromShades(primaryResult.shades),
      index: primaryResult.selected,
    );

    final complementaryColor = _travelColor(hsv, 180);
    final complementaryResult = complementaryColor._createShades();

    final complementary = MaterialColorWithIndex(
      color: _materialColorFromShades(complementaryResult.shades),
      index: complementaryResult.selected,
    );

    final analogous1Shade = _travelColor(hsv, -30);
    final analogous1Result = analogous1Shade._createShades();
    final analogous1 = MaterialColorWithIndex(
      color: _materialColorFromShades(analogous1Result.shades),
      index: analogous1Result.selected,
    );

    final analogous2Shade = _travelColor(hsv, 30);
    final analogous2Result = analogous2Shade._createShades();
    final analogous2 = MaterialColorWithIndex(
      color: _materialColorFromShades(analogous2Result.shades),
      index: analogous2Result.selected,
    );

    final triadic1Shade = _travelColor(hsv, 60);
    final triadic1Result = triadic1Shade._createShades();
    final triadic1 = MaterialColorWithIndex(
      color: _materialColorFromShades(triadic1Result.shades),
      index: triadic1Result.selected,
    );

    final triadic2Shade = _travelColor(hsv, 120);
    final triadic2Result = triadic2Shade._createShades();
    final triadic2 = MaterialColorWithIndex(
      color: _materialColorFromShades(triadic2Result.shades),
      index: triadic2Result.selected,
    );

    return ColorDecodeResult(
      primary: primary,
      complementary: complementary,
      analogous1: analogous1,
      analogous2: analogous2,
      triadic1: triadic1,
      triadic2: triadic2,
    );
  }
}
