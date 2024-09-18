// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String colorTitle;
  final String json;
  final List<AppColor> colors;
  final Failure? failure;
  final bool showCopyMessage;
  final Color selectedColor;
  final ColorDecodeResult? variation;
  final String hex;
  final MaterialColor primaryMaterialColor;
  final MaterialColor secondaryMaterialColor;
  final MaterialColor tertiaryMaterialColor;
  final MaterialColor errorMaterialColor;
  final MaterialColor neutralVariantMaterialColor;
  final MaterialColor neutralMaterialColor;

  final ColorSchemeHolder lightColorScheme;
  final ColorSchemeHolder darkColorScheme;

  final PalletStatus status;
  final bool isClipping;
  final bool showClipMessage;

  const HomeState({
    required this.colorTitle,
    required this.json,
    required this.colors,
    required this.failure,
    required this.showCopyMessage,
    required this.selectedColor,
    required this.variation,
    required this.hex,
    required this.primaryMaterialColor,
    required this.secondaryMaterialColor,
    required this.tertiaryMaterialColor,
    required this.errorMaterialColor,
    required this.neutralVariantMaterialColor,
    required this.neutralMaterialColor,
    required this.lightColorScheme,
    required this.darkColorScheme,
    required this.status,
    required this.isClipping,
    required this.showClipMessage,
  });

  factory HomeState.initial() {
    final primary = const Color(0xFF90c44b).toMaterialColor();
    final secondary = const Color(0xFF919f87).toMaterialColor();
    final tertiary = const Color(0xFF54c4d4).toMaterialColor();
    final error = const Color(0xFFf64234).toMaterialColor();
    final neutralVariant = const Color(0xFFb1aeb3).toMaterialColor();
    final neutral = const Color(0xFFb1b3ae).toMaterialColor();
    return HomeState(
      colorTitle: '',
      json: '',
      colors: const [],
      failure: null,
      showCopyMessage: false,
      selectedColor: Colors.grey,
      variation: null,
      hex: '',
      primaryMaterialColor: primary,
      secondaryMaterialColor: secondary,
      tertiaryMaterialColor: tertiary,
      errorMaterialColor: error,
      neutralVariantMaterialColor: neutralVariant,
      neutralMaterialColor: neutral,
      status: PalletStatus.display,
      isClipping: false,
      showClipMessage: false,
      lightColorScheme: ColorSchemeHolder.empty().copyWith(
        scaffoldBackground: neutral.shade50,
        primary: primary.shade500,
        onPrimary: primary.shade50,
        primaryContainer: primary.shade300,
        onPrimaryContainer: primary.shade50,
        inversePrimary: primary.shade700,
        secondary: secondary.shade500,
        onSecondary: secondary.shade50,
        secondaryContainer: secondary.shade300,
        onSecondaryContainer: secondary.shade50,
        tertiary: tertiary.shade500,
        onTertiary: tertiary.shade50,
        tertiaryContainer: tertiary.shade300,
        onTertiaryContainer: tertiary.shade50,
        error: error.shade500,
        onError: error.shade50,
        errorContainer: error.shade300,
        onErrorContainer: error.shade50,
        background: neutralVariant.shade100,
        onBackground: neutralVariant.shade900,
        surface: neutralVariant.shade200,
        onSurface: neutralVariant.shade900,
        surfaceVariant: neutralVariant.shade100,
        onSurfaceVariant: neutralVariant.shade900,
        outline: neutralVariant.shade700,
        outlineVariant: neutralVariant.shade500,
        shadow: neutralVariant.shade900,
        scrim: neutralVariant.shade900,
        inverseSurface: neutralVariant.shade700,
        appBar: primary.shade500,
        onAppBar: primary.shade50,
      ),
      darkColorScheme: ColorSchemeHolder.empty().copyWith(
        brightness: Brightness.dark,
        scaffoldBackground: neutral.shade800,
        primary: primary.shade500,
        onPrimary: primary.shade50,
        primaryContainer: primary.shade300,
        onPrimaryContainer: primary.shade50,
        inversePrimary: primary.shade700,
        secondary: secondary.shade500,
        onSecondary: secondary.shade50,
        secondaryContainer: secondary.shade300,
        onSecondaryContainer: secondary.shade50,
        tertiary: tertiary.shade500,
        onTertiary: tertiary.shade50,
        tertiaryContainer: tertiary.shade300,
        onTertiaryContainer: tertiary.shade50,
        error: error.shade500,
        onError: error.shade50,
        errorContainer: error.shade300,
        onErrorContainer: error.shade50,
        background: neutral.shade900,
        onBackground: neutral.shade50,
        surface: neutral.shade800,
        onSurface: neutral.shade50,
        surfaceVariant: neutral.shade700,
        onSurfaceVariant: neutral.shade900,
        outline: neutral.shade500,
        outlineVariant: neutral.shade500,
        shadow: neutral.shade50,
        scrim: neutral.shade900,
        inverseSurface: neutral.shade700,
        appBar: primary.shade500,
        onAppBar: primary.shade50,
      ),
    );
  }

  @override
  List<Object?> get props => [
        colorTitle,
        json,
        colors,
        failure,
        showCopyMessage,
        selectedColor,
        variation,
        hex,
        primaryMaterialColor,
        secondaryMaterialColor,
        tertiaryMaterialColor,
        errorMaterialColor,
        neutralVariantMaterialColor,
        neutralMaterialColor,
        lightColorScheme,
        darkColorScheme,
        status,
        isClipping,
        showClipMessage,
      ];

  HomeState copyWith({
    String? colorTitle,
    String? json,
    List<AppColor>? colors,
    Failure? failure,
    bool clearFailure = false,
    bool? showCopyMessage,
    Color? selectedColor,
    ColorDecodeResult? variation,
    String? hex,
    MaterialColor? primaryMaterialColor,
    MaterialColor? secondaryMaterialColor,
    MaterialColor? tertiaryMaterialColor,
    MaterialColor? errorMaterialColor,
    MaterialColor? neutralVariantMaterialColor,
    MaterialColor? neutralMaterialColor,
    ColorSchemeHolder? lightColorScheme,
    ColorSchemeHolder? darkColorScheme,
    PalletStatus? status,
    bool? isClipping,
    bool? showClipMessage,
  }) {
    return HomeState(
      colorTitle: colorTitle ?? this.colorTitle,
      json: json ?? this.json,
      colors: colors ?? this.colors,
      failure: clearFailure ? null : failure ?? this.failure,
      showCopyMessage: showCopyMessage ?? this.showCopyMessage,
      selectedColor: selectedColor ?? this.selectedColor,
      variation: variation ?? this.variation,
      hex: hex ?? this.hex,
      primaryMaterialColor: primaryMaterialColor ?? this.primaryMaterialColor,
      secondaryMaterialColor:
          secondaryMaterialColor ?? this.secondaryMaterialColor,
      tertiaryMaterialColor:
          tertiaryMaterialColor ?? this.tertiaryMaterialColor,
      errorMaterialColor: errorMaterialColor ?? this.errorMaterialColor,
      neutralVariantMaterialColor:
          neutralVariantMaterialColor ?? this.neutralVariantMaterialColor,
      neutralMaterialColor: neutralMaterialColor ?? this.neutralMaterialColor,
      lightColorScheme: lightColorScheme ?? this.lightColorScheme,
      darkColorScheme: darkColorScheme ?? this.darkColorScheme,
      status: status ?? this.status,
      isClipping: isClipping ?? this.isClipping,
      showClipMessage: showClipMessage ?? this.showClipMessage,
    );
  }

  Color colorFromVariant(ColorType type, ColorShade shade) {
    final MaterialColor color = switch (type) {
      ColorType.primary => primaryMaterialColor,
      ColorType.secondary => secondaryMaterialColor,
      ColorType.tertiary => tertiaryMaterialColor,
      ColorType.error => errorMaterialColor,
      ColorType.neutral => neutralMaterialColor,
      ColorType.neutralVariant => neutralVariantMaterialColor,
    };

    final colorWithShade = switch (shade) {
      ColorShade.shade50 => color.shade50,
      ColorShade.shade100 => color.shade100,
      ColorShade.shade200 => color.shade200,
      ColorShade.shade300 => color.shade300,
      ColorShade.shade400 => color.shade400,
      ColorShade.shade500 => color.shade500,
      ColorShade.shade600 => color.shade600,
      ColorShade.shade700 => color.shade700,
      ColorShade.shade800 => color.shade800,
      ColorShade.shade900 => color.shade900,
    };
    return colorWithShade;
  }

  ColorCombination combinationFromVariant(ColorVariant variant) {
    final colorString = variant.color;
    Color color;
    if (colorString != null) {
      color = colorString.toColorLocal();
    } else {
      color = colorFromVariant(variant.type, variant.shade);
    }

    final onColorString = variant.onColor;
    Color onColor;
    if (onColorString != null) {
      onColor = onColorString.toColorLocal();
    } else {
      onColor = colorFromVariant(variant.onType, variant.onShade);
    }

    return ColorCombination(color: color, onColor: onColor);
  }

  List<String> toClipboard() {
    List<String> lines = [];
    lines.add('//');
    lines.add('');
    lines.add('import \'package:flutter/material.dart\';');
    lines.add('class Pallet {');
    lines.add('Pallet._internal();');
    lines.add('');
    lines.addAll(primaryMaterialColor.toObject('primary'));
    lines.add('');
    lines.addAll(secondaryMaterialColor.toObject('secondary'));
    lines.add('');
    lines.addAll(tertiaryMaterialColor.toObject('tertiary'));
    lines.add('');
    lines.addAll(errorMaterialColor.toObject('error'));
    lines.add('');
    lines.addAll(neutralVariantMaterialColor.toObject('neutralVariant'));
    lines.add('');
    lines.addAll(neutralMaterialColor.toObject('neutral'));
    lines.add('');
    lines.add('}');

    lines.add('class ColorSchemeProvider {');
    lines.add('static const ColorScheme darkFromCorePalette = ColorScheme(');
    lines.add('brightness: Brightness.dark,');

    lines.add('primary: ${darkColorScheme.primary.toSyntaxColor()},');
    lines.add('onPrimary: ${darkColorScheme.onPrimary.toSyntaxColor()},');
    lines.add(
        'primaryContainer: ${darkColorScheme.primaryContainer.toSyntaxColor()},');
    lines.add(
        'onPrimaryContainer: ${darkColorScheme.onPrimaryContainer.toSyntaxColor()},');
    lines.add('inversePrimary: ${darkColorScheme.inversePrimary},');
    lines.add('');
    lines.add('secondary: ${darkColorScheme.secondary.toSyntaxColor()},');
    lines.add('onSecondary: ${darkColorScheme.onSecondary},');
    lines.add('secondaryContainer: ${darkColorScheme.secondaryContainer},');
    lines.add('onSecondaryContainer: ${darkColorScheme.onSecondaryContainer},');
    lines.add('');
    lines.add('tertiary: ${darkColorScheme.tertiary.toSyntaxColor()},');
    lines.add('onTertiary: ${darkColorScheme.onTertiary.toSyntaxColor()},');
    lines.add(
        'tertiaryContainer: ${darkColorScheme.tertiaryContainer.toSyntaxColor()},');
    lines.add(
        'onTertiaryContainer: ${darkColorScheme.onTertiaryContainer.toSyntaxColor()},');
    lines.add('');
    lines.add('error: ${darkColorScheme.error},');
    lines.add('onError: ${darkColorScheme.onError.toSyntaxColor()},');
    lines.add(
        'errorContainer: ${darkColorScheme.errorContainer.toSyntaxColor()},');
    lines.add(
        'onErrorContainer: ${darkColorScheme.onErrorContainer.toSyntaxColor()},');
    lines.add('');
    lines.add('background: ${darkColorScheme.background.toSyntaxColor()},');
    lines.add('onBackground: ${darkColorScheme.onBackground.toSyntaxColor()},');
    lines.add('surface: ${darkColorScheme.surface.toSyntaxColor()},');
    lines.add('onSurface: ${darkColorScheme.onSurface.toSyntaxColor()},');
    lines.add(
        'surfaceVariant: ${darkColorScheme.surfaceVariant.toSyntaxColor()},');
    lines.add(
        'onSurfaceVariant: ${darkColorScheme.onSurfaceVariant.toSyntaxColor()},');
    lines.add('outline: ${darkColorScheme.outline.toSyntaxColor()},');
    lines.add(
        'outlineVariant: ${darkColorScheme.outlineVariant.toSyntaxColor()},');
    lines.add('shadow: ${darkColorScheme.shadow.toSyntaxColor()},');
    lines.add('scrim: ${darkColorScheme.scrim.toSyntaxColor()},');
    lines.add(
        'inverseSurface: ${darkColorScheme.inverseSurface.toSyntaxColor()},');
    lines.add(');');
    lines.add('');

    // light scheme
    lines.add('');
    lines.add('static const ColorScheme lightFromCorePalette = ColorScheme(');
    lines.add('brightness: Brightness.light,');

    lines.add('primary: ${lightColorScheme.primary.toSyntaxColor()},');
    lines.add('onPrimary: ${lightColorScheme.onPrimary.toSyntaxColor()},');
    lines.add(
        'primaryContainer: ${lightColorScheme.primaryContainer.toSyntaxColor()},');
    lines.add(
        'onPrimaryContainer: ${lightColorScheme.onPrimaryContainer.toSyntaxColor()},');
    lines.add('inversePrimary: ${lightColorScheme.inversePrimary},');
    lines.add('');
    lines.add('secondary: ${lightColorScheme.secondary.toSyntaxColor()},');
    lines.add('onSecondary: ${lightColorScheme.onSecondary},');
    lines.add('secondaryContainer: ${lightColorScheme.secondaryContainer},');
    lines
        .add('onSecondaryContainer: ${lightColorScheme.onSecondaryContainer},');
    lines.add('');
    lines.add('tertiary: ${lightColorScheme.tertiary.toSyntaxColor()},');
    lines.add('onTertiary: ${lightColorScheme.onTertiary.toSyntaxColor()},');
    lines.add(
        'tertiaryContainer: ${lightColorScheme.tertiaryContainer.toSyntaxColor()},');
    lines.add(
        'onTertiaryContainer: ${lightColorScheme.onTertiaryContainer.toSyntaxColor()},');
    lines.add('');
    lines.add('error: ${lightColorScheme.error},');
    lines.add('onError: ${lightColorScheme.onError.toSyntaxColor()},');
    lines.add(
        'errorContainer: ${lightColorScheme.errorContainer.toSyntaxColor()},');
    lines.add(
        'onErrorContainer: ${lightColorScheme.onErrorContainer.toSyntaxColor()},');
    lines.add('');
    lines.add('background: ${lightColorScheme.background.toSyntaxColor()},');
    lines
        .add('onBackground: ${lightColorScheme.onBackground.toSyntaxColor()},');
    lines.add('surface: ${lightColorScheme.surface.toSyntaxColor()},');
    lines.add('onSurface: ${lightColorScheme.onSurface.toSyntaxColor()},');
    lines.add(
        'surfaceVariant: ${lightColorScheme.surfaceVariant.toSyntaxColor()},');
    lines.add(
        'onSurfaceVariant: ${lightColorScheme.onSurfaceVariant.toSyntaxColor()},');
    lines.add('outline: ${lightColorScheme.outline.toSyntaxColor()},');
    lines.add(
        'outlineVariant: ${lightColorScheme.outlineVariant.toSyntaxColor()},');
    lines.add('shadow: ${lightColorScheme.shadow.toSyntaxColor()},');
    lines.add('scrim: ${lightColorScheme.scrim.toSyntaxColor()},');
    lines.add(
        'inverseSurface: ${lightColorScheme.inverseSurface.toSyntaxColor()},');
    lines.add(');');
    lines.add('');
    lines.add('}');

    lines.add('class ThemeProvider {');
    lines.add('ThemeProvider._internal();');

    lines.add('static ThemeData lightTheme() {');
    lines.add('const colorScheme = ColorSchemeProvider.lightFromCorePalette;');
    lines.add(
        'final textTheme = ThemeData(brightness: Brightness.light).textTheme;');
    lines.add('return ThemeData(');
    lines.add('useMaterial3: true,');
    lines.add('brightness: Brightness.light,');
    lines.add('colorScheme: colorScheme,');
    lines.add('textTheme: textTheme,');
    lines.add(
        'scaffoldBackgroundColor: const ${lightColorScheme.scaffoldBackground.toSyntaxColor()},');
    lines.add('appBarTheme: const AppBarTheme(');
    lines.add('  backgroundColor: ${lightColorScheme.appBar.toSyntaxColor()},');
    lines.add(
        '  foregroundColor: ${lightColorScheme.onAppBar.toSyntaxColor()},');
    lines.add('),');
    lines.add(');');
    lines.add('}');

    lines.add('static ThemeData darkTheme() {');
    lines.add('const colorScheme = ColorSchemeProvider.darkFromCorePalette;');
    lines.add(
        'final textTheme = ThemeData(brightness: Brightness.dark).textTheme;');
    lines.add('return ThemeData(');
    lines.add('useMaterial3: true,');
    lines.add('brightness: Brightness.dark,');
    lines.add('colorScheme: colorScheme,');
    lines.add('textTheme: textTheme,');
    lines.add(
        'scaffoldBackgroundColor: const ${darkColorScheme.scaffoldBackground.toSyntaxColor()},');
    lines.add('appBarTheme: const AppBarTheme(');
    lines.add('backgroundColor: ${darkColorScheme.appBar.toSyntaxColor()},');
    lines.add('foregroundColor: ${darkColorScheme.onAppBar.toSyntaxColor()},');
    lines.add('),');
    lines.add(');');
    lines.add('}');
    lines.add('}');

    return lines;
  }
}
