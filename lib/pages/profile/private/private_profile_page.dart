import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/Buttons/textButton.dart';
import 'package:Awoshe/components/awsliverappbar.dart';
import 'package:Awoshe/logic/bloc/profile/profile_page_bloc.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/pages/about/about.page.dart';
import 'package:Awoshe/pages/profile/followers/followers.page.dart';
import 'package:Awoshe/pages/profile/followings/followings.page.dart';
import 'package:Awoshe/pages/profile/order/profile_order_tab.dart';
import 'package:Awoshe/pages/profile/profile_favourite_tab.dart';
import 'package:Awoshe/pages/profile/profile_name_tab.dart';
import 'package:Awoshe/pages/profile/profile_settings_tab.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/profile/ImageSourceBottomSheet.dart';
import 'package:Awoshe/widgets/profile/InfoItemWidget.dart';
import 'package:Awoshe/widgets/profile/profile_header.dart';
import 'package:Awoshe/widgets/profile/UserOwnDesignsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../router.dart';
import '../../app_init.dart';

class PrivateProfilePage extends StatefulWidget {
  PrivateProfilePage();

  @override
  _PrivateProfilePageState createState() => _PrivateProfilePageState();
}

class _PrivateProfilePageState extends State<PrivateProfilePage> {
  static final offset16 = 16.0;
  UserStore userStore;
  ProfileStore profileStore;
  PrivateProfileBloc bloc;
  UserDetails userDetails;

  @override
  void initState() {
    userStore = Provider.of<UserStore>(context, listen: false);
    profileStore = ProfileStore();
    profileStore.setUserDetails(userStore.details);
    print(profileStore.userDetails.toJson());
    userDetails = userStore.details;
    print(userDetails.toJson());
    bloc = PrivateProfileBloc(profileUserId: userStore.details.id, userStore: userStore, profileStore: profileStore);
    bloc.init();
    super.initState();
  }

  Widget infoPanel() =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: offset16 * .5),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: userDetails.isDesigner
                  ? InfoItemWidget(title: '${userDetails?.designsCount}',
                subtitle: localization.designs,
                onTap: () {
                  _openNewPage(UserOwnDesignsPage(
                    designerId: userDetails.id,
                  )
                  );
                },
              ) : InfoItemWidget(
                title: '${userDetails?.favouriteCount}',
                subtitle: localization.favourites,
                onTap: () {
                  _openNewPage(FavouritesTab(profileStore: profileStore,));
                },
              ),
            ),
            (userDetails.isDesigner)
                ? Flexible(
              child: InfoItemWidget(
                title: '${userDetails?.followersCount}',
                subtitle: localization.followers,
                onTap: () {
                  _openNewPage(
                      FollowersPage(profileStore: profileStore,));
                },
              ),
            )
                : Container(),
            Flexible(
              child: InfoItemWidget(
                title: '${userDetails?.followingCount}',
                subtitle: localization.following,
                onTap: () {
                  _openNewPage(
                      FollowingsPage(profileStore: profileStore)
                  );
                },
              ),
            ),
          ],
        ),
      );

  Widget anonymousWidgets() =>
      Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _openNewPage(
                  AboutPage(),
                );
              },
              title: Text(
                localization.about,
                style: textStyle1,
              ),
              trailing: SvgPicture.asset(
                Assets.rightArrow,
                color: secondaryColor,
                height: 15.0,
                width: 15.0,
              ),
            ),
            /*Divider(
              height: 1.0,
            ),*/
            SizedBox(height: 5.0,),
            AwosheButton(
                childWidget: Text(localization.signUp, style: buttonTextStyle.copyWith(fontSize: 18.0)),
                onTap: () {
                  AppRouter.router.navigateTo(context, Routes.signup);
                },
                width: double.infinity,
                height: 50.0,
                buttonColor: primaryColor)
          ],
        ),
      );

  Widget optionList() =>
      Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _openNewPage(
                  ProfileNameTab(
                    userStore: userStore,
                    profileStore: profileStore,
                  ),
                );
              },
              title: Text(
                localization.personalInformation,
                style: textStyle1,
              ),
              trailing: SvgPicture.asset(
                Assets.rightArrow,
                color: secondaryColor,
                height: 15.0,
                width: 15.0,
              ),
            ),
            /*Divider(
              height: 1.0,
            ),*/
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                Utils.showAlertMessage(context, title: 'Oops!',
                    message: 'Order reviews coming soon...');
              },
              title: Text(
                localization.purchasesAndReviews,
                style: textStyle1,
              ),
              trailing: SvgPicture.asset(
                Assets.rightArrow,
                color: secondaryColor,
                height: 15.0,
                width: 15.0,
              ),
            ),
            /*Divider(
              height: 1.0,
            ),*/
            ListTile(
              onTap: () {
                _openNewPage(ProfileOrderTab(
                    profileStore: profileStore, userStore: userStore));
              },
              contentPadding: EdgeInsets.all(0.0),
              title: Text(
                localization.orders,
                style: textStyle1,
              ),
              trailing: SvgPicture.asset(
                Assets.rightArrow,
                color: secondaryColor,
                height: 15.0,
                width: 15.0,
              ),
            ),
            if (userDetails.isDesigner)
             /* Divider(
                height: 1.0,
              ),*/
            if (userDetails.isDesigner)
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                onTap: () =>
                    _openNewPage(FavouritesTab(profileStore: profileStore,)),
                title: Text(
                  localization.favourites,
                  style: textStyle1,
                ),
                trailing: SvgPicture.asset(
                  Assets.rightArrow,
                  color: secondaryColor,
                  height: 15.0,
                  width: 15.0,
                ),
              ),
            /*Divider(
              height: 1.0,
            ),*/
            ListTile(
              onTap: () {
                _openNewPage(ProfileAddressMeasurements(
                  userStore: userStore, profileStore: profileStore,));
              },
              contentPadding: EdgeInsets.all(0.0),
              title: Text(
                localization.settings,
                style: textStyle1,
              ),
              trailing: SvgPicture.asset(
                Assets.rightArrow,
                color: secondaryColor,
                height: 15.0,
                width: 15.0,
              ),
            ),
          ],
        ),
      );

  Widget sustainableWidget() {
    var userBadges = profileStore.userDetails.badges ?? {};
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

  Widget logoutWidget() =>
      InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    localization.logout,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: awLightColor),
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.exit_to_app,
                color: awLightColor,
              ),
              Expanded(child: Container()),
              if (userDetails.isAnonymous)
              Column(
                children: <Widget>[
                  TextButton(
                      buttonName: localization.login,
                      onPressed: () {
                        AppRouter.router.navigateTo(
                            context, Routes.login, clearStack: true, replace: true);
                      },
                      buttonTextStyle: buttonTextStyle.copyWith(
                          color: primaryColor, fontSize: 18.0)),
                ],
              ),

            ],
          ),
        ),
        onTap: () {
          bloc.logout(context);
        },
      );

  Widget header() =>
      ProfileHeader(
        profileStore: profileStore,
        onCoverTap: () {
          _showBottomSheet(onTap: (source) {
            bloc.uploadCoverProfileImage(source);
          });
        },
        onProfilePictureTap: () {
          _showBottomSheet(
            onTap: (source) {
              bloc.uploadProfileImage(source);
            },
          );
        },
      );

  Widget bodyWidget() =>
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          header(),
          SizedBox(height: offset16),
          if (!userDetails.isAnonymous)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(),
            ),

          if ( userDetails.isDesigner )
            sustainableWidget(),
            Divider(
              height: 1,
            ),
            infoPanel(),

          SizedBox(height: offset16),
          if (userDetails.isAnonymous)
            anonymousWidgets(),
          if (!userDetails.isAnonymous)
            optionList(),
//          SizedBox(height: offset16),
          logoutWidget(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              AwosheSliverAppBar(
                title: localization.profile,
                showSearch: userStore.details.isDesigner,
              ),
              SliverToBoxAdapter(
                child: bodyWidget(),
              ),
            ],
          ),
          StreamBuilder<bool>(
              stream: bloc.modalStream,
              initialData: false,
              builder: (context, snapshot) =>
              (snapshot.data) ? ModalAwosheLoading() : Container()),
        ],
      ),
    );
  }

  void _showBottomSheet({void Function(ImageSource source) onTap}) =>
      showModalBottomSheet<Null>(
          context: context,
          builder: (BuildContext context) => ImageSourceBottomSheet(
            onTap: onTap,
          ));

  void _openNewPage(final Widget page) =>
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => page));
}
