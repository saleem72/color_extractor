//

import 'dart:async';

import 'package:color_extractor/core/domain/errors/failure.dart';
import 'package:color_extractor/core/domain/models/app_color.dart';
import 'package:color_extractor/features/home_screen/data/repository/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository = HomeRepository();
  HomeBloc() : super(HomeState.initial()) {
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
  }

  _onColorTitleChangedEvent(
      HomeColorTitleChangedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(colorTitle: event.value));
  }

  _onJsonChangedEvent(HomeJsonChangedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(json: event.value));
  }

  _onDecodeJsonEvent(HomeDecodeJsonEvent event, Emitter<HomeState> emit) {
    final either = _repository.decodeJson(state.json);
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
      final lines = _repository.toMaterialColor(state.colors, colorTitle);
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
      final lines = _repository.toListOfColors(state.colors, colorTitle);
      final string = lines.join('\n');
      await Clipboard.setData(ClipboardData(text: string));

      emit(state.copyWith(showCopyMessage: false));
    } catch (error) {
      emit(state.copyWith(
          failure: Failure(error.toString()), showCopyMessage: false));
    }
  }
}
