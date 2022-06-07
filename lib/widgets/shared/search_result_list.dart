import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/material.dart';

class SearchResultsList extends StatelessWidget {
  final bool loading;
  final int itemCount;
  final ScrollController scrollController;
  final Widget noResultsWidget;
  final Function(BuildContext context, int index) itemBuilder;

  const SearchResultsList(
      {Key key,
        this.loading = false,
        this.itemBuilder,
        this.itemCount,
        this.scrollController,
        this.noResultsWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: AwosheLoadingV2(
          innerColor: primaryColor,
          outerColor: primaryColor,
        ),
      );
    }

    if (!loading && itemCount == 0 && noResultsWidget != null) {
      return noResultsWidget;
    }

    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController ?? ScrollController(),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
