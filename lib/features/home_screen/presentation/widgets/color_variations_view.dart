//
import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/features/home_screen/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_core/views/failure_view.dart';

import 'color_variation_card.dart';

class ColorVariationsView extends StatelessWidget {
  const ColorVariationsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            _buildContent(context, state),
            FailureView(
              failure: state.failure,
              onClose: () =>
                  context.read<HomeBloc>().add(HomeClearErrorEvent()),
            )
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    final bloc = context.read<HomeBloc>();
    final variation = state.variation;
    return Row(
      children: [
        Expanded(
          child: variation == null
              ? const SizedBox.shrink()
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      ColorVariationCard(variation: variation),
                    ],
                  ),
                ),
        ),
        SizedBox(
          width: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: bloc.hexInput,
                  onChanged: (value) => context
                      .read<HomeBloc>()
                      .add(HomeHexHasChangedEvent(value: value)),
                  decoration: InputDecoration(
                    hintText: 'enter you color as hex number',
                    hintStyle: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () =>
                    context.read<HomeBloc>().add(HomeDecodeColorEvent()),
                child: const Text('Decode'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
