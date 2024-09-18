// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeColorTitleChangedEvent extends HomeEvent {
  final String value;
  const HomeColorTitleChangedEvent({
    required this.value,
  });
}

class HomeJsonChangedEvent extends HomeEvent {
  final String value;
  const HomeJsonChangedEvent({
    required this.value,
  });
}

class HomeDecodeJsonEvent extends HomeEvent {}

class HomeClearErrorEvent extends HomeEvent {}

class HomeCopyToClipboardEvent extends HomeEvent {}

class HomeCopyMaterialColorToClipboardEvent extends HomeEvent {}

class HomeCopyListOfColorsToClipboardEvent extends HomeEvent {}

class HomeHideCopyMessageEvent extends HomeEvent {}
