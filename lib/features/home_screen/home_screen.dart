//

import 'package:color_extractor/features/home_screen/domain/models/home_view.dart';
import 'package:color_extractor/features/home_screen/presentation/widgets/color_json_to_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/blocs/home_bloc/home_bloc.dart';
import 'presentation/widgets/color_variations_view.dart';
import 'presentation/widgets/pallet_view.dart';
import 'presentation/widgets/side_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  HomeView _selectedView = HomeView.json;
  @override
  Widget build(BuildContext context) {
    return _mainScaffold(context);
  }

  Widget _mainScaffold(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SideBar(
              onViewChange: (view) => setState(() {
                _selectedView = view;
              }),
            ),
            Expanded(
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: switch (_selectedView) {
                    HomeView.json => const ColorJsonToPallet(
                        key: ValueKey('home_json_view'),
                      ),
                    HomeView.pallet => const PalletView(
                        key: ValueKey('home_pallet_view'),
                      ),
                    HomeView.colorPicker => const ColorVariationsView(
                        key: ValueKey('color_variation_view'),
                      ),
                  }),
            )
          ],
        ),
      ),
    );
  }
}
