//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RGBColorTile extends StatelessWidget {
  const RGBColorTile({
    super.key,
    required this.isSelected,
    required this.color,
    required this.hex,
    required this.label,
    required this.showValues,
  });

  final bool isSelected;
  final Color color;
  final String hex;
  final String label;
  final bool showValues;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: color,
                shape: isSelected ? BoxShape.circle : BoxShape.rectangle,
              ),
            ),
          ),
        ),
        showValues ? Text(label) : const SizedBox.shrink(),
      ],
    );
  }
}
