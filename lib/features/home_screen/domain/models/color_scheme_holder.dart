// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:color_extractor/core/configuration/constants.dart';

class ColorSchemeHolder extends Equatable {
  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color inversePrimary;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color scaffoldBackground;
  final Color appBar;
  final Color onAppBar;

  const ColorSchemeHolder({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.inversePrimary,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.scaffoldBackground,
    required this.appBar,
    required this.onAppBar,
  });

  @override
  List<Object?> get props => [
        brightness,
        primary,
        onPrimary,
        primaryContainer,
        onPrimaryContainer,
        inversePrimary,
        secondary,
        onSecondary,
        secondaryContainer,
        onSecondaryContainer,
        tertiary,
        onTertiary,
        tertiaryContainer,
        onTertiaryContainer,
        error,
        onError,
        errorContainer,
        onErrorContainer,
        background,
        onBackground,
        surface,
        onSurface,
        surfaceVariant,
        onSurfaceVariant,
        outline,
        outlineVariant,
        shadow,
        scrim,
        inverseSurface,
        scaffoldBackground,
        appBar,
        onAppBar,
      ];

  factory ColorSchemeHolder.empty() => const ColorSchemeHolder(
        brightness: Brightness.light,
        primary: AppConstants.emptyColor,
        onPrimary: AppConstants.emptyColor,
        primaryContainer: AppConstants.emptyColor,
        onPrimaryContainer: AppConstants.emptyColor,
        inversePrimary: AppConstants.emptyColor,
        secondary: AppConstants.emptyColor,
        onSecondary: AppConstants.emptyColor,
        secondaryContainer: AppConstants.emptyColor,
        onSecondaryContainer: AppConstants.emptyColor,
        tertiary: AppConstants.emptyColor,
        onTertiary: AppConstants.emptyColor,
        tertiaryContainer: AppConstants.emptyColor,
        onTertiaryContainer: AppConstants.emptyColor,
        error: AppConstants.emptyColor,
        onError: AppConstants.emptyColor,
        errorContainer: AppConstants.emptyColor,
        onErrorContainer: AppConstants.emptyColor,
        background: AppConstants.emptyColor,
        onBackground: AppConstants.emptyColor,
        surface: AppConstants.emptyColor,
        onSurface: AppConstants.emptyColor,
        surfaceVariant: AppConstants.emptyColor,
        onSurfaceVariant: AppConstants.emptyColor,
        outline: AppConstants.emptyColor,
        outlineVariant: AppConstants.emptyColor,
        shadow: AppConstants.emptyColor,
        scrim: AppConstants.emptyColor,
        inverseSurface: AppConstants.emptyColor,
        scaffoldBackground: AppConstants.emptyColor,
        appBar: AppConstants.emptyColor,
        onAppBar: AppConstants.emptyColor,
      );

  ColorSchemeHolder copyWith({
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? inversePrimary,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? scaffoldBackground,
    Color? appBar,
    Color? onAppBar,
  }) {
    return ColorSchemeHolder(
      brightness: brightness ?? this.brightness,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      appBar: appBar ?? this.appBar,
      onAppBar: onAppBar ?? this.onAppBar,
    );
  }
}
