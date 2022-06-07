import 'package:Awoshe/components/category_card.dart';
import 'package:Awoshe/components/category_heading.dart';
import 'package:Awoshe/logic/stores/occasions/OcassionStore.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class OccasionProductPage extends StatefulWidget {
  final String title;
  final VoidCallback onBackTap;
  final String occasionName;
  const OccasionProductPage(this.occasionName,
      {Key key, @required this.title, this.onBackTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _OccasionProductPageState();
}

class _OccasionProductPageState extends State<OccasionProductPage> {
  final store = OcassionStore();
  UserStore userStore;
  ScrollController controller =
      ScrollController(keepScrollOffset: true, initialScrollOffset: .0);

  @override
  void initState() {
    userStore = Provider.of<UserStore>(context, listen: false);
    store.loadProducts(
        ocassion: widget.occasionName, userId: userStore.details.id);

    controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(widget.title ?? 'Occasions Product'),
          ),
          Observer(
            builder: (_) {
              var widget;

              switch (store.storeState) {
                case OcassionStoreState.NONE:
                case OcassionStoreState.LOADING:
                  widget = SliverFillRemaining(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center( child: AwosheLoadingV2(),),
                      ],
                    ),
                  );
                  break;

                case OcassionStoreState.DONE:
                  widget = (store.productList.isEmpty) 
                  
                  ? noDataSliverWidget("Nothing available")

                  : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_buildListChildren),
                      childCount: store.productList.length,
                    ),
                  );
                  break;
                
                case OcassionStoreState.ERROR:
                  widget = noDataSliverWidget("Something went wrong!");
                  break;
              }

              return widget;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListChildren(BuildContext context, int index) {
    
    if (index == store.productList.length - 1) {
      if (store.isAllPageLoaded)
        return reachEndWidget();

      else
        return Observer(
          builder: (_) {
            return (store.isLoadingMore)
                ? Container(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: AwosheLoadingV2(),
                      ),
                    ),
                  )
                : Container();
          },
        );
    }

    var itemToShow = Feed.fromJson(store.productList[index]);

    return Column(
      children: <Widget>[
        CategoryHeader(
          heading: itemToShow.mainCategory.toUpperCase(),
          enableHeaderTapCallback: false,
          isSeeAll: false,
        ),
        CategoryCard(
          feed: itemToShow,
          onFeedTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => ProductPage(
                  product: Product.fromJson(store.productList[index]),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _scrollListener() async {
    if (controller.position.pixels >
        (controller.position.maxScrollExtent -
            (controller.position.maxScrollExtent / 4)) ) {
      
      if (!store.isLoadingMore) 
        store.loadMore(
          ocassion: widget.occasionName, userId: userStore.details.id);
    }
  }

  Widget reachEndWidget() => Center(
        key: UniqueKey(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('You\'ve reached the end!',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: awLightColor)),
        ),
      );

  Widget noDataSliverWidget(String message) => SliverFillRemaining(
    hasScrollBody: false,
    child: Center(
      child: NoDataAvailable(
        message: message,
      ),
    ),
  );
}