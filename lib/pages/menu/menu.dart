import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/logic/stores/category/category_store.dart';
import 'package:Awoshe/logic/stores/category_menu/CategoryMenuStore.dart';
import 'package:Awoshe/logic/stores/feeds/feeds_store.dart';
import 'package:Awoshe/pages/category/category.page.dart';
import 'package:Awoshe/pages/occasions/OccasionProductPage.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AddMenuDialog extends StatefulWidget {

  @override
  AddMenuDialogState createState() => new AddMenuDialogState();
}

class AddMenuDialogState extends State<AddMenuDialog> with SingleTickerProviderStateMixin {
  final CategoryMenuStore store = CategoryMenuStore();
  TabController tabController;
  FeedsStore feedsStore;
  Size pageSize;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    store.init();
    feedsStore = Provider.of<FeedsStore>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    pageSize ??= MediaQuery
        .of(context)
        .size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final categoriesMenuWidget = _buildCategoriesMenuWidget();

    final occassionsMenuWidget = _buildOcassionsMenuWidget();

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        elevation: .0,
        bottom: TabBar(
        controller: tabController,
        indicatorColor: primaryColor,
        labelStyle: textStyle.copyWith(
          fontFamily: 'Muli',
        ),
        tabs: <Tab>[
          Tab( text: 'Categories',),
          Tab(text: 'Occasions',),
        ]
      ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          categoriesMenuWidget,
          occassionsMenuWidget,
        ],
        ),
      floatingActionButton: _buildFAB(),
    );
  }

  // This method builds the navigation bottom bar
  Widget _buildFAB() => SafeArea(
    child: Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),

        child: Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              //border: Border.all(width: 0.0, color: secondaryColor),
              color: awYellowColor,
            ),

            child: IconButton(
              padding: EdgeInsets.all(0.0),
              iconSize: 25.0,
              icon: Icon(
                Icons.close,
                color: secondaryColor,
                size: 25.0,
              ),

              color: awBlack,
              onPressed: () => Navigator.pop(context),
            ),
        ),
      ),
    ),
  );

  Widget _buildCategoriesMenuWidget() => Observer(
    builder: (_){
      if (store.state == ClotheCategoryStoreState.BUSY)

        return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center( child: AwosheLoading(size: 30,),)
            ],
        );

      return Container(
        width: pageSize.width,
        height: pageSize.height,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(store.entryList.length,
                      (index) => EntryItem(
                          store.entryList[index], store,),

                ),
              ),
          ),
        );
      },
  );

  Widget _buildOcassionsMenuWidget() => Container(
        width: pageSize.width,
        height: pageSize.height,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(AppData.OCCASION_LIST.length,
                      (index) => ListTile(
                        onTap: (){
                          var occasionSelected = AppData.OCCASION_LIST[index];
                          
                          Navigator.push(context, 
                            CupertinoPageRoute(
                              builder: (context) => OccasionProductPage(
                                occasionSelected,
                                title: Utils.capitalizeFirstLetter(occasionSelected),
                                onBackTap: () => Navigator.pop(context),
                              
                              ),
                            ),
                          );
                        },
                        title: Text(AppData.OCCASION_LIST[index].toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),

                ),
              ),
          ),
        
      );

}

class Entry {

  static final empty = Entry('');
  final String title;
  final String parent;

  bool isMainEntry;
  final List<Entry> children;

  Entry(this.title,
      {this.children = const <Entry>[], this.isMainEntry = false, this.parent});
}

// One entry in the multilevel list displayed by this app.
class EntryItem extends StatelessWidget {
  final Entry entry;
  final CategoryMenuStore store;

  const EntryItem(this.entry, this.store, );

  @override
  Widget build(BuildContext context) => _buildTiles(entry);

  Widget _buildTiles(Entry root) =>
    Observer(
      builder: (context) {
        var category = root.title.toLowerCase();
        var seeMore = store.expandedCategories.contains(category);

        var mainEntryTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 18);
        var subEntryTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

        // building subcategory tile.
        if (root.children.isEmpty)
          return ListTile(
            onTap: (){
              print('${entry.parent} => $category ');

              _openCategoryPage(context,
                categoryName: entry.parent,
                heading: entry.parent,
                subcategory: category,
              );
            },
            title: Text(
              (root.isMainEntry)
                  ? root.title
                  : _formatSubEntryTitle(root.title),
              style: (root.isMainEntry) ? mainEntryTextStyle : subEntryTextStyle,
            ),
          );

        List<Widget> children;

        if (root.children.length <= 5)
          children = root.children.map( _buildTiles).toList();

        // if category has more than 5 children
        else {

          int counter = (seeMore) ? store.categoryMap[ category ].length : 5;
          children = <Widget>[];

          for(var i =0; i < counter ; i++){
            children.add(  _buildTiles( root.children[i] ) );
          }

          // see more or hide tile.
          children.add(
              ListTile(
                onTap: (){
                  (seeMore) ? store.collapseCategory( category ) :
                    store.expandCategory(root.title.toLowerCase());

                },
                title: Text(
                  (seeMore) ? 'Hide' : 'See All',
                  textAlign: TextAlign.center,
                  style: mainEntryTextStyle,
                ),
              )
          );
        }

        return ExpansionTile(

          key: PageStorageKey<Entry>(root),
          title: (root.isMainEntry)
              ? Text(root.title.toUpperCase(), style: mainEntryTextStyle)
              : Text( _formatSubEntryTitle( root.title ),
            style: subEntryTextStyle,
          ),
          children: children,
        );
      }
    );


  void _openCategoryPage(BuildContext context,
  {String heading, String categoryName, String subcategory}) {
    final CategoryStore categoryStore = CategoryStore();
    var feedStore = Provider.of<FeedsStore>(context, listen: false);
    Navigator.of(context).push(CupertinoPageRoute<bool>(
      fullscreenDialog: true,
      builder: (BuildContext context) => MultiProvider(
        providers: [
          Provider<CategoryStore>.value(value: categoryStore),
          Provider<FeedsStore>.value(value: feedStore)
        ],
        child: CategoryPage(
            heading: categoryName.toUpperCase(),
            categoryName: categoryName.toLowerCase(),
          subcategory: (subcategory.toLowerCase() == categoryName.toLowerCase()) ? null : subcategory,
        ),
      ),
    ));
  }

  String _formatSubEntryTitle(String title) =>
      '${title[0].toUpperCase()}${title.substring(1).toLowerCase()}';
}

