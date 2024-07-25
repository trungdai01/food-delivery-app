import 'dart:convert';
import 'dart:developer';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final SharedPreferences sharedPreferences;
  List<String> cartRepository = []; // List of JSON strings
  List<String> cartHistory = []; // List of JSON strings

  CartRepository({required this.sharedPreferences});

  void addToCartRepository(List<CartModel> itemList) {
    cartRepository = [];
    var timeAddToCart = DateTime.now().toString();
    for (int index = 0; index < itemList.length; index++) {
      itemList[index].time = timeAddToCart;
      cartRepository.add(jsonEncode(itemList[index]));
    }
    sharedPreferences.setStringList(AppConstants.CART_LIST, cartRepository);
    // log("[CART REPOSITORY] cartRepository list: ${sharedPreferences.getStringList(AppConstants.CART_LIST)}");
  }

  List<CartModel> getItemList() {
    List<String> itemStringList = sharedPreferences.containsKey(AppConstants.CART_LIST)
        ? sharedPreferences.getStringList(AppConstants.CART_LIST)!
        : [];
    List<CartModel> itemList = [];
    for (int index = 0; index < itemStringList.length; index++) {
      itemList.add(CartModel.fromJson(jsonDecode(itemStringList[index])));
    }
    return itemList;
  }

  void addToCartHistoryList() {
    for (int index = 0; index < cartRepository.length; index++) {
      cartHistory.add(cartRepository[index]);
    }
    removeCartRepository();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> itemHistoryList = [];

    for (int index = 0; index < cartHistory.length; index++) {
      itemHistoryList.add(CartModel.fromJson(jsonDecode(cartHistory[index])));
    }
    log("[CART REPOSITORY] cartHistoryList: ${itemHistoryList[0].time}");
    return itemHistoryList;
  }

  void removeCartRepository() {
    cartRepository = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
