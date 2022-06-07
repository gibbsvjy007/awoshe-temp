import 'dart:async';
import 'dart:io';
import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc_helpers/bloc_provider.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/pages/profile/public/public_profile_page.dart';
import 'package:Awoshe/services/user.service.dart';
import 'package:Awoshe/utils/DynamicLinkUtils.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AwosheTabBarBloc extends BlocBase {
  static int cartCountValue = 0;
  UserService userService;

  final BehaviorSubject<TabsPage> _navigationSubject = BehaviorSubject();
  Observable<TabsPage> get navigationStream => _navigationSubject.stream;

  final BehaviorSubject<int> _cartCountSubject =
      BehaviorSubject.seeded(cartCountValue);
  Observable<int> get cartCount => _cartCountSubject.stream;
  StreamSubscription<QuerySnapshot> _cartSubscription;

  final BehaviorSubject<UploadType> _uploadTypeSubject = BehaviorSubject();
  Observable<UploadType> get uploadTypeStream => _uploadTypeSubject.stream;

  TabsPage currrentPage;
  UploadMode uploadMode;
  UploadType uploadType;
  String userId;
  String productId;
  List<File> designImages;
  //CartService cartService;
  final PageController _pageController;
  PageController get pageController => _pageController;

  AwosheTabBarBloc({
    this.currrentPage,
    this.uploadType,
    this.designImages,
    this.productId,
  }) : _pageController = PageController(initialPage: currrentPage.index) {

    _initResources();

    print('AwosheTabBarBloc init...');
  }

  _initResources() async {
    AppData.isDesigner = await Utils.isDesigner();
    if (userId == null || userId == "") {
      userId = await Utils.getUserId();
      userService = UserService(userId: userId);
      //cartService = CartService(userId);
      //_listeningCart();
    }
  }

  void addCartCountValue(final int value) {
    cartCountValue = value;
    _cartCountSubject.sink.add(value);
  }

  void addCartCountError(final Object error) =>
      _cartCountSubject.sink.addError(error);

  void _addToNavigationStream(final TabsPage page) =>
      _navigationSubject.sink.add(page);

  void _addToUploadStream(final UploadType type) =>
      _uploadTypeSubject.sink.add(type);

  void navigateTo(final TabsPage page) {
    _pageController.jumpToPage(page.index);
    currrentPage = page;
    _addToNavigationStream(page);
  }

  void navigateToUpload(final UploadType type) {
    uploadType = type;
    productId = null;
    _addToUploadStream(type);
    navigateTo(TabsPage.UPLOAD);
  }

  @override
  void dispose() {
    print('AwosheTabBarBloc disposed...');
    _cartCountSubject?.close();
    _navigationSubject?.close();
    _cartSubscription?.cancel();
    _pageController?.dispose();
    _uploadTypeSubject?.close();
  }

  void verifyProductLink(BuildContext context) async {
    // this approach is used when the app is closed and the user
    // try to open the app from a link. If the app is running in background
    // this call will provide a null link.
    DynamicLinkUtils.retrieveDynamicLink().then( (link){
      print('Fetched the link $link');

      if (link != null){
        if (link != null) {
          List<String> data = link.link.path.split('=');
          switch(data[0]){
            case '/path':
              _openProductPageWithLink(context, data[1]);
              break;

            case '/profile':
              _openProfilePageWithLink(context, data[1]);
              break;
          }
        }
      }

      // This approach is only used if the the app is running in background
      // and the user has been clicked on a link.
      FirebaseDynamicLinks.instance.onLink(
      onSuccess: (link){
        if (link != null) {
          List<String> data = link.link.path.split('=');
          switch(data[0]){
            case '/path':
              _openProductPageWithLink(context, data[1]);
              break;

            case '/profile':
              _openProfilePageWithLink(context, data[1]);
              break;
          }
        }
        else
          print('There is no link');
        return;
      },

      onError: (error) { print(error); return;},
    );

    } ).catchError( (error) => print('Dynamic Link $error') );
  }

  void _openProfilePageWithLink(
      BuildContext context, String profileId) {
    print('Id: $productId');
    Navigator.of(
      context,
    ).push(
      CupertinoPageRoute<bool>(
        settings: RouteSettings(name: 'PublicProfilePage'),
        fullscreenDialog: true,
        builder: (BuildContext context) => PublicProfilePage(
          profileUserId: profileId,
        ),
      ),
    );
  }

  void _openProductPageWithLink(
      BuildContext context, String productId) {
    print('Id: $productId');
    Navigator.of(
      context,
    ).push(
      CupertinoPageRoute<bool>(
        settings: RouteSettings(name: 'ProductPage'),
        fullscreenDialog: true,
        builder: (BuildContext context) => ProductPage(
          productId: productId,
        ),
      ),
    );
  }

}
