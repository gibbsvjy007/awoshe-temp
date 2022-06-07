import 'package:flutter/material.dart';

class InfiniteListView extends StatefulWidget {
  final ScrollController scrollController;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback onEndReached;
  final double endOffset;
  final int itemCount;
  final bool reverse;
  final EdgeInsets listPadding;

  const InfiniteListView({
    Key key,
    this.scrollController,
    @required this.itemBuilder,
    this.endOffset = 0.0,
    this.reverse = false,
    @required this.onEndReached,
    @required this.itemCount,
    this.listPadding = const EdgeInsets.only(bottom: 50.0),
  }) : super(key: key);
  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
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
    return ListView.builder(
      padding: widget.listPadding,
      reverse: widget.reverse,
      itemBuilder: widget.itemBuilder,
      controller: _controller,
      itemCount: widget.itemCount,
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
