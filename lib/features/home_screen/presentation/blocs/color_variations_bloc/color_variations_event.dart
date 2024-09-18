// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'color_variations_bloc.dart';

sealed class ColorVariationsEvent extends Equatable {
  const ColorVariationsEvent();

  @override
  List<Object> get props => [];
}

class ColorVariationsHexHasChangedEvent extends ColorVariationsEvent {
  final String value;
  const ColorVariationsHexHasChangedEvent({
    required this.value,
  });
}

class ColorVariationsDecodeColorEvent extends ColorVariationsEvent {}

class ColorVariationsClearFailureEvent extends ColorVariationsEvent {}
