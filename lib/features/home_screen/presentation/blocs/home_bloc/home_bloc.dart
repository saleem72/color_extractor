//

import 'dart:async';

import 'package:color_extractor/core/domain/models/app_color.dart';
import 'package:color_extractor/core/domain/models/material_color_source.dart';
import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:color_extractor/features/home_screen/data/helpers/string_to_color.dart';
import 'package:color_extractor/features/home_screen/data/repository/home_repository.dart';
import 'package:color_extractor/features/home_screen/data/repository/pallet_repository.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_combination.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_decode_result.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_scheme_holder.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_variant.dart';
import 'package:color_extractor/features/home_screen/domain/models/pallet_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_core/my_core.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TextEditingController colorTitle = TextEditingController();
  final TextEditingController json = TextEditingController();
  final TextEditingController hexInput = TextEditingController();
  final HomeRepository _homeRepository;
  final PalletRepository _repository;
  final StringToColor _converter;
  HomeBloc({
    required HomeRepository homeRepository,
    required StringToColor converter,
    required PalletRepository palletRepository,
  })  : _homeRepository = homeRepository,
        _repository = palletRepository,
        _converter = converter,
        super(HomeState.initial()) {
    on<HomeColorTitleChangedEvent>(_onColorTitleChangedEvent);
    on<HomeJsonChangedEvent>(_onJsonChangedEvent);
    on<HomeDecodeJsonEvent>(_onDecodeJsonEvent);
    on<HomeClearErrorEvent>(_onClearErrorEvent);
    on<HomeCopyToClipboardEvent>(_onCopyToClipboardEvent);
    on<HomeHideCopyMessageEvent>(_onHideCopyMessageEvent);
    on<HomeCopyMaterialColorToClipboardEvent>(
        _onCopyMaterialColorToClipboardEvent);
    on<HomeCopyListOfColorsToClipboardEvent>(
        _onCopyListOfColorsToClipboardEvent);
    on<HomeHexHasChangedEvent>(_onHexHasChangedEvent);
    on<HomeDecodeColorEvent>(_onDecodeColorEvent);
    on<HomeToggleStatusEvent>(_onToggleStatusEvent);
    on<HomePrimaryColorChangedEvent>(_onPrimaryStringChangedEvent);
    on<HomeScaffoldColorChangedEvent>(_onScaffoldColorChangedEvent);
    on<HomePrimaryChangedEvent>(_onPrimaryChangedEvent);
    on<HomePrimaryContainerChangedEvent>(_onPrimaryContainerChangedEvent);
    on<HomeSecondaryChangedEvent>(_onSecondaryChangedEvent);
    on<HomeSecondaryContainerChangedEvent>(_onSecondaryContainerChangedEvent);
    on<HomeTertiaryChangedEvent>(_onTertiaryChangedEvent);
    on<HomeTertiaryContainerChangedEvent>(_onTertiaryContainerChangedEvent);
    on<HomeErrorChangedEvent>(_onErrorChangedEvent);
    on<HomeErrorContainerChangedEvent>(_onErrorContainerChangedEvent);
    on<HomeBackgroundChangedEvent>(_onBackgroundChangedEvent);
    on<HomeSurfaceChangedEvent>(_onSurfaceChangedEvent);
    on<HomeSurfaceVariantChangedEvent>(_onSurfaceVariantChangedEvent);
    on<HomeOutLineChangedEvent>(_onOutLineChangedEvent);
    on<HomeOutLineVariantChangedEvent>(_onOutLineVariantChangedEvent);
    on<HomeInversePrimaryChangedEvent>(_onInversePrimaryChangedEvent);
    on<HomeInverseSurfaceChangedEvent>(_onInverseSurfaceChangedEvent);
    on<HomeAppBarChangedEvent>(_onAppBarChangedEvent);
    on<HomeShadowChangedEvent>(_onShadowChangedEvent);
    on<HomeCopyPalletToClipboardEvent>(_onCopyPalletToClipboardEvent);
    on<HomeHideClipMessageEvent>(_onHideClipMessageEvent);
  }

  @override
  Future<void> close() {
    colorTitle.dispose();
    json.dispose();
    hexInput.dispose();
    return super.close();
  }

  _onColorTitleChangedEvent(
      HomeColorTitleChangedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(colorTitle: event.value));
  }

  _onJsonChangedEvent(HomeJsonChangedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(json: event.value));
  }

  _onDecodeJsonEvent(HomeDecodeJsonEvent event, Emitter<HomeState> emit) {
    final either = _homeRepository.decodeJson(state.json);
    either.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (colors) => emit(state.copyWith(colors: colors)),
    );
  }

  _onClearErrorEvent(HomeClearErrorEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(clearFailure: true));
  }

  FutureOr<void> _onCopyToClipboardEvent(
      HomeCopyToClipboardEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(showCopyMessage: true));
  }

  _onHideCopyMessageEvent(
      HomeHideCopyMessageEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(showCopyMessage: false));
  }

  FutureOr<void> _onCopyMaterialColorToClipboardEvent(
      HomeCopyMaterialColorToClipboardEvent event,
      Emitter<HomeState> emit) async {
    try {
      final colorTitle =
          state.colorTitle.isEmpty ? 'primary' : state.colorTitle;
      final lines = _homeRepository.toMaterialColor(state.colors, colorTitle);
      final string = lines.join('\n');
      await Clipboard.setData(ClipboardData(text: string));

      emit(state.copyWith(showCopyMessage: false));
    } catch (error) {
      emit(state.copyWith(
          failure: Failure(error.toString()), showCopyMessage: false));
    }
  }

  FutureOr<void> _onCopyListOfColorsToClipboardEvent(
      HomeCopyListOfColorsToClipboardEvent event,
      Emitter<HomeState> emit) async {
    try {
      final colorTitle =
          state.colorTitle.isEmpty ? 'primary' : state.colorTitle;
      final lines = _homeRepository.toListOfColors(state.colors, colorTitle);
      final string = lines.join('\n');
      await Clipboard.setData(ClipboardData(text: string));

      emit(state.copyWith(showCopyMessage: false));
    } catch (error) {
      emit(state.copyWith(
          failure: Failure(error.toString()), showCopyMessage: false));
    }
  }

  FutureOr<void> _onHexHasChangedEvent(
    HomeHexHasChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(hex: event.value));
  }

  FutureOr<void> _onDecodeColorEvent(
    HomeDecodeColorEvent event,
    Emitter<HomeState> emit,
  ) {
    final hex = state.hex;

    final either = _converter(hex);
    either.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (result) => emit(state.copyWith(
        selectedColor: hex.toColor(),
        variation: result,
      )),
    );
  }

  FutureOr<void> _onToggleStatusEvent(
    HomeToggleStatusEvent event,
    Emitter<HomeState> emit,
  ) {
    PalletStatus status;
    if (state.status == PalletStatus.display) {
      status = PalletStatus.preview;
    } else {
      status = PalletStatus.display;
    }
    emit(state.copyWith(status: status));
  }

  FutureOr<void> _onPrimaryStringChangedEvent(
    HomePrimaryColorChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final color = _repository.colorFromSource(event.value);
    if (color == null) {
      return null;
    }
    switch (event.type) {
      case ColorType.primary:
        emit(
          state.copyWith(
            primaryMaterialColor: color,
            lightColorScheme: state.lightColorScheme.copyWith(
              primary: color.shade500,
              onPrimary: color.shade50,
              primaryContainer: color.shade300,
              onPrimaryContainer: color.shade50,
              inversePrimary: color.shade700,
            ),
          ),
        );
      case ColorType.secondary:
        emit(
          state.copyWith(
            secondaryMaterialColor: color,
            lightColorScheme: state.lightColorScheme.copyWith(
              secondary: color.shade500,
              onSecondary: color.shade50,
              secondaryContainer: color.shade300,
              onSecondaryContainer: color.shade50,
            ),
          ),
        );
      case ColorType.tertiary:
        emit(
          state.copyWith(
            tertiaryMaterialColor: color,
            lightColorScheme: state.lightColorScheme.copyWith(
              tertiary: color.shade500,
              onTertiary: color.shade50,
              tertiaryContainer: color.shade300,
              onTertiaryContainer: color.shade50,
            ),
          ),
        );
      case ColorType.error:
        emit(
          state.copyWith(
            errorMaterialColor: color,
            lightColorScheme: state.lightColorScheme.copyWith(
              error: color.shade500,
              onError: color.shade50,
              errorContainer: color.shade300,
              onErrorContainer: color.shade50,
            ),
          ),
        );
      case ColorType.neutral:
        emit(
          state.copyWith(
            neutralMaterialColor: color,
            darkColorScheme: state.darkColorScheme.copyWith(
              scaffoldBackground: color.shade700,
              background: color.shade900,
              onBackground: color.shade50,
              surface: color.shade900,
              onSurface: color.shade50,
              surfaceVariant: color.shade500,
              onSurfaceVariant: color.shade900,
              outline: color.shade500,
              outlineVariant: color.shade500,
              shadow: color.shade900,
              scrim: color.shade900,
              inverseSurface: color.shade400,
            ),
          ),
        );
      case ColorType.neutralVariant:
        emit(
          state.copyWith(
            neutralVariantMaterialColor: color,
            lightColorScheme: state.lightColorScheme.copyWith(
              scaffoldBackground: color.shade50,
              background: color.shade100,
              onBackground: color.shade900,
              surface: color.shade200,
              onSurface: color.shade900,
              surfaceVariant: color.shade100,
              onSurfaceVariant: color.shade900,
              outline: color.shade700,
              outlineVariant: color.shade500,
              shadow: color.shade900,
              scrim: color.shade900,
              inverseSurface: color.shade700,
            ),
          ),
        );
    }
  }

  FutureOr<void> _onScaffoldColorChangedEvent(
    HomeScaffoldColorChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(
        state.copyWith(
          lightColorScheme: state.lightColorScheme.copyWith(
            scaffoldBackground: event.value,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          darkColorScheme: state.darkColorScheme.copyWith(
            scaffoldBackground: event.value,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onPrimaryChangedEvent(
    HomePrimaryChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          primary: combination.color,
          onPrimary: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          primary: combination.color,
          onPrimary: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onPrimaryContainerChangedEvent(
    HomePrimaryContainerChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          primaryContainer: combination.color,
          onPrimaryContainer: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          primaryContainer: combination.color,
          onPrimaryContainer: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onSecondaryChangedEvent(
    HomeSecondaryChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          secondary: combination.color,
          onSecondary: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          secondary: combination.color,
          onSecondary: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onSecondaryContainerChangedEvent(
    HomeSecondaryContainerChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          secondaryContainer: combination.color,
          onSecondaryContainer: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          secondaryContainer: combination.color,
          onSecondaryContainer: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onTertiaryChangedEvent(
    HomeTertiaryChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          tertiary: combination.color,
          onTertiary: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          tertiary: combination.color,
          onTertiary: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onTertiaryContainerChangedEvent(
    HomeTertiaryContainerChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          tertiaryContainer: combination.color,
          onTertiaryContainer: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          tertiaryContainer: combination.color,
          onTertiaryContainer: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onErrorChangedEvent(
    HomeErrorChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          error: combination.color,
          onError: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          error: combination.color,
          onError: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onErrorContainerChangedEvent(
    HomeErrorContainerChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          errorContainer: combination.color,
          onErrorContainer: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          errorContainer: combination.color,
          onErrorContainer: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onBackgroundChangedEvent(
    HomeBackgroundChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          background: combination.color,
          onBackground: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          background: combination.color,
          onBackground: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onSurfaceChangedEvent(
    HomeSurfaceChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          surface: combination.color,
          onSurface: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          surface: combination.color,
          onSurface: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onSurfaceVariantChangedEvent(
    HomeSurfaceVariantChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          surfaceVariant: combination.color,
          onSurfaceVariant: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          surfaceVariant: combination.color,
          onSurfaceVariant: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onOutLineChangedEvent(
    HomeOutLineChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          outline: combination.color,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          outline: combination.color,
        ),
      ));
    }
  }

  FutureOr<void> _onOutLineVariantChangedEvent(
    HomeOutLineVariantChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          outlineVariant: combination.color,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          outlineVariant: combination.color,
        ),
      ));
    }
  }

  FutureOr<void> _onInversePrimaryChangedEvent(
    HomeInversePrimaryChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          inversePrimary: combination.color,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          inversePrimary: combination.color,
        ),
      ));
    }
  }

  FutureOr<void> _onInverseSurfaceChangedEvent(
    HomeInverseSurfaceChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          inverseSurface: combination.color,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          inverseSurface: combination.color,
        ),
      ));
    }
  }

  FutureOr<void> _onAppBarChangedEvent(
    HomeAppBarChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          appBar: combination.color,
          onAppBar: combination.onColor,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          appBar: combination.color,
          onAppBar: combination.onColor,
        ),
      ));
    }
  }

  FutureOr<void> _onShadowChangedEvent(
    HomeShadowChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final combination = state.combinationFromVariant(event.variant);
    final brightness = event.brightness;
    if (brightness == Brightness.light) {
      emit(state.copyWith(
        lightColorScheme: state.lightColorScheme.copyWith(
          shadow: combination.color,
        ),
      ));
    } else {
      emit(state.copyWith(
        darkColorScheme: state.darkColorScheme.copyWith(
          shadow: combination.color,
        ),
      ));
    }
  }

  FutureOr<void> _onCopyPalletToClipboardEvent(
    HomeCopyPalletToClipboardEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isClipping) {
      return null;
    }

    emit(state.copyWith(isClipping: true));
    final lines = state.toClipboard();
    final string = lines.join('\n');
    await Clipboard.setData(ClipboardData(text: string));
    emit(state.copyWith(isClipping: false, showClipMessage: true));
    // final success = await _repository.writeFile(string);
    // if (success) {
    //   emit(state.copyWith(isClipping: false, showClipMessage: true));
    // } else {
    //   emit(state.copyWith(
    //     failure: const Failure('Some thing bad happened'),
    //     isClipping: false,
    //   ));
    // }
    /// you have to add these to macos/runner/DebugProfile.entitlements
    // <key>com.apple.security.network.client</key>
    // <true/>
    // <key>com.apple.security.app-sandbox</key>
    // <false/>
  }

  FutureOr<void> _onHideClipMessageEvent(
    HomeHideClipMessageEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(showClipMessage: false));
  }
}
