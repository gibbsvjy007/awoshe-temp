import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/category/category_store.dart';
import 'package:Awoshe/logic/stores/feeds/feeds_store.dart';
import 'package:Awoshe/pages/category/category.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:provider/provider.dart';

// if isSeeAll == true then we must provide a value for categoryName property
// if isSeeAll == false then we must provide a value for heading property
class CategoryHeader extends StatelessWidget {
  final String heading;
  final bool isSeeAll;
  final String categoryName;
  final FeedsStore feedsStore;
  final bool enableHeaderTapCallback;
  
  CategoryHeader({
    this.feedsStore,
    this.heading,
    this.enableHeaderTapCallback = true,
    this.isSeeAll = true,
    this.categoryName,
  });

  void _openCategoryPage(context) {
    print(categoryName);
    final CategoryStore categoryStore = CategoryStore();
    
    Navigator.of(context).push(CupertinoPageRoute<bool>(
      fullscreenDialog: true,
      builder: (BuildContext context) => MultiProvider(
        providers: [
          Provider<CategoryStore>.value(value: categoryStore),
          Provider<FeedsStore>.value(value: feedsStore)
        ],
        child: CategoryPage(
            heading: heading, categoryName: categoryName),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Text(
                  (isSeeAll)
                      ? categoryName?.toUpperCase()
                      : "$heading".toUpperCase(),
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () => (enableHeaderTapCallback) ? _openCategoryPage(context) : null,
              ),
            ],
          ),
        ),
        isSeeAll
            ? FlatButton(
                child: Text(
                  Localization.of(context).seeAll.toUpperCase(),
                  style: TextStyle(color: secondaryColor),
                ),
                onPressed: () => (enableHeaderTapCallback) ? _openCategoryPage(context) : null,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )
            : Container()
      ],
    );
  }
}
