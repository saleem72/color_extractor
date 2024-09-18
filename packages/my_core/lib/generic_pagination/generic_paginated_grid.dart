//

// import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class GenericPaginatedGrid extends StatefulWidget {
  const GenericPaginatedGrid({
    super.key,
    required this.gridDelegate,
    required this.itemCount,
    required this.hasMorePages,
    required this.itemBuilder,
    required this.onPagination,
    required this.isPaginating,
    this.paginatingIndicator,
    this.padding,
  });
  final SliverGridDelegate gridDelegate;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool hasMorePages;
  final Function() onPagination;
  final bool isPaginating;
  final Widget? paginatingIndicator;
  final EdgeInsetsGeometry? padding;

  @override
  State<GenericPaginatedGrid> createState() => _GenericPaginatedGridState();
}

class _GenericPaginatedGridState extends State<GenericPaginatedGrid> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_listenToScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_listenToScroll);
    _controller.dispose();
    super.dispose();
  }

  void _listenToScroll() {
    if (_controller.position.maxScrollExtent == _controller.offset) {
      if (widget.hasMorePages) {
        widget.onPagination();
      }
    }
  }

  @override
  void didUpdateWidget(covariant GenericPaginatedGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaginating == true && oldWidget.isPaginating == false) {
      _controller.animateTo(
        _controller.position.extentTotal,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: widget.padding,
      gridDelegate: widget.gridDelegate,
      controller: _controller,
      itemCount: widget.isPaginating ? widget.itemCount + 1 : widget.itemCount,
      itemBuilder: (context, index) {
        if (index == widget.itemCount) {
          return widget.paginatingIndicator ??
              const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
        }
        return widget.itemBuilder(context, index);
      },
    );
  }
}
