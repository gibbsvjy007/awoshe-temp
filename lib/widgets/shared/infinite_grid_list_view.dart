import 'package:flutter/material.dart';

class InfiniteGridListView extends StatefulWidget {
  final ScrollController scrollController;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback onEndReached;
  final double endOffset;
  final int itemCount;
  final bool reverse;
  final EdgeInsets listPadding;
  final bool shrinkWrap;

  const InfiniteGridListView({
    Key key,
    this.scrollController,
    @required this.itemBuilder,
    this.endOffset = 0.0,
    this.reverse = false,
    @required this.onEndReached,
    @required this.itemCount,
    this.shrinkWrap,
    this.listPadding = const EdgeInsets.only(bottom: 50.0),
  }) : super(key: key);

  @override
  _InfiniteGridListViewState createState() => _InfiniteGridListViewState();
}

class _InfiniteGridListViewState extends State<InfiniteGridListView> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.scrollController ?? ScrollController();

    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: widget.listPadding,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: widget.itemBuilder,
      controller: _controller,
      itemCount: widget.itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height * 0.80),
          crossAxisCount: 2),
    );
  }

  void _onScroll() {
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.position.pixels;
    if (maxScroll - currentScroll <= widget.endOffset) {
      widget.onEndReached();
    }
  }
}
