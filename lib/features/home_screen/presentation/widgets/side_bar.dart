//

import 'package:color_extractor/features/home_screen/domain/models/home_view.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    required this.onViewChange,
  });

  final Function(HomeView view) onViewChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          const SizedBox(height: 16),
          IconButton(
            onPressed: () => onViewChange(HomeView.json),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => onViewChange(HomeView.pallet),
            icon: const Icon(Icons.color_lens),
          ),
          IconButton(
            onPressed: () => onViewChange(HomeView.colorPicker),
            icon: const Icon(Icons.color_lens),
          ),
        ],
      ),
    );
  }
}
