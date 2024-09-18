//

import 'package:color_extractor/core/domain/models/app_color.dart';
import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class AppColorCard extends StatelessWidget {
  const AppColorCard({
    super.key,
    required this.color,
  });

  final AppColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              color: color.color,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  color.hex,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.black,
                  ),
                ),
                Text(
                  color.rgb,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      color.token,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      color.value.toString(),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
