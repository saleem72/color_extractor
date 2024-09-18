//

import 'dart:math';

import 'package:flutter/material.dart';

class ShackingBadgeWidget extends StatefulWidget {
  const ShackingBadgeWidget({
    super.key,
    required this.count,
    required this.duration,
    required this.rounds,
    this.style,
  });
  final int count;
  final TextStyle? style;
  final Duration duration;
  final int rounds;

  @override
  State<ShackingBadgeWidget> createState() => _ShackingBadgeWidgetState();
}

class _ShackingBadgeWidgetState extends State<ShackingBadgeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _offset =
        Tween<double>(begin: 0, end: widget.rounds.toDouble()).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _getOffset(double animation) {
    return Offset(3 * sin(animation * 2 * pi), 0);
  }

  @override
  void didUpdateWidget(covariant ShackingBadgeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.translate(
          offset: _getOffset(_offset.value),
          child: child,
        );
      },
      child: _buildWidget(),
    );
  }

  Container _buildWidget() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Text(
        widget.count.toString(),
        style: widget.style,
      ),
    );
  }
}
