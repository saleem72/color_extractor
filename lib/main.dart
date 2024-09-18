import 'package:color_extractor/features/home_screen/data/helpers/string_to_color.dart';
import 'package:color_extractor/features/home_screen/data/repository/home_repository.dart';
import 'package:color_extractor/features/home_screen/data/repository/pallet_repository.dart';
import 'package:color_extractor/features/home_screen/home_screen.dart';
import 'package:color_extractor/features/home_screen/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            homeRepository: HomeRepository(),
            palletRepository: PalletRepository(),
            converter: StringToColor(),
          ),
        ),
      ],
      child: const ColorExtractorApp(),
    );
  }
}

class ColorExtractorApp extends StatelessWidget {
  const ColorExtractorApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
