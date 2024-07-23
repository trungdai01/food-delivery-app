import 'dart:convert';
// import 'dart:developer';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final SharedPreferences sharedPreferences;
  List<String> cart = [];
  List<String> cartHistory = [];

  CartRepository({required this.sharedPreferences});

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    for (int index = 0; index < cartList.length; index++) {
      cart.add(jsonEncode(cartList[index]));
    }
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // log("[CART REPOSITORY] cart list: ${sharedPreferences.getStringList(AppConstants.CART_LIST)}");
  }

  List<CartModel> getCartList() {
    List<String> carts = sharedPreferences.containsKey(AppConstants.CART_LIST)
        ? sharedPreferences.getStringList(AppConstants.CART_LIST)!
        : [];
    List<CartModel> cartList = [];
    for (int index = 0; index < carts.length; index++) {
      cartList.add(CartModel.fromJson(jsonDecode(carts[index])));
    }
    return cartList;
  }

  void addToCartHistoryList() {
    for (int index = 0; index < cart.length; index++) {
      cartHistory.add(cart[index]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartHistoryList = [];

    for (int index = 0; index < cartHistory.length; index++) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(cartHistory[index])));
    }
    return cartHistoryList;
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
