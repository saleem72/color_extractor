// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String colorTitle;
  final String json;
  final List<AppColor> colors;
  final Failure? failure;
  final bool showCopyMessage;

  const HomeState({
    required this.colorTitle,
    required this.json,
    required this.colors,
    required this.failure,
    required this.showCopyMessage,
  });

  factory HomeState.initial() => const HomeState(
        colorTitle: '',
        json: '',
        colors: [],
        failure: null,
        showCopyMessage: false,
      );

  @override
  List<Object?> get props =>
      [colorTitle, json, colors, failure, showCopyMessage];

  HomeState copyWith({
    String? colorTitle,
    String? json,
    List<AppColor>? colors,
    Failure? failure,
    bool clearFailure = false,
    bool? showCopyMessage,
  }) {
    return HomeState(
      colorTitle: colorTitle ?? this.colorTitle,
      json: json ?? this.json,
      colors: colors ?? this.colors,
      failure: clearFailure ? null : failure ?? this.failure,
      showCopyMessage: showCopyMessage ?? this.showCopyMessage,
    );
  }
}
