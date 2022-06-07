import 'dart:io';
import 'package:Awoshe/components/bottom_sheet/customize_bottom_sheet.dart';
import 'package:Awoshe/components/bottom_sheet/standard_order_bottomsheet.dart';
import 'package:Awoshe/components/product_care/CareOption.dart';
import 'package:Awoshe/components/toprightclosefab.dart';
import 'package:Awoshe/components/useravatar.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/product/ProductPhotosBloc.dart';
import 'package:Awoshe/logic/stores/cart/cart_store.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/product/product_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/offer/Offer.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/pages/product/product.photos.gallery.dart';
import 'package:Awoshe/pages/product/product_carousel.dart';
import 'package:Awoshe/pages/product/product_info_expasion_tile.dart';
import 'package:Awoshe/pages/product/product_reviews.dart';
import 'package:Awoshe/pages/product/related_product.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/router.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/utils/product_care_assets.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/awoshe_rating.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

/// @author - Vijay, Felix, Marcos
/// product page - details of the product uploaded by the designer
/// TODO - related products part with could function
/// TODO - Reviews of the product part
/// TODO - Generate 6 digit unique item number

enum ViewMode { DEFAULT, CHECKING_OFFER, ORDERING_OFFER }

class ProductPage extends StatefulWidget {
  final String productId;
  final ViewMode viewMode;
  final Offer offer;
  final Product product;

  ProductPage({
    this.productId,
    Key key,
    this.viewMode = ViewMode.DEFAULT,
    this.offer,
    this.product,
  }) : super(key: key);

  @override
  ProductPageState createState() {
    return ProductPageState();
  }
}

class ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController _customController;
  Localization localization;
  ProductStore productStore;
  UserStore userStore;
  CartStore cartStore;
  bool shouldShowBottomsheet = false;
  ViewMode currentViewMode;

//  Color _randomStatusColor = Colors.black;
//  Color _randomNavigationColor = Colors.black;
//
//  bool _useWhiteStatusBarForeground;

//  bool _useWhiteNavigationBarForeground;

  @override
  void didChangeDependencies() {
    cartStore ??= Provider.of<CartStore>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    currentViewMode = widget.viewMode ?? ViewMode.DEFAULT;

    if (currentViewMode != ViewMode.DEFAULT) shouldShowBottomsheet = true;

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1.0);
    controller.fling(velocity: -1.0);

    _customController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1.0);

    _customController.fling(velocity: -1.0);

    userStore = Provider.of<UserStore>(context, listen: false);
    productStore = ProductStore(
        userStore, Provider.of<CurrencyStore>(context, listen: false));

          
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  void initialize() async {
    if (widget.product == null)
      await productStore.fetchProductDetail(
        productId: widget.productId, userId: userStore.details.id);
    else
      productStore.setProductFromData(widget.product);
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {

    print("PRODUCT PAGE build method calling_______________________--");
    localization = Localization.of(context);
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomPadding: false,
        floatingActionButton: AwosheTopRightCloseFab(
          onPressed: null,
        ),
        body: Observer(
            name: 'product_detail',
            builder: (BuildContext context) {
              var widget;

              switch (productStore.status) {
                case ProductStoreStatus.LOADING:
                  widget = buildLoadWidget();
                  break;
                case ProductStoreStatus.READY:
                  widget = buildPageLayout();
                  break;
                default:
                  widget = Container(
                      color: Colors.white,
                      child: NoDataAvailable(
                        message: 'Product data unavailable.',
                      ));
                  break;
              }

              return widget;
            }),
    );
  }

  Widget buildLoadWidget() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight:
                  Radius.circular(MediaQuery.of(context).size.width * 0.04),
              topLeft:
                  Radius.circular(MediaQuery.of(context).size.width * 0.04)),
        ),
        child: AwosheLoadingV2());
  }

  Widget buildPageLayout() {
    Product product = productStore.product;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (shouldShowBottomsheet) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            _showCustomizeBottomSheet(
              bodyType: (currentViewMode == ViewMode.CHECKING_OFFER)
                  ? CustomizeBodyType.OFFER
                  : CustomizeBodyType.CUSTOM_ORDER,
            );
          });

          shouldShowBottomsheet = false;
          //currentViewMode = ViewMode.DEFAULT;
        }

        return Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    (product.images.isNotEmpty)
                        ? Stack(
                            children: <Widget>[
                              ProductCarousel(
                                videoUrl: product.videoUrl,
                                imageList: product.images
                                    .map((url) => File(url))
                                    .toList(),
                                firstImageOrientation: product.orientation,
                                onTap: (selectedIndex) {
                                  _openProductZoomPage(product, selectedIndex);
                                },
                              ),
                              (product.isAvailable)
                                  ? Container()
                                  : Container(
                                      width: 120,
                                      height: 120,
                                      child: Image.asset(
                                          'assets/images/sold_out.png'),
                                    ),
                            ],
                          )
                        : SliverToBoxAdapter(
                            child: Center(
                              child: Text('There is no product images'),
                            ),
                          ),
                    Container(
                      decoration: BoxDecoration(
                        color: awLightColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          UserAvatar(
                            userId: product.creator?.id,
                            designerProfileImgUrl:
                                product.creator?.thumbnailUrl ??
                                    PLACEHOLDER_PROFILE_IMAGE,
                            designerRating: "4.5",
                            fullName: product.creator?.name,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10.0),
                                child: Text(
                                  localization.madeAndSoldBy,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: secondaryColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${product.creator?.name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: awBlack),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, top: 10.0),
                                    child: Container(
                                      //The StarRating plugin aligns the stars to the center so you have to go into the codes of the plugin to change it to end.
                                      child: Align(
                                        alignment: Alignment(1, -1),
                                        child: AwosheStarRating(
                                          color: secondaryColor,
                                          size: 15.0,
                                          rating: 4.5,
                                          starCount: 5,
                                        ),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SelectableText(
                                    '${product?.itemId}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        color: awBlack),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              StringUtils.capitalizeSentence(
                                  '${product?.title}'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  color: awBlack),
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[Text("")],
                            ),
                            Expanded(
                              child: Text(
                                '${userStore.details.currency} ' +
                                    '${PriceUtils.formatPriceToString(productStore.exchangeRate * PriceUtils.formatPriceToDouble(product.price))}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                    color: secondaryColor),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[Text("")],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only(left: 30.0),

                              // customize button
                              child: CupertinoButton(
                                  borderRadius: BorderRadius.circular(22.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  color: awLightColor,
                                  child: Text(
                                    localization.customize,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontFamily: 'Muli',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (userStore.details.isAnonymous) {
                                      await Utils.showAlertMessage(context,
                                          title: 'Oops!',
                                          warning: false,
                                          confirmText: 'SIGN IN',
                                          onConfirm: _goToLoginPage,
                                          message:
                                              localization.signInToPurchase);
                                      return;
                                    } else if (product.customMeasurements ==
                                            null ||
                                        product.customMeasurements.isEmpty) {
                                      ShowFlushToast(context, ToastType.INFO,
                                          "This item is available in only standard sizes");
                                      return;
                                    }

                                    _showCustomizeBottomSheet();
                                    return;
                                  }),
                            ),
                          ),
                          Expanded(flex: 1, child: Text("")),
                          Expanded(
                            flex: 3,
                            child: Container(
                              //height:60.0,
                              padding: EdgeInsets.only(right: 30.0),

                              // add to cart button
                              child: CupertinoButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  borderRadius: BorderRadius.circular(22.0),
                                  color: primaryColor,
                                  child: Text(
                                    localization.addToCart,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontFamily: 'Muli',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: _cartButtonCallback),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: ProductInfoExpansionTile(
                        localization.desc,
                        child: Text(
                          product.description ?? "",
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(),
                        ),
                      ),
                    ),


                    Container(color: Colors.white, child: _buildOccassionWidget(),),

                    Container(color: Colors.white, child: _buildCareWidget()),

                    ProductReviews(
                      product: this.productStore.product,
                    ),
                    Container(
                        color: Colors.white,
                        child: Padding(padding: EdgeInsets.all(20.0))),
                    Container(color: Colors.white, child: RelatedProduct()),
                  ]),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _goToLoginPage() => AppRouter.router
      .navigateTo(context, Routes.login, clearStack: true, replace: true);

  Widget _buildCareWidget() {
    var careOptions = productStore.product.careInfo;

    if (careOptions == null || careOptions.isEmpty)
      return ProductInfoExpansionTile(
        localization.productCare,
        child: Text(
          "No info available.",
          softWrap: true,
          overflow: TextOverflow.visible,
          style: TextStyle(),
        ),
      );

    var itemsNumber = careOptions.length;
    if (itemsNumber <= 6)
      return ProductInfoExpansionTile(localization.productCare,
          child: Container(
            height: 90,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var type = careOptions[index];
                return CareOption(
                  title: getProductCareTypeTitle(type),
                  isSelected: true,
                  type: type,
                  iconSize: 40,
                  margin: EdgeInsets.all(.0),
                );
              },
              itemCount: productStore.product.careInfo?.length ?? 0,
              scrollDirection: Axis.horizontal,
            ),
          ));

    return ProductInfoExpansionTile(
      localization.productCare,
      child: Container(
        height: 180,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: .0, childAspectRatio: .9),
          itemCount: productStore.product.careInfo?.length ?? 0,
          itemBuilder: (context, index) {
            var type = careOptions[index];
            return CareOption(
              title: getProductCareTypeTitle(type),
              isSelected: true,
              type: type,
              iconSize: 40,
              margin: EdgeInsets.all(.0),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOccassionWidget() {

    // just to not break the layout page.
    if (productStore.product.occassions == null || productStore.product.occassions.isEmpty)
      return Container();

    return ProductInfoExpansionTile(
      'Occasions',
      child: Container(
        height: 60,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Chip(
                backgroundColor: primaryColor,
                label: Text(
                  productStore.product.occassions[index],
                  style: textStyle.copyWith(color: Colors.white,fontWeight: FontWeight.normal)
                ),
              ),
            );
          },
          itemCount: productStore.product.occassions.length ?? 0,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  void _openProductZoomPage(Product product, int imageIndexClicked) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (ctx) => Provider<ProductPhotosBloc>(
            builder: (context) {
              SystemChrome.setEnabledSystemUIOverlays([]);
              return ProductPhotosBloc(
                  initialPage: imageIndexClicked, imageUrls: product.images);
            },
            child: ProductPhotos(),
            dispose: (context, bloc) {
              SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
              bloc.dispose();
            },
          ),
        ));
  }

  void _cartButtonCallback() async {
    if (userStore.details.isAnonymous) {
      await Utils.showAlertMessage(context,
          title: 'Oops!',
          warning: false,
          confirmText: 'SIGN IN',
          onConfirm: _goToLoginPage,
          message: localization.signInToPurchase);
      return;
    } else if (!productStore.product.isAvailable) {
      ShowFlushToast(context, ToastType.WARNING,
          "This item is not available at this time.");
    } else {

      _showAddtoCartBottomSheet();
    }
  }

  void _showCustomizeBottomSheet(
      {CustomizeBodyType bodyType = CustomizeBodyType.DEFAULT}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Provider<ProductStore>(
        builder: (_) => this.productStore,
        child: CustomizeBottomSheet(
          viewMode: currentViewMode,
          offer: widget.offer,
          backgroundColor: awLightColor,
        ),
      ),
    ).then((_) => currentViewMode = ViewMode.DEFAULT);
  }


  void _showAddtoCartBottomSheet()  {
    showModalBottomSheet(
      context: this.context,
      //isDismissible: true,

      //isScrollControlled: true,

      backgroundColor: Colors.transparent,
      builder: (context) => Provider<ProductStore>(
        builder: (_) => this.productStore,
        child: StandardOrderBottomSheet(),
      ),
    );
  }
}
