//

import 'package:color_extractor/features/home_screen/domain/models/color_rgb_with_name.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:color_extractor/features/home_screen/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPopupMenu extends StatelessWidget {
  const AppPopupMenu({
    super.key,
    required this.rgbColor,
  });
  final ColorRGBWithName rgbColor;
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
          tooltip: 'Show menu',
        );
      },
      menuChildren: ColorType.values
          .map((e) => MenuItemButton(
                onPressed: () =>
                    context.read<HomeBloc>().add(HomeSetMainColorEvent(
                          type: e,
                          value: rgbColor.toMaterialColor(),
                        )),
                child: Text(e.title),
              ))
          .toList(),
    );
  }
}
