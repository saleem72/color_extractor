//

import 'package:color_extractor/core/presentation/widgets/color_widget.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:color_extractor/features/home_screen/presentation/blocs/pallet_bloc/pallet_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PalletRowView extends StatefulWidget {
  const PalletRowView({
    super.key,
  });

  @override
  State<PalletRowView> createState() => _PalletRowViewState();
}

class _PalletRowViewState extends State<PalletRowView> {
  late TextEditingController _primary;
  late TextEditingController _secondary;
  late TextEditingController _tertiary;
  late TextEditingController _error;
  late TextEditingController _neutral;
  late TextEditingController _neutralVariant;

  @override
  void initState() {
    super.initState();
    _primary = TextEditingController(text: '#90c44b');
    _secondary = TextEditingController(text: '#919f87');
    _tertiary = TextEditingController(text: '#54c4d4');
    _error = TextEditingController(text: '#f64234');
    _neutral = TextEditingController(text: '#b1aeb3');
    _neutralVariant = TextEditingController(text: '#b1b3ae');
  }

  @override
  void dispose() {
    _primary.dispose();
    _secondary.dispose();
    _tertiary.dispose();
    _error.dispose();
    _neutral.dispose();
    _neutralVariant.dispose();
    super.dispose();
  }

  // primaryString: '#90c44b',
  // secondaryString: '#919f87',
  // tertiaryString: '#54c4d4',
  // errorString: '#f64234',
  // neutralVariantString: '#b1aeb3',
  // neutralString: '#b1b3ae',
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PalletBloc, PalletState>(
      builder: (context, state) {
        return _buildWidget(context, state);
      },
    );
  }

  Widget _buildWidget(BuildContext context, PalletState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ColorWidget(
          controller: _primary,
          color: state.primaryMaterialColor,
          type: ColorType.primary,
          onColorChange: (value) =>
              context.read<PalletBloc>().add(PalletPrimaryColorChangedEvent(
                    value: value,
                    type: ColorType.primary,
                  )),
        ),
        ColorWidget(
          controller: _secondary,
          color: state.secondaryMaterialColor,
          type: ColorType.secondary,
          onColorChange: (value) =>
              context.read<PalletBloc>().add(PalletPrimaryColorChangedEvent(
                    value: value,
                    type: ColorType.secondary,
                  )),
        ),
        ColorWidget(
          controller: _tertiary,
          color: state.tertiaryMaterialColor,
          type: ColorType.tertiary,
          onColorChange: (value) =>
              context.read<PalletBloc>().add(PalletPrimaryColorChangedEvent(
                    value: value,
                    type: ColorType.tertiary,
                  )),
        ),
        ColorWidget(
          controller: _error,
          color: state.errorMaterialColor,
          type: ColorType.error,
          onColorChange: (value) =>
              context.read<PalletBloc>().add(PalletPrimaryColorChangedEvent(
                    value: value,
                    type: ColorType.error,
                  )),
        ),
        ColorWidget(
          controller: _neutral,
          color: state.neutralMaterialColor,
          type: ColorType.neutral,
          onColorChange: (value) =>
              context.read<PalletBloc>().add(PalletPrimaryColorChangedEvent(
                    value: value,
                    type: ColorType.neutral,
                  )),
        ),
        ColorWidget(
          controller: _neutralVariant,
          color: state.neutralVariantMaterialColor,
          type: ColorType.neutralVariant,
          onColorChange: (value) =>
              context.read<PalletBloc>().add(PalletPrimaryColorChangedEvent(
                    value: value,
                    type: ColorType.neutralVariant,
                  )),
        ),
      ],
    );
  }
}
