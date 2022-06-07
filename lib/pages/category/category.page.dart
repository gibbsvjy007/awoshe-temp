import 'package:Awoshe/components/closefab.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/category/category_store.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:Awoshe/pages/category/category_view.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {

  final String heading;
  final String categoryName;
  final String subcategory;

  CategoryPage({Key key, this.categoryName, this.heading, this.subcategory})
      : super(key: key);

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin<CategoryPage> {
  CategoryStore categoryStore;
  TabController tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    categoryStore = Provider.of<CategoryStore>(context, listen: false);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    if (categoryStore.mainCategory.isEmpty) {
      initialize();
    }
  }

  Future<void> initialize() async {
    print('initialize called');
    await categoryStore.getMainCategory(widget.categoryName);
    print(categoryStore.mainCategory.toString());
  }

  @override
  void dispose() {
    tabController?.dispose();
    _scrollViewController?.dispose();
//    categoryStore?.dispose();
    super.dispose();
  }

  Widget buildSliverAppBar() => AppBar(
        //backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            tooltip: "BACK",
            icon: Icon(Icons.arrow_back_ios),
            color: secondaryColor,
            iconSize: 20.0,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        //brightness: Brightness.dark,
        iconTheme: IconThemeData(color: secondaryColor),
        centerTitle: false,
        title: Text(
          Utils.capitalize(widget.heading),
          style: appBarTextStyle,
        ),
      );

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AwosheCloseFab(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      appBar: buildSliverAppBar(),
      body: SafeArea(
        child: Observer(
            name: 'category_view',
            builder: (BuildContext context) {
              final String mainCategory = categoryStore.mainCategory;
              List<Widget> tabList = <Widget>[];
              List<Widget> catWidgets = <Widget>[];
              print("before inside category_view builder: " + mainCategory);
              if (categoryStore.loading) return AwosheLoadingV2();

              print("inside category_view builder: " + mainCategory);
              catWidgets.add(CategoryView(
                  mainCategory: mainCategory ?? widget.heading,
                  //subCategory: widget.subcategory,
              ));

              tabList.add(
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.dashboard, size: 20.0),
                      SizedBox(width: 5.0),
                      Text(SUB_CATEGORIES[SubCategory.ALL.index].toUpperCase())
                    ],
                  ),
                ),
              );

              if (categoryStore.clotheCategory != null) {
//                  WidgetsBinding.instance.addPostFrameCallback((_) {
//
//                  });
                print("addPostFrameCallback called");
                for (var subCategory
                    in categoryStore.clotheCategory.subcategories) {
                  print(subCategory.title);
                  tabList.add(_buildSubcategoryTab(subCategory));
                  catWidgets.add(CategoryView(
                      key: Key('$subCategory}'),
                      mainCategory: mainCategory,
                      subCategory: subCategory.title));
                }
              }
              return Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      indicatorColor: primaryColor,
                      isScrollable: true,
                      labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      labelColor: primaryColor,
                      unselectedLabelColor: awLightColor,
                      controller: _getTabController(tabList.length),
                      tabs: tabList,
                      labelStyle: upperTabbarTextStyle,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _getTabController(tabList.length),
                        children: catWidgets,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  TabController _getTabController(int length) {
    if (tabController == null) {
      int index = (widget.subcategory == null) ? 0 :
          categoryStore.clotheCategory.subcategories.indexOf( categoryStore.clotheCategory.getSubcategoryByName(widget.subcategory) ) + 1;

      print('INDEX $index');
      tabController =
          TabController(length: length, vsync: this, initialIndex: index);
    }
    return tabController;
  }

  Widget _buildSubcategoryTab(ClotheCategory category) => Tab(
        text: category.title.toUpperCase(),
      );
}
