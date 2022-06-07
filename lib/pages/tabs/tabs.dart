import 'dart:io';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc/awoshe_tabbar/AwosheTabBarBloc.dart';
import 'package:Awoshe/logic/stores/feeds/feeds_store.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/home/home.page.dart';
import 'package:Awoshe/pages/profile/private/private_profile_page.dart';
import 'package:Awoshe/pages/search/search.page.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/awoshe_material_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/pages/cart/cart.page.dart';
import 'package:Awoshe/pages/notifications/notification.page.dart';
import 'package:Awoshe/widgets/awoshe_bottom_navigation_bar_item.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'AwosheTabBarBottomSheet.dart';

/// This class is the main page of Awoshe app.
/// This is the page that shows the feeds widget, cart widget,
/// notification widget, owner profile widget and allow user make uploads
/// driving him to upload page.
///
class AwosheTabBar extends StatefulWidget with WidgetsBindingObserver {
  AwosheTabBar(
      {Key key,
        this.currrentPage = TabsPage.HOME,
        this.uploadMode,
        this.uploadType,
        this.designImages,
        this.productId})
      : super(key: key);

  final TabsPage currrentPage;
  final UploadMode uploadMode;
  final String productId;
  final UploadType uploadType;
  final List<File> designImages;

  @override
  AwosheTabBarState createState() => AwosheTabBarState();
}

class AwosheTabBarState extends State<AwosheTabBar>
    with WidgetsBindingObserver {
  AwosheTabBarBloc _bloc;
  bool isBottomSheetOpen = false;
  bool isDesigner = false;
  UserStore userStore;
  FeedsStore feedsStore;
  UploadStore uploadStore;
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    userStore = Provider.of<UserStore>(context, listen: false);
    isDesigner = userStore.details.isDesigner;
    feedsStore = Provider.of<FeedsStore>(context, listen: false);
    print("TABS:: " + isDesigner.toString());
    _bloc = AwosheTabBarBloc(
        currrentPage: widget.currrentPage,
        designImages: widget.designImages,
        productId: widget.productId,
        uploadType: widget.uploadType);

    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bloc.verifyProductLink(context);
    _pageController = PageController(initialPage: widget.currrentPage.index);
  }

  @override
  void didChangeDependencies() {
    uploadStore ??= Provider.of<UploadStore>(context);
    super.didChangeDependencies();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("__________________state");
    print(state.index);

    if (userStore.details.isAnonymous)
      return;

    switch(state){
      case AppLifecycleState.paused:
        print('paused state___________________');
        break;
      case AppLifecycleState.resumed:
      // call user online api
      await userStore.setPresence(true);
      _bloc.verifyProductLink(context);
        break;
      case AppLifecycleState.inactive:
        print('inactive state______________');
        // call user offline api
        await userStore.setPresence(false);
        break;
      case AppLifecycleState.detached:
        print('detached state');
        await userStore.setPresence(false);
        break;
    }
    super.didChangeAppLifecycleState(state);
  }


  @override
  void dispose() {
    print('::::::::::AwosheTabBarState dispose::::::::::');
    WidgetsBinding.instance.removeObserver(this);
//    feedsStore?.dispose();
    _bloc?.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  Widget _buildCartCountWidget() => CircleAvatar(
    radius: 10.0,
    backgroundColor: primaryColor,
    child: Observer(
      builder: (_) =>
          Text(
            userStore.details.cartCount.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.w600
            ),
          ),
    ),
  );
  Widget homeWidget() => Provider<FeedsStore>.value(
      value: feedsStore,
      child: HomePage()
//        child: Container()
  );
  Widget notificationsWidget() => NotificationPage();
  Widget searchWidget() => Search();
  Widget cartWidget() => CartPage();
  Widget profileWidget() => PrivateProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: [
          homeWidget(),
          notificationsWidget(),
          searchWidget(),
          cartWidget(),
          profileWidget(),
        ],
        controller: _pageController,
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  // builds navigation bottom bar
  Widget _buildNavigationBar() => AwBottomNavigationBar(
    type: AwBottomNavigationBarType.fixed,
    items: [
      AwBottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          Assets.homefilled,
          color: secondaryColor,
          height: 24.0,
          width: 24.0,
        ),
        icon: SvgPicture.asset(
          Assets.home,
          color: secondaryColor,
          height: 24.0,
          width: 24.0,
        ),
      ),
      AwBottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          Assets.notificationfilled,
          color: secondaryColor,
          height: 24.0,
          width: 24.0,
        ),
        icon: SvgPicture.asset(
          Assets.notification,
          color: secondaryColor,
          height: 24.0,
          width: 24.0,
        ),
      ),
      AwBottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          isDesigner ? Assets.uploadfilled : Assets.searchActive,
          //Note: if color is added the plus gets filled too, we have to change the svg file in future
          //color: secondaryColor,
          height: 24.0,
          width: 24.0,
          color: secondaryColor,
        ),
        icon: SvgPicture.asset(
          isDesigner ? Assets.upload : Assets.search,
          color: secondaryColor,
          height: 24.0,
          width: 24.0,
        ),
      ),
      AwBottomNavigationBarItem(
        activeIcon: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: <Widget>[
              SvgPicture.asset(
                Assets.shoppingbagfilled,
                color: secondaryColor,
                height: 24.0,
                width: 24.0,
              ),
              Align(
                alignment: Alignment(0.4, -4.0),
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: _buildCartCountWidget()),
              )
            ]),
        icon: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: <Widget>[
              SvgPicture.asset(
                Assets.shoppingbag,
                color: secondaryColor,
                height: 24.0,
                width: 24.0,
              ),
              Align(
                alignment: Alignment(0.4, -4.0),
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: _buildCartCountWidget()),
              )
            ]),
      ),
      AwBottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          Assets.profilefilled,
          color: secondaryColor,
          height: 24.0,
          width: 24.0,
        ),
        icon: SvgPicture.asset(
          Assets.profile,
          color: secondaryColor,
          height: 24.0,
          width: 24.0,
        ),
      ),
    ],
    onTap: _onPageChanged,
    currentIndex: _page,
  );

  void _onPageChanged(int page) {
    print(page);
    if (isDesigner && page == 2) {
      if (!isBottomSheetOpen) showUploadBottomSheet(page);
      return;
    }
    if (!mounted) return;
    isBottomSheetOpen = false;
//    if (page != TabsPage.UPLOAD.index)
    _pageController.jumpToPage(page);
    print('before setState');
    setState(() {
      _page = page;
    });

  }

  /// according to new design show the options for upload before navigating to page
  showUploadBottomSheet(int pageIndex) {
    isBottomSheetOpen = true;

    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AwosheUploadBottomSheet(
            onTap: (uploadType) {
              if (uploadType == null) {
                isBottomSheetOpen = false;
                return;
              }
              switch(uploadType){
                case UploadType.DESIGN:
                  uploadStore.startProductUpload(this.context);

                  break;
                case UploadType.FABRIC:
                  uploadStore.startFabricUpload(this.context);
                  break;
                case UploadType.BLOG:
                  uploadStore.startBlogUpload(this.context);
                  break;

                default:
                  Navigator.of(context).pop();
                  break;
              }
              // _bloc.navigateToUpload(uploadType);
            },
          );
        }).whenComplete(() {
      isBottomSheetOpen = false;
    });
  }

}
