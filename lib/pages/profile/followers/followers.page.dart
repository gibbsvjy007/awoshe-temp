import 'package:Awoshe/components/appBar.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/shared/infinite_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FollowersPage extends StatefulWidget {
  final ProfileStore profileStore;
  final bool showAppBar;
  final bool wantToChat;

  FollowersPage({Key key, this.profileStore, this.showAppBar = true, this.wantToChat = false});

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage>
    with AutomaticKeepAliveClientMixin<FollowersPage> {
  ProfileStore profileStore;
  bool _fetchingMore = false;

  @override
  void initState() {
    profileStore = widget.profileStore;
    widget.profileStore.fetchFollower();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.showAppBar ? AwosheSimpleAppBar(
        title: "Followers",
      ) : null,
      body: Observer(
        builder: (BuildContext context) {
          if (profileStore.loadingFollowingFollowers &&
              profileStore.followerList.isEmpty) {
            return AwosheLoadingV2();
          }
          return Provider<ProfileStore>.value(
            value: profileStore,
            child: (!profileStore.loadingFollowingFollowers &&
                    profileStore.followerList.isEmpty)
                ? NoDataAvailable()
                : InfiniteListView(
                    endOffset: 100.0,
                    onEndReached: () async {
                      print('start fetching once end reached');

                      if (!_fetchingMore) {
                        if (!profileStore.loadingFollowingFollowers &&
                            profileStore.followerList.isEmpty) return;
                        _fetchingMore = true;
                        await profileStore.fetchFollower();
                        _fetchingMore = false;
                      }
                      print('finish fetching after end reached');
                    },
                    itemCount: profileStore.followerList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      print(index.toString() +
                          ' ' +
                          profileStore.userDetails.followersCount.toString() +
                          ' ' +
                          profileStore.followerList.length.toString());
                      if (index == profileStore.followerList.length) {
                        if (profileStore.followerList.length ==
                            profileStore.userDetails.followersCount)
                          return Container();
                        return AwosheLoadingV2();
                      } else {
                        final User fUser = profileStore.followerList[index];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12.0),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                fUser.thumbnailUrl),
                            radius: 25.0,
                          ),
                          dense: true,
                          title: Text(StringUtils.capitalize(fUser.name),
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            fUser.handle,
                            style: TextStyle(color: awLightColor),
                          ),
                          onTap: () {

                          },
                        );
                      }
                    },
                  ),
          );
        },
      ),
    );
  }
}
