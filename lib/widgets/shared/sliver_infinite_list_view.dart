import 'package:flutter/material.dart';

class SliverInfiniteListView extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback onEndReached;
  final double endOffset;
  final EdgeInsets listPadding;
  final List<Widget> slivers;
  final Widget appbar;
  const SliverInfiniteListView({
    Key key,
    this.scrollController,
    this.endOffset = 0.0,
    this.slivers,
    this.appbar,
    @required this.onEndReached,
    this.listPadding = const EdgeInsets.only(bottom: 50.0),
  }) : super(key: key);
  @override
  _SliverInfiniteListViewState createState() => _SliverInfiniteListViewState();
}

class _SliverInfiniteListViewState extends State<SliverInfiniteListView> {
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
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget> [
        widget.appbar ?? SliverToBoxAdapter(),
        for (Widget w in widget.slivers)
          SliverToBoxAdapter(child: w)
      ],
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
