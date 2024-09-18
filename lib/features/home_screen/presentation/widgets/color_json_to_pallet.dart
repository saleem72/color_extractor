//

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/core/presentation/widgets/app_text_field.dart';
import 'package:color_extractor/core/presentation/widgets/failure_view.dart';
import 'package:color_extractor/features/home_screen/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_color_card.dart';
import 'copy_message_view.dart';

class ColorJsonToPallet extends StatelessWidget {
  const ColorJsonToPallet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            _mainContent(context, state),
            FailureView(
              failure: state.failure,
              onClearError: () =>
                  context.read<HomeBloc>().add(HomeClearErrorEvent()),
            ),
            CopyMessageView(show: state.showCopyMessage),
          ],
        );
      },
    );
  }

  Widget _mainContent(BuildContext context, HomeState state) {
    return Column(
      children: [
        SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () =>
                    context.read<HomeBloc>().add(HomeDecodeJsonEvent()),
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              IconButton(
                onPressed: () =>
                    context.read<HomeBloc>().add(HomeCopyToClipboardEvent()),
                icon: Icon(
                  Icons.copy,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: 250,
                child: _inputSection(context),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.colors.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final color = state.colors[index];
                    return AppColorCard(color: color);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _inputSection(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return Column(
      children: [
        AppTextField(
          controller: bloc.colorTitle,
          backgroundColor: context.colorScheme.primaryContainer,
          onChanged: (value) => (value) => context
              .read<HomeBloc>()
              .add(HomeColorTitleChangedEvent(value: value)),
          hint: 'Color title',
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8, top: 8),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: bloc.json,
              maxLines: null,
              expands: true,
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.onPrimaryContainer,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Paste your json color',
                hintStyle: context.textTheme.titleSmall?.copyWith(
                  color:
                      context.colorScheme.onPrimaryContainer.withOpacity(0.6),
                ),
              ),
              onChanged: (value) => context
                  .read<HomeBloc>()
                  .add(HomeJsonChangedEvent(value: value)),
            ),
          ),
        ),
      ],
    );
  }
}
