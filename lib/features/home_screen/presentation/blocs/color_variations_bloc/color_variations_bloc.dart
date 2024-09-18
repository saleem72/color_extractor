//

import 'dart:async';

import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:color_extractor/features/home_screen/data/helpers/string_to_color.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_decode_result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_core/my_core.dart';

part 'color_variations_event.dart';
part 'color_variations_state.dart';

class ColorVariationsBloc
    extends Bloc<ColorVariationsEvent, ColorVariationsState> {
  final TextEditingController hexInput = TextEditingController();
  final StringToColor _converter;

  ColorVariationsBloc({
    required StringToColor converter,
  })  : _converter = converter,
        super(ColorVariationsState.initial()) {
    on<ColorVariationsHexHasChangedEvent>(_onHexHasChangedEvent);
    on<ColorVariationsDecodeColorEvent>(_onDecodeColorEvent);
    on<ColorVariationsClearFailureEvent>(_onClearFailureEvent);
  }

  @override
  Future<void> close() {
    hexInput.dispose();
    return super.close();
  }

  FutureOr<void> _onHexHasChangedEvent(
    ColorVariationsHexHasChangedEvent event,
    Emitter<ColorVariationsState> emit,
  ) {
    emit(state.copyWith(hex: event.value));
  }

  FutureOr<void> _onDecodeColorEvent(
    ColorVariationsDecodeColorEvent event,
    Emitter<ColorVariationsState> emit,
  ) {
    final hex = state.hex;

    final either = _converter(hex);
    either.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (result) => emit(state.copyWith(
        selectedColor: hex.toColorLocal(),
        variation: result,
      )),
    );
  }

  FutureOr<void> _onClearFailureEvent(
    ColorVariationsClearFailureEvent event,
    Emitter<ColorVariationsState> emit,
  ) {
    emit(state.copyWith(clearFailure: true));
  }
}
