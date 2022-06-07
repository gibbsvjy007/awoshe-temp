import 'package:Awoshe/components/appBar.dart';
import 'package:Awoshe/components/favourites.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/models/favourite/favourite.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/shared/infinite_grid_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FavouritesTab extends StatefulWidget {
  final ProfileStore profileStore;

  FavouritesTab({Key key, this.profileStore }) : super(key: key);

  @override
  _FavouritesTabState createState() => new _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
  int i = 0;
  ProfileStore profileStore;
  bool _fetchingMore = false;

  @override
  void initState() {
    super.initState();
    profileStore = widget.profileStore;
    widget.profileStore.fetchFavourites();
  }

  @override
  Widget build(BuildContext context) {
    // final double itemHeight = (size.height - kToolbarHeight - 48) / 2;
    // final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AwosheSimpleAppBar(
        title: "Favourites",
      ),
      body: Observer(
        builder: (BuildContext context) {
          if (profileStore.loadingFavourites &&
              profileStore.favouritesList.isEmpty) {
            return AwosheLoadingV2();
          }
          return Provider<ProfileStore>.value(
            value: profileStore,
            child: (!profileStore.loadingFavourites &&
                profileStore.favouritesList.isEmpty)
                ? NoDataAvailable()
                : InfiniteGridListView(
              endOffset: 100.0,
              shrinkWrap: true,
              onEndReached: () async {
                print('start fetching once end reached');

                if (!_fetchingMore) {
                  if (!profileStore.loadingFavourites &&
                      profileStore.favouritesList.isEmpty) return;
                  _fetchingMore = true;
                  await profileStore.fetchFavourites();
                  _fetchingMore = false;
                }
                print('finish fetching after end reached');
              },
              itemCount: profileStore.favouritesList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == profileStore.favouritesList.length) {
                  if (profileStore.favouritesList.length ==
                      profileStore.userDetails.favouriteCount)
                    return Container();
                  return AwosheLoading();
                } else {
                  final Favourite favourite = profileStore
                      .favouritesList[index];
                  return FavouriteTile(favourite: favourite,
                      profileStore: profileStore,
                      onTap: () => Navigator.push(context,
                          CupertinoPageRoute(
                             builder: (_) => ProductPage(  productId: favourite.id,)
                          ),
                      ),
                      index: index
                  ); //JEwwOiv6n1JEduRzaxZe
                }
              },
            ),
          );
        },
      ),
    );
  }
}
