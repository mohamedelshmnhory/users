import 'package:flutter/material.dart';
import 'package:users/core/resources.dart';

import '../../utils/debouncer.dart';
import 'text_fields/app_loading.dart';

class PaginationList extends StatefulWidget {
  final Function()? onReachBottom;
  final bool reachedMax;
  final int itemCount;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  final ScrollController? scrollController;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget? separator;
  final bool gridView;
  final bool horizontal;
  const PaginationList({
    Key? key,
    required this.itemCount,
    this.onReachBottom,
    this.padding,
    this.scrollController,
    this.shrinkWrap = false,
    this.reachedMax = false,
    this.gridView = false,
    this.horizontal = false,
    required this.itemBuilder,
    this.separator,
  }) : super(key: key);

  @override
  _PaginationListState createState() => _PaginationListState();
}

class _PaginationListState extends State<PaginationList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(debounce(_onScroll, 300));
  }

  void _onScroll() async {
    if (_isBottom && !widget.reachedMax) {
      if (widget.onReachBottom != null) widget.onReachBottom!();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.70);
  }

  @override
  Widget build(BuildContext context) {
    int length = widget.reachedMax == true ? 0 : 1;
    if (!widget.gridView) {
      return ListView.separated(
        scrollDirection: widget.horizontal ? Axis.horizontal : Axis.vertical,
        itemCount: widget.itemCount + length,
        controller: widget.scrollController != null ? null : _scrollController,
        physics: widget.scrollController != null ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding ?? const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
        separatorBuilder: (_, i) => widget.separator ?? 5.heightBox(),
        itemBuilder: (context, index) {
          if (index == widget.itemCount) {
            return const AppLoadingWidget();
          }
          return widget.itemBuilder(context, index);
        },
      );
    } else {
      return GridView.builder(
        itemCount: widget.itemCount + length,
        controller: widget.scrollController != null ? null : _scrollController,
        physics: widget.scrollController != null ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding ?? const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
        itemBuilder: (context, index) {
          if (index == widget.itemCount) {
            return const Center(
              child: AppLoadingWidget(),
            );
          }
          return widget.itemBuilder(context, index);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2 / 3,
          crossAxisCount: 2,
        ),
      );
    }
  }
}
