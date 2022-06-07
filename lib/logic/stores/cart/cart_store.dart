import 'package:Awoshe/logic/services/CartServiceV2.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/cart/cart_item_v2.dart';
import 'package:Awoshe/models/cart/cart_v2.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:Awoshe/models/order/order_item.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

enum CartEvent {
  NONE,
  PRODUCT_IN_CART,
  NO_COLOR_SELECTED,
  NO_SIZE_SELECTED,
  ADDED_SUCCESS,
  ERROR
}
abstract class _CartStore with Store {

  static ObservableFuture<CartV2> emptyResponse = ObservableFuture.value(CartV2.empty());
  final CartServiceV2 _cartServiceV2 = CartServiceV2();
  final CurrencyStore currencyStore;
  final UserStore userStore;

  @observable
  ObservableFuture<CartV2> cartFuture = emptyResponse;

  //@observable
  CartV2 cart = CartV2.empty();

  @observable
  double cartTotal = 0.0;

  @observable
  bool isEmpty = true;

  double _shippingCharge = 0.0;
  double _taxCharge = 0.0;

  double get shippingCharge => currencyStore.convertValue(
      value: _shippingCharge,
      from: 'USD',
      to: userStore.details.currency
  );

  double get taxCharge => currencyStore.convertValue(
      value: _taxCharge,
      from: 'USD',
      to: userStore.details.currency
  );

  @observable
  CartEvent cartError = CartEvent.NONE;

  _CartStore(this.currencyStore, this.userStore);

  @action setCartEvent(CartEvent data) => cartError = data;

  @action Future<CartV2> getCart(String userId) async {
    final future = _cartServiceV2.getCart(userId: userId);
    cartFuture = ObservableFuture<CartV2>(future);
    cart = await future;
    print(cart.toJson());
    setEmpty(cart.items.isEmpty);
    setCartTotal();
    return cart;
  }

  @action void setEmpty(bool flag) => isEmpty = flag;

  Future<void> addItem(Product product, { @required String fabric,
    @required String selectedColor, Map<dynamic, dynamic> measurements,
    @required String userId, @required String selectedSize, bool validateSize = true}) async {
    try {
      if (selectedColor == null || selectedColor.isEmpty) {
        setCartEvent(CartEvent.NO_COLOR_SELECTED);
        return;
      }

      if (validateSize) {
        if (selectedSize == null || selectedSize.isEmpty) {
          setCartEvent(CartEvent.NO_SIZE_SELECTED);
          return;
        }
      }

      if (_containsItem(product.id)) {
        setCartEvent(CartEvent.PRODUCT_IN_CART);
        return;
      }

      else {
        CartItemV2 item = CartItemV2(
            productId: product.id,
            productTitle: product.title,
            price: product.price,
            fabric: fabric,
            productImageUrl: product.imageUrl,
            //productQuantity: event.quantity,
            selectedColor: selectedColor,
            currency: product.currency,
            productCreator: product.creator,
            selectedSize: selectedSize,
            measurements: measurements,
            collectionId: product.collection?.id,
            itemId: product.itemId
        );

        cart.items.add(item);
        setCartTotal();
        setEmpty(cart.items.isEmpty);

        _cartServiceV2.updateCart(cart: cart, userId: userId);
        setCartEvent(CartEvent.ADDED_SUCCESS);
      }

    }
    catch (ex) {
      print('Error when tried add item to the cart. $ex');
      setCartEvent(CartEvent.ERROR);
    }
  }

  Future<void> removeItem(CartItemV2 item, {@required String userId}) async {
    try {
      print('Before removing ${cart.items.length}');

      cart.items.removeWhere((i) => i.itemId == item.itemId);
      if (cart.items.isEmpty) {
        _cartServiceV2.clearCart(userId: userId);
        setEmpty(cart.items.isEmpty);
      }

      setCartTotal();
      await _cartServiceV2.updateCart(cart: cart, userId: userId);
      print('After removing ${cart.items.length}');
    }
    catch (ex) {
      print('Error when trying remove item from cart. $ex');
      setCartEvent(CartEvent.ERROR);
    }
  }

  void clearCart({String userId, UserStore userStore}) async {
    _cartServiceV2.clearCart(userId: userId);
    setEmpty(true);
    cart.items.clear();
    userStore.setUserDetails(
        userStore.details.copyWith(
            cartCount: 0
        )
    );
  }

  @action void setCartTotal() {
    cartTotal = .0;
    cart.items.forEach(
            (item) {
              var price = PriceUtils.formatPriceToDouble(item.price);
              cartTotal += currencyStore.convertValue(
                  value: price,
                  from: item.currency ,
                  to: userStore.details.currency
              );
            });
  }


  bool _containsItem(String id) {
    var flag = false;
    for (var i = 0; i < cart.items.length; i++) {
      if (cart.items[i].productId == id) {
        flag = true;
        break;
      }
    }
    return flag;
  }

  Order prepareUserOrder(String paymentCurrency) {

    double itemsTotal = cartTotal;
    return Order(
      currency: paymentCurrency,
      orderItems: cart.items.map((CartItemV2 cartItem) {

       return OrderItem.fromJson(cartItem.toJson());
      }).toList(),
      shippingCharge: shippingCharge,
      taxCharge: taxCharge,
      itemsTotal: itemsTotal,
      total: (itemsTotal + shippingCharge + taxCharge),
    );
  }

  @computed double get totalBill => cartTotal + shippingCharge + taxCharge;

  @computed
  FutureStatus get getStatus => cartFuture.status;

  @computed bool get cartEmpty => cart.items.isEmpty;

  @computed
  bool get hasResults =>
      cartFuture != emptyResponse &&
          cartFuture.status == FutureStatus.fulfilled;
}