import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/appBar.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/shared/infinite_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FollowingsPage extends StatefulWidget {
  final ProfileStore profileStore;
  final bool showAppBar;
  final bool wantToChat;

  FollowingsPage(
      {Key key, this.profileStore, this.showAppBar = true, this.wantToChat = false});

  @override
  _FollowingsPageState createState() => _FollowingsPageState();
}

class _FollowingsPageState extends State<FollowingsPage>
    with AutomaticKeepAliveClientMixin<FollowingsPage> {
  ProfileStore profileStore;
  UserStore userStore;
  bool _fetchingMore = false;

  @override
  void initState() {
    profileStore = widget.profileStore;
    userStore = Provider.of<UserStore>(context, listen: false);
    widget.profileStore.fetchFollowing();
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
        title: "Followings",
      ) : null,
      body: Observer(
        builder: (BuildContext context) {
          if (profileStore.loadingFollowingFollowers &&
              profileStore.followingList.isEmpty) {
            return AwosheLoadingV2();
          }
          return Provider<ProfileStore>.value(
            value: profileStore,
            child: (!profileStore.loadingFollowingFollowers &&
                profileStore.followingList.isEmpty)
                ? NoDataAvailable()
                : InfiniteListView(
              endOffset: 100.0,
              onEndReached: () async {
                print('start fetching once end reached');

                if (!_fetchingMore) {
                  if (!profileStore.loadingFollowingFollowers &&
                      profileStore.followingList.isEmpty) return;
                  _fetchingMore = true;
                  await profileStore.fetchFollowing();
                  _fetchingMore = false;
                }
                print('finish fetching after end reached');
              },
              itemCount: profileStore.followingList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                print(index.toString() +
                    ' ' +
                    profileStore.userDetails.followingCount.toString() +
                    ' ' +
                    profileStore.followingList.length.toString());
                if (index == profileStore.followingList.length) {
                  if (profileStore.followingList.length ==
                      profileStore.userDetails.followingCount)
                    return Container();
                  return AwosheLoadingV2();
                } else {
                  final User fUser = profileStore.followingList[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          fUser.thumbnailUrl),
                      radius: 25.0,
                    ),
                    trailing: SizedBox(
                      width: 70.0,
                      child: widget.wantToChat ? Observer(
                        name: 'unfollow_button',
                        builder: (BuildContext context) {
                          final bool isFollowing = profileStore.followingListIds.contains(fUser.id);
                          print(isFollowing);
                          print(profileStore.followingListIds);
                          return RoundedButton(
                              buttonName: isFollowing ? "Unfollow" : "Follow",
                              textStyle: TextStyle(fontSize: 12.0, color: Colors.white),
                              buttonColor: primaryColor,
                              height: 25.0,
                              width: 65.0,
                              onTap: () async {
                                if (isFollowing) {
                                  print("unfollow user");
                                  userStore.removeFollowingUserId(fUser.id);
                                  profileStore.followingListIds.remove(fUser.id);
                                  await userStore.unFollowUser(fUser.id);
                                } else {
                                  userStore.addFollowingUserId(fUser.id);
                                  profileStore.followingListIds.add(fUser.id);
                                  await userStore.followUser(fUser.id);
                                }
                              },
                          );
                        },
                      ) : Container(),
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
