import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/ClickableText.dart';
import 'package:Awoshe/components/awsliverappbar.dart';
import 'package:Awoshe/components/closefab.dart';
import 'package:Awoshe/logic/bloc/profile/public_profile_bloc.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/pages/message/chat_detail/chat_detail.dart';
import 'package:Awoshe/pages/profile/profile_designs_tab.dart';
import 'package:Awoshe/pages/profile/public/profile_about_tab.dart';
import 'package:Awoshe/pages/profile/public/profile_contact_tab.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/DynamicLinkUtils.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/profile/InfoItemWidget.dart';
import 'package:Awoshe/widgets/profile/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'dart:async';

import '../../app_init.dart';

enum Tabs { DESIGNS, ABOUT, CONTACT }
class PublicProfilePage extends StatefulWidget {
  final String profileUserId;

  const PublicProfilePage({Key key, @required this.profileUserId}) : super(key: key);

  @override
  _PublicProfilePageState createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  static final offset16 = 16.0;
  PublicProfileBloc bloc;
  ProfileStore profileStore;
  UserStore _userStore;
  UserDetails userDetails;
  static double width = 140;
  static double height = 35;
  String designerId;

  @override
  void initState() {
    designerId = widget.profileUserId;
    bloc = PublicProfileBloc();
    super.initState();
    profileStore = ProfileStore();
    _userStore = Provider.of<UserStore>(context, listen: false);
    initialize();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Future<void> initialize() async {
    profileStore.setLoading(true);
    await profileStore.getUserProfile(
        userId: widget.profileUserId, currentUserId: _userStore.details.id);
    userDetails = profileStore.userDetails;
    profileStore.setLoading(false);
  }

  Widget buttonsPanel() {

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: height,
          child: CircularButton(
            onTap: () {
              print("clicked on message");
              print("sender: " + _userStore.details.id);
              print("Receiver: " + widget.profileUserId);
              String chatId = Utils.getGroupChatId(_userStore.details.id, widget.profileUserId);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetail(
                         chatId: chatId,
                         userStore: _userStore,
                         receiver: profileStore.userDetails.getUser()
                    ),
                  ),
                );
            },
            borderColor: Colors.grey,
            child: Text(localization.message, style: buttonTextStyle.merge(TextStyle(color: Colors.black)) ),
            color: Colors.white,
          ),
        ),

        SizedBox(width: 16.0,),
        Observer(
          builder: (context) {
            final bool isFollowing = _userStore.followingUserIds.contains(widget.profileUserId);
            final bool following = profileStore.userDetails.follower != null;
            print("isFollowing: " + isFollowing.toString());
            print("following: " + following.toString());
            print(userDetails.toJson());
            return Container(
              width: width,
              height: height,
              child: CircularButton(
                  color: Colors.orange,
                  child: (isFollowing || following) ? Text(localization.following, style: buttonTextStyle) :
                  Text(localization.followPlus, style: TextStyle(color: Colors.white)),
                  onTap: () async {
                    if (isFollowing) {
                      print("unfollow user");
                      await _userStore.unFollowUser(widget.profileUserId);
                    } else {
                      print("follow user");
                      await _userStore.followUser(widget.profileUserId);
                    }
                  }
              ),
            );
          },
        ),
      ],
    );
  }

  Widget infoPanel(context) => Container(
    padding: EdgeInsets.symmetric(horizontal: offset16 * .5),
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[

        Flexible(
          child: InfoItemWidget(
            title: '${userDetails?.designsCount}',
            subtitle: localization.designs,
          ),
        ),

        Flexible(
          child: InfoItemWidget(
            title: '${userDetails?.followersCount}',
            subtitle: localization.followers,
          ),
        ),
      ],
    ),
  );

  Widget labelTabs() => StreamBuilder<Tabs>(
    initialData: Tabs.DESIGNS,
    stream: bloc.tabStream,
    builder: (context, snapshot){
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: ClickableText(
              localization.designs,
              selected: (snapshot.data == Tabs.DESIGNS),
              onTap: (){
                bloc.goToTab(Tabs.DESIGNS);
              },
              width: 110,
            ),
          ),

          Flexible(
            child: ClickableText(
              localization.about,
              selected: (snapshot.data == Tabs.ABOUT),
              width: 110,
              onTap: (){
                bloc.goToTab(Tabs.ABOUT);
              },
            ),
          ),

          Flexible(
            child: ClickableText(
              localization.contact,
              selected: (snapshot.data == Tabs.CONTACT),
              width: 110,
              onTap: (){
                bloc.goToTab(Tabs.CONTACT);
              },
            ),
          ),
        ],
      );
    },

  );

  Widget sustainableWidget() {
    var userBadges = userDetails.badges ?? {};
    var enableColor = Colors.blueAccent;
    var disableColor = awLightColor300;

    print('User Badges ${userBadges.keys}');

    return Container(
      alignment: Alignment.center,

      child: Container(
        height: 50.0,
        child: Row(
          //scrollDirection: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                    width: 40.0,
                    height: 40.0,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        Assets.responsible,
                        color: (userBadges['responsible'] ?? false)
                            ? enableColor
                            : disableColor,
                        height: 40.0,
                        width: 40.0,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                    width: 40.0,
                    height: 40.0,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        Assets.ethical,
                        color: (userBadges['ethical'] ?? false)
                            ? enableColor
                            : disableColor,
                        height: 40.0,
                        width: 40.0,
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                    width: 40.0,
                    height: 40.0,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        Assets.artisanal,
                        color: (userBadges['artisanal'] ?? false)
                            ? enableColor
                            : disableColor,
                        height: 40.0,
                        width: 40.0,
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                    width: 40.0,
                    height: 40.0,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        Assets.recycled,
                        color: (userBadges['recycled'] ?? false)
                            ? enableColor
                            : disableColor,
                        height: 40.0,
                        width: 40.0,
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                    width: 40.0,
                    height: 40.0,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        Assets.charitable,
                        color: (userBadges['charitable'] ?? false)
                            ? enableColor
                            : disableColor,
                        height: 40.0,
                        width: 40.0,
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyWidget() => Column(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[

      ProfileHeader(profileStore: profileStore,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 1,

        ),
      ),
      sustainableWidget(),
      SizedBox(height: offset16 + 8),
      buttonsPanel(),

      SizedBox(height: offset16 *2),
      infoPanel(context),
      SizedBox(height: offset16 *2),

      labelTabs(),
    ],
  );

  Widget mutableContentArea() => StreamBuilder<Tabs>(
      initialData: Tabs.DESIGNS,
      stream: bloc.tabStream,
      builder: (context, snapshot){
        Widget widget;

        switch(snapshot.data){
          case Tabs.DESIGNS:
            widget = DesignsTab(
              designerId: designerId,
              profileType: 'PUBLIC',
            );
            break;

          case Tabs.ABOUT:
            widget = SliverToBoxAdapter(child: ProfileAboutTab(userDetails: userDetails,),);
            break;

          case Tabs.CONTACT:
            widget = SliverToBoxAdapter(child: ProfileContactTab(profileStore: profileStore, currentUserId: _userStore.details.id, designerId: userDetails.id,),);
            break;
        }
        return widget;
      }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          if (profileStore.loading) {
            return Center(
              child: AwosheLoading(),
            );
          }

          if (userDetails != null)
            return Stack(
            children: <Widget>[
              CustomScrollView(
                slivers: <Widget>[
                  AwosheSliverAppBar(
                    actions: <Widget>[
                      IconButton(
                        tooltip: 'Profile share',
                        icon: Icon(Icons.share,color: secondaryColor,),
                        onPressed: () async {
                          var link = await DynamicLinkUtils.createProfileLink(
                            userDetails.id,
                            imageUrl: userDetails.pictureUrl,
                            designerName: userDetails.name,
                            aboutDesigner: userDetails.description,
                          ).buildShortLink();

                          final awShortUrl = link.shortUrl.toString();
                          final RenderBox box = context.findRenderObject();

                          Share.share(awShortUrl.toString(),
                              sharePositionOrigin:
                              box.localToGlobal(Offset.zero) &
                              box.size
                          );
                        },

                      ),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: bodyWidget(),
                  ),
                  mutableContentArea(),
                ],
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: AwosheCloseFab(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );

          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: NoDataAvailable(
                    message: 'Profile data unavailable',
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: Observer(
        builder: (_) =>
          profileStore.userDetails == null 
          ? AwosheCloseFab(onPressed: () => Navigator.pop(context),) 
          : Container(),
      ),
    );
  }
}