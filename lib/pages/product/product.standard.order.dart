import 'dart:ui';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/cart/cart_store.dart';
import 'package:Awoshe/logic/stores/product/product_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/pages/product/product_select_color.dart';
import 'package:Awoshe/pages/product/product_select_size.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

typedef Widget PhysicsProvidedWidgetBuilder(ScrollPhysics physics);

class StandardOrder extends StatefulWidget {
  //final AnimationController controller;
  final BoxConstraints boxConstraint;

  StandardOrder({
    this.boxConstraint,
  });

  @override
  _StandardOrderState createState() => _StandardOrderState();
}

class _StandardOrderState extends State<StandardOrder>
    with SingleTickerProviderStateMixin {
  //AnimationController _controller;
  //double containerHeight = 0.0;
  String selectedColor;
  String selectedFabric;
  int selectedSizeIndex = -1;
  String selectedSizeHeader = '';
  String dropdownSizeTypeSelected;
  CartStore cartStore;
  UserStore userStore;
  ProductStore productStore;
  Product product;

  @override
  void initState() {
    cartStore = Provider.of<CartStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);
    productStore = Provider.of<ProductStore>(context, listen: false);
    product = productStore.product;
    print('Product ID: ${product.id}');
    super.initState();
  }

  _fnSelectColor(String color) {
    print("Selected Color: " + color);
    selectedColor = color;
  }

  _fnSelectSize(int indexSelected, String size) {
    selectedSizeHeader = size ?? '';
    selectedSizeIndex = indexSelected;
    setState(() {});
  }

  bool addToCartPressed() {
    // TODO - if product owner is same as logged in user then not allow to order it.
    if (product.id == AuthenticationService.appUserId) {
      ShowFlushToast(context, ToastType.INFO,
          Localization.of(context).productOwnerIsSameAsLoggedIn);
      return false;
    }

    cartStore
        .addItem(
      product,
      userId: userStore.details.id,
      fabric: selectedFabric,
      selectedColor: selectedColor,
      selectedSize: selectedSizeHeader,
    )
        .whenComplete(() {
      switch (cartStore.cartError) {
        case CartEvent.NONE:
          break;
        case CartEvent.PRODUCT_IN_CART:
          ShowFlushToast(this.context, ToastType.INFO,
              'This product is already in your cart');
          break;
        case CartEvent.NO_COLOR_SELECTED:
        case CartEvent.NO_SIZE_SELECTED:
          ShowFlushToast(
              this.context, ToastType.INFO, 'You must select color and size');
          break;

        case CartEvent.ADDED_SUCCESS:
          ShowFlushToast(
              this.context, ToastType.INFO, "Item added to cart successfully.");

          userStore.setUserDetails(
              userStore.details.copyWith(
                  cartCount: userStore.details.cartCount + 1
              )
          );
          break;
        case CartEvent.ERROR:
          ShowFlushToast(this.context, ToastType.INFO,
              "Was not possible finish the operation.");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //double containerMaxHeight = MediaQuery.of(context).size.height * 0.6;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Select Size",
                    style: TextStyle(
                      color: awBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _buildDropdownMenu(),
                ],
              ),
            ),
            SelectSize(
              indexSelected: selectedSizeIndex,
              sizesAvailable: _getSizeHeaders(dropdownSizeTypeSelected),
              onSizeSelected: _fnSelectSize,
            ),
          ],
        ),

        (product.availableColors.length > 0)
            ? SelectColor(product: product, callback: _fnSelectColor)
            : Container(),

//                  (product.fabricTags.length > 0) ?
//                    SelectFabric(
//                        product: product, callback: _fnSelectFabric) : Container(),
//
        SizedBox(height: 40.0),

        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: AwosheButton(
              radius: 30.0,
              onTap: addToCartPressed,
              childWidget: Text("Add to cart", style: buttonTextStyle),
              buttonColor: primaryColor,
            ),
          ),
        ),

        SizedBox(height: 50.0),
      ],
    );
  }

  Widget _buildDropdownMenu() {
    var sizeTypes = productStore.sizeMeasurementHeaders.keys.toList();

    if (sizeTypes.isEmpty) return Container();

    dropdownSizeTypeSelected ??= sizeTypes[0];

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: dropdownSizeTypeSelected,
        onChanged: (newValue) {
          print('Selected $newValue');
          setState(() {
            dropdownSizeTypeSelected = newValue;
            selectedSizeIndex = -1;
            selectedSizeHeader = '';
          });
        },
        items: sizeTypes
            .map<DropdownMenuItem>(
              (item) => DropdownMenuItem(
                  value: item, child: Text(Utils.capitalize(item))),
            )
            .toList(),
      ),
    );
  }

  List<String> _getSizeHeaders(String type) {
    if (type == null || type.isEmpty) return [];

    print('HEADERS ${productStore.sizeMeasurementHeaders[type]}');
    return productStore.sizeMeasurementHeaders[type] ?? [];
  }
}
