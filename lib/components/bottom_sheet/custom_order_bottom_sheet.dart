import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/components/awcupertinotextfield.dart';
import 'package:Awoshe/logic/stores/cart/cart_store.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/offer/Offer.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/pages/product/product_select_color.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:Awoshe/utils/WidgetUtils.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomOrderBottomSheet extends StatefulWidget {
  final Product product;
  final ViewMode viewMode;
  final Offer offer;

  CustomOrderBottomSheet({Key key, @required this.product, this.viewMode =
      ViewMode.ORDERING_OFFER, this.offer}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomOrderBottomSheet();
}

class _CustomOrderBottomSheet extends State<CustomOrderBottomSheet> {
  Map<String, TextEditingController> controllerMap = {};
  final TextEditingController fabricItemController = TextEditingController();
  CartStore cartStore;
  UserStore userStore;
  CurrencyStore currencyStore;
  String colorSelected;

  @override
  void initState() {
    cartStore = Provider.of<CartStore>(context, listen: false);
    userStore = Provider.of(context, listen: false);
    currencyStore = Provider.of(context, listen: false);
    super.initState();
  }


  @override
  void dispose() {
    controllerMap.values.forEach( (c) => c.dispose() );
    controllerMap.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hMargin = 8.0;

    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                children: <Widget>[

                  // just need the colors
                  SelectColor(
                      product: widget.product,
                      callback: (String color) => colorSelected = color,
                  ),

                  optionSeparatorWidget(horizontalMargin: hMargin),
                  // TODO needs to handle fabrics
                   (widget.product.fabricTags.length > 0) ?
                    buildFabricList()

//                 SelectFabric(
//                      product: widget.product,
//                      callback: (selected){})

                  : createInputField('Fabric item', fabricItemController),


                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Add Measurements",
                        style: TextStyle(
                          color: awBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  createMeasurementsWidget(),

                  optionSeparatorWidget(
                      horizontalMargin: hMargin, verticalMargin: 12.0),

                  (widget.viewMode == ViewMode.ORDERING_OFFER )
                      ? Container(
                         margin: EdgeInsets.only(bottom: 8.0),
                        child: priceDateSection()
                  ) : Container(),

                  Align(
                    alignment: Alignment.bottomRight,

                    child: RoundedButton(
                      height: 30,
                      width: 120,
                      //bottomMargin: 10,
                      buttonColor: primaryColor,
                      borderWidth: .0,
                      buttonName: 'Add to Cart',
                      onTap: addToCart,
                    ),
                  ),

                ],
              ),
            ),
          ],
      ),
    );
  }

  Widget createInputField(String measure, TextEditingController controller,
      {TextInputType inputType, ValueChanged<String> onTap}) {
    final node = AlwaysDisabledFocusNode();
   return Container(
      child: Hero(
        tag: measure,
        child: TextFormField(
          autofocus: false,
          focusNode: node,
          onTap: (){
            Navigator.push(context,
                TextFieldPageRoute(
                    page: TextFieldPage(
                      initialText: controller.text,
                      heroTag: measure,
                      hint: measure,
                      inputType: inputType,
                      onDone: onTap,
                    )
                )
            );
          },
          //validator: validateFunction,
          style: textStyle,
          keyboardType: inputType ?? TextInputType.number,
          maxLines: 1,
          controller: controller,
          textAlign: TextAlign.center,
          //onSaved: onSaved,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: measure,
            hintStyle: TextStyle(color: awLightColor,),
            contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
            errorStyle: TextStyle(color: Colors.redAccent),

            fillColor: Colors.white70,
            filled: true,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget createMeasurementsWidget() {

    if (widget.product.customMeasurements.length <= 3)  {
      return Container(
        height: 50,
        child: ListView.builder(
            itemBuilder: (context, index){
              var key = widget.product.customMeasurements[index];
              var controller;
              if (controllerMap.containsKey(key))
                controller = controllerMap[key];
              else {
                controller = TextEditingController();
                controllerMap.putIfAbsent(key, () => controller);
              }
              return Container(
                  width: 100,
                  child: measureItem(key, controller)
              );
            },

          itemCount: widget.product.customMeasurements.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    }

    return Container(
      height: 110,
      child: Form(
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: .4),
            itemBuilder: (context, index) {

              var key = widget.product.customMeasurements[index];
              var controller;
              if (controllerMap.containsKey(key))
                controller = controllerMap[key];
              else {
                controller = TextEditingController();
                controllerMap.putIfAbsent(key, () => controller);
              }
              return measureItem(key, controller);

            },
            itemCount: widget.product.customMeasurements.length,
          )),
    );
  }

  Widget measureItem(String key, TextEditingController controller) =>  Hero(
    tag: key,
    transitionOnUserGestures: true,
    child: TextFormField(
      textAlign: TextAlign.center,
      maxLines: 1,
      controller: controllerMap[key],
      focusNode: AlwaysDisabledFocusNode(),

      decoration: InputDecoration(
        hintText: key,
        //hintStyle: hintStyle,
        errorStyle: TextStyle(color: Colors.redAccent),
        hintStyle: TextStyle(color: awLightColor),
        contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
        fillColor: Colors.white70,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),

      onTap: (){ Navigator.push(context,
          TextFieldPageRoute(
            page: TextFieldPage(
              title: 'Your Measure',
              initialText: controller.text,
              heroTag: key,
              hint: key,
              maxLines: 1,
              inputType: TextInputType.number,
              onDone: (data) {
                setState(() {
                  controller.text = data;
                });
                Navigator.pop(context);
              },
            ),

          )
      ); },

    ),
  );

  Widget buildFabricList() {
    //if (widget.product.fabricTags.length == 0)
      return Column(

        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,

              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0,),
                child: Text('Select a fabric', style: TextStyle(
                  color: awBlack,
                  fontWeight: FontWeight.w600
                ),),
              )
          ),

          Container(
            height: 70,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: createInputField(
                            'Fabric item number',
                            fabricItemController,
                            inputType: TextInputType.text,
                            onTap: (data){
                              fabricItemController.text = data;
                              Navigator.pop(context);
                            }
                          ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

//   return ListView.builder(itemBuilder: (context, index){
//     return index == widget.product.fabricTags.length
//         ? Container(
//              width: MediaQuery.of(context).size.width / 2,
//              height: 20,
//              child: createInputField('FabricId', fabricItemController),
//            )
//         : Container();
//   },
//       itemCount: widget.product.fabricTags.length + 1,
//     scrollDirection: Axis.horizontal,
//   );
  }

  Widget priceDateSection() {
    double price = PriceUtils.formatPriceToDouble(widget.offer.price);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Price'),

            Container(margin: EdgeInsets.only(top: 8.0),),

            Text('${userStore.details.currency} ${PriceUtils.formatPriceToString(
                currencyStore.convertValue(
                    value: price,
                    from: widget.product.currency,
                    to: userStore.details.currency
                ),
            )}'),

          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('To be delivered by'),

            Container(margin: EdgeInsets.only(top: 8.0),),

            Text('${widget.offer.deliveryDate.day}.'
                '${widget.offer.deliveryDate.month}.'
                '${widget.offer.deliveryDate.year} '
            ),

          ],
        ),
      ],
    );
  }

  void addToCart() {

    var measurements = {};

    controllerMap.keys.forEach(
            (key) => measurements.putIfAbsent(
            key, () =>  controllerMap[key].text ) );

    print('Adding to cart $colorSelected');

    var offerProduct = Product(
      price: widget.offer.price,
      title: widget.product.title,
      description: widget.product.description,
      id: widget.product.id,
      currency: widget.product.currency,
      imageUrl: widget.product.imageUrl,
      mainCategory: widget.product.mainCategory,
      availableColors: widget.product.availableColors,
      careInfo: widget.product.careInfo,
      collection: widget.product.collection,
      creator: widget.product.creator,
      currentSizeIndex: widget.product.currentSizeIndex,
      customMeasurements: widget.product.customMeasurements,
      distanceUnit: widget.product.distanceUnit,
      fabricTags: widget.product.fabricTags,
      feedType: widget.product.feedType,
      images: widget.product.images,
      isFavourited: widget.product.isFavourited,
      itemId: widget.product.itemId,
      occassions: widget.product.occassions,
      orderType: widget.product.orderType,
      orientation: widget.product.orientation,
      otherInfos: widget.product.otherInfos,
      owner: widget.product.owner,
      productCare: widget.product.productCare,
      productType: widget.product.productType,
      sizes: widget.product.sizes,
      sizesInfo: widget.product.sizesInfo,
      sizeText: widget.product.sizeText,
      status: widget.product.status,
      subCategory: widget.product.subCategory,
    );

    cartStore.addItem(
      offerProduct,
      fabric: fabricItemController.text,
      selectedColor: colorSelected,
      userId: userStore.details.id,
      selectedSize: '',
      validateSize: false,
      measurements: measurements,
    ).whenComplete( () {

      switch (cartStore.cartError) {
        case CartEvent.NONE:
          break;

          case CartEvent.PRODUCT_IN_CART:
          ShowFlushToast(this.context, ToastType.INFO,
              'This product is already in your cart');
          break;

        case CartEvent.NO_COLOR_SELECTED:
          ShowFlushToast(this.context, ToastType.INFO,
              'You must select color');
          break;

        case CartEvent.ADDED_SUCCESS:
          ShowFlushToast(
              this.context,
              ToastType.INFO,
              "Item added to cart successfully.",
              callback: () => Navigator.pop(context),
          );

          userStore.setUserDetails(
              userStore.details.copyWith(
                  cartCount: userStore.details.cartCount + 1
              )
          );
          break;

        case CartEvent.ERROR:
          ShowFlushToast(
              this.context,
              ToastType.INFO,
              "Was not possible finish the operation."
          );
          break;

        case CartEvent.NO_SIZE_SELECTED:
          break;
      }
    });

  }
}

