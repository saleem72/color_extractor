//

import 'dart:async';

import 'package:color_extractor/core/domain/errors/failure.dart';
import 'package:color_extractor/core/domain/models/material_color_source.dart';
import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:color_extractor/features/home_screen/data/repository/pallet_repository.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_combination.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_scheme_holder.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_variant.dart';
import 'package:color_extractor/features/home_screen/domain/models/pallet_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pallet_event.dart';
part 'pallet_state.dart';

class PalletBloc extends Bloc<PalletEvent, PalletState> {
  final PalletRepository _repository;
  PalletBloc({
    required PalletRepository repository,
  })  : _repository = repository,
        super(PalletState.initial()) {
    on<PalletToggleStatusEvent>(_onToggleStatusEvent);
    on<PalletPrimaryColorChangedEvent>(_onPrimaryStringChangedEvent);
    on<PalletScaffoldColorChangedEvent>(_onScaffoldColorChangedEvent);
    on<PalletPrimaryChangedEvent>(_onPrimaryChangedEvent);
    on<PalletPrimaryContainerChangedEvent>(_onPrimaryContainerChangedEvent);
    on<PalletSecondaryChangedEvent>(_onSecondaryChangedEvent);
    on<PalletSecondaryContainerChangedEvent>(_onSecondaryContainerChangedEvent);
    on<PalletTertiaryChangedEvent>(_onTertiaryChangedEvent);
    on<PalletTertiaryContainerChangedEvent>(_onTertiaryContainerChangedEvent);
    on<PalletErrorChangedEvent>(_onErrorChangedEvent);
    on<PalletErrorContainerChangedEvent>(_onErrorContainerChangedEvent);
    on<PalletBackgroundChangedEvent>(_onBackgroundChangedEvent);
    on<PalletSurfaceChangedEvent>(_onSurfaceChangedEvent);
    on<PalletSurfaceVariantChangedEvent>(_onSurfaceVariantChangedEvent);
    on<PalletOutLineChangedEvent>(_onOutLineChangedEvent);
    on<PalletOutLineVariantChangedEvent>(_onOutLineVariantChangedEvent);
    on<PalletInversePrimaryChangedEvent>(_onInversePrimaryChangedEvent);
    on<PalletInverseSurfaceChangedEvent>(_onInverseSurfaceChangedEvent);
    on<PalletAppBarChangedEvent>(_onAppBarChangedEvent);
    on<PalletShadowChangedEvent>(_onShadowChangedEvent);
    on<PalletCopyToClipboardEvent>(_onCopyToClipboardEvent);
    on<PalletHideClipMessageEvent>(_onHideClipMessageEvent);
    on<PalletClearFailureEvent>(_onClearFailureEvent);
  }

  FutureOr<void> _onToggleStatusEvent(
    PalletToggleStatusEvent event,
    Emitter<PalletState> emit,
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
    PalletPrimaryColorChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletScaffoldColorChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletPrimaryChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletPrimaryContainerChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletSecondaryChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletSecondaryContainerChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletTertiaryChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletTertiaryContainerChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletErrorChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletErrorContainerChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletBackgroundChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletSurfaceChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletSurfaceVariantChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletOutLineChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletOutLineVariantChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletInversePrimaryChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletInverseSurfaceChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletAppBarChangedEvent event,
    Emitter<PalletState> emit,
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
    PalletShadowChangedEvent event,
    Emitter<PalletState> emit,
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

  FutureOr<void> _onCopyToClipboardEvent(
    PalletCopyToClipboardEvent event,
    Emitter<PalletState> emit,
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
    PalletHideClipMessageEvent event,
    Emitter<PalletState> emit,
  ) {
    emit(state.copyWith(showClipMessage: false));
  }

  FutureOr<void> _onClearFailureEvent(
    PalletClearFailureEvent event,
    Emitter<PalletState> emit,
  ) {
    emit(state.copyWith(clearFailure: true));
  }
}
