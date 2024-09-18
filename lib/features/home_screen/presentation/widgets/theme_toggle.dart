//

import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<ThemeCubit, ThemeMode>(
    //   builder: (context, state) {
    return Switch(
        value: true,
        onChanged: (value) {
          // context.read<ThemeCubit>().setTheme(value);
        });
    //   },
    // );
  }
}
