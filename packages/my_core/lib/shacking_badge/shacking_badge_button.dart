//

import 'package:flutter/material.dart';

import 'shacking_badge_widget.dart';

class ShackingBadgeButton extends StatelessWidget {
  const ShackingBadgeButton({
    super.key,
    required this.onPressed,
    required this.count,
    required this.icon,
    this.textStyle,
    this.duration,
    this.rounds,
    this.splashColor,
    this.offset,
  });
  final Function() onPressed;
  final int count;
  final Widget icon;
  final TextStyle? textStyle;
  final Duration? duration;
  final int? rounds;
  final Color? splashColor;
  final Offset? offset;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        splashColor: splashColor ?? Colors.grey.shade200,
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          height: 44,
          width: 44,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: icon,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Transform.translate(
                  offset: offset ?? const Offset(0, 0),
                  child: ShackingBadgeWidget(
                    count: count,
                    style: textStyle,
                    duration: duration ?? const Duration(milliseconds: 1000),
                    rounds: rounds ?? 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
