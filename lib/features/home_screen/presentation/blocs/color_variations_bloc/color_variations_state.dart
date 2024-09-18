// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'color_variations_bloc.dart';

class ColorVariationsState extends Equatable {
  final Color selectedColor;
  final ColorDecodeResult? variation;
  final String hex;
  final Failure? failure;
  const ColorVariationsState({
    required this.selectedColor,
    required this.hex,
    required this.failure,
    required this.variation,
  });

  @override
  List<Object?> get props => [selectedColor, hex, failure, variation];

  factory ColorVariationsState.initial() => const ColorVariationsState(
        selectedColor: Colors.grey,
        hex: '',
        failure: null,
        variation: null,
      );

  ColorVariationsState copyWith({
    Color? selectedColor,
    String? hex,
    Failure? failure,
    ColorDecodeResult? variation,
    bool clearFailure = false,
  }) {
    return ColorVariationsState(
      hex: hex ?? this.hex,
      selectedColor: selectedColor ?? this.selectedColor,
      failure: clearFailure ? null : failure ?? this.failure,
      variation: variation ?? this.variation,
    );
  }
}
