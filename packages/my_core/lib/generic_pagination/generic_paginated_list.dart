//

import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class GenericPaginatedList extends StatefulWidget {
  const GenericPaginatedList({
    super.key,
    required this.itemCount,
    required this.hasMorePages,
    required this.itemBuilder,
    required this.onPagination,
    required this.isPaginating,
    this.paginatingIndicator,
    this.padding,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool hasMorePages;
  final Function() onPagination;
  final bool isPaginating;
  final Widget? paginatingIndicator;
  final EdgeInsetsGeometry? padding;

  @override
  State<GenericPaginatedList> createState() => _GenericPaginatedListState();
}

class _GenericPaginatedListState extends State<GenericPaginatedList> {
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
      _requestMore();
    }
  }

  _requestMore() {
    if (widget.hasMorePages) {
      widget.onPagination();
    } else {
      developer.log('we reach End');
    }
  }

  @override
  void didUpdateWidget(covariant GenericPaginatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaginating == true && oldWidget.isPaginating == false) {
      _controller.animateTo(
        _controller.position.extentTotal,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _controller,
      padding: widget.padding,
      itemCount: widget.isPaginating ? widget.itemCount + 1 : widget.itemCount,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (context, index) {
        // if (index == widget.itemCount - 1) {
        //   _requestMore();
        // }
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
