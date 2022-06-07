import 'package:Awoshe/components/product/product_image.dart';
import 'package:Awoshe/logic/stores/cart/cart_store.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/cart/cart_item_v2.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../leave_behind_view.dart';

class CartItemTile extends StatelessWidget {
  final UserStore userStore;
  final CartStore cartStore;

  CartItemTile({this.userStore, this.cartStore});

  @override
  Widget build(BuildContext context) {
    final List<CartItemV2> cartItems = cartStore.cart.items;
    final userCurrency = userStore.details.currency;
    final currencyStore = Provider.of<CurrencyStore>(context);

    return Column(
      children: cartItems.map<Widget>((currentCartItem) {
        Widget cartItemTile = Dismissible(
          key: Key(currentCartItem.itemId),
          background: LeaveBehindView(),
          onDismissed: (direction) {
            cartStore.removeItem(currentCartItem, userId: userStore.details.id);
            userStore.setUserDetails(userStore.details
                .copyWith(cartCount: userStore.details.cartCount - 1));
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  ProductImage(
                      imageUrl: currentCartItem.productImageUrl ??
                          PLACEHOLDER_DESIGN_IMAGE),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${currentCartItem.productTitle}',
                            style: textStyle1,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "${currentCartItem.productCreator?.name}",
                            style: const TextStyle(
                              color: awLightColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            "$userCurrency " + showCorrectItemPrice(currentCartItem, currencyStore),
                            style: textStyle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        /// CART ITEM ENDS
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              cartItemTile,
              Divider(height: 2.0),
            ],
          ),
        );
      }).toList(),
    );
  }

  String showCorrectItemPrice(CartItemV2 item, CurrencyStore store) {
    var value = PriceUtils.formatPriceToDouble( item.price );

    return PriceUtils.formatPriceToString( store.convertValue(value: value,
        from: item.currency, to: userStore.details.currency) );

  }
}
