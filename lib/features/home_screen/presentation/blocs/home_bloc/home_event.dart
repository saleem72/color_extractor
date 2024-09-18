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

class HomeHexHasChangedEvent extends HomeEvent {
  final String value;
  const HomeHexHasChangedEvent({
    required this.value,
  });
}

class HomeDecodeColorEvent extends HomeEvent {}

class HomePrimaryColorChangedEvent extends HomeEvent {
  final MaterialColorSource value;
  final ColorType type;
  const HomePrimaryColorChangedEvent({
    required this.value,
    required this.type,
  });
}

class HomeScaffoldColorChangedEvent extends HomeEvent {
  final Brightness brightness;
  final Color value;
  const HomeScaffoldColorChangedEvent({
    required this.value,
    required this.brightness,
  });
}

class HomePrimaryChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomePrimaryChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomePrimaryContainerChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomePrimaryContainerChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeSecondaryChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeSecondaryChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeSecondaryContainerChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeSecondaryContainerChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeTertiaryChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeTertiaryChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeTertiaryContainerChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeTertiaryContainerChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeErrorChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeErrorChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeErrorContainerChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeErrorContainerChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeBackgroundChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeBackgroundChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeSurfaceChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeSurfaceChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeSurfaceVariantChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeSurfaceVariantChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeOutLineChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeOutLineChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeOutLineVariantChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeOutLineVariantChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeInversePrimaryChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeInversePrimaryChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeInverseSurfaceChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeInverseSurfaceChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeAppBarChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeAppBarChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeShadowChangedEvent extends HomeEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const HomeShadowChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class HomeToggleStatusEvent extends HomeEvent {}

class HomeCopyPalletToClipboardEvent extends HomeEvent {}

class HomeHideClipMessageEvent extends HomeEvent {}
