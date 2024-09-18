// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pallet_bloc.dart';

sealed class PalletEvent extends Equatable {
  const PalletEvent();

  @override
  List<Object> get props => [];
}

class PalletPrimaryColorChangedEvent extends PalletEvent {
  final MaterialColorSource value;
  final ColorType type;
  const PalletPrimaryColorChangedEvent({
    required this.value,
    required this.type,
  });
}

class PalletScaffoldColorChangedEvent extends PalletEvent {
  final Brightness brightness;
  final Color value;
  const PalletScaffoldColorChangedEvent({
    required this.value,
    required this.brightness,
  });
}

class PalletPrimaryChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletPrimaryChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletPrimaryContainerChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletPrimaryContainerChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletSecondaryChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletSecondaryChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletSecondaryContainerChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletSecondaryContainerChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletTertiaryChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletTertiaryChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletTertiaryContainerChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletTertiaryContainerChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletErrorChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletErrorChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletErrorContainerChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletErrorContainerChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletBackgroundChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletBackgroundChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletSurfaceChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletSurfaceChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletSurfaceVariantChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletSurfaceVariantChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletOutLineChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletOutLineChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletOutLineVariantChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletOutLineVariantChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletInversePrimaryChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletInversePrimaryChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletInverseSurfaceChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletInverseSurfaceChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletAppBarChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletAppBarChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletShadowChangedEvent extends PalletEvent {
  final Brightness brightness;
  final ColorVariant variant;
  const PalletShadowChangedEvent({
    required this.variant,
    required this.brightness,
  });
}

class PalletToggleStatusEvent extends PalletEvent {}

class PalletCopyToClipboardEvent extends PalletEvent {}

class PalletHideClipMessageEvent extends PalletEvent {}

class PalletClearFailureEvent extends PalletEvent {}
