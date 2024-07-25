// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity; // for items of each of product

  late CartController _cart;
  int get totalItems => _cart.totalItems; // for total items of products
  List<CartModel> get getItems => _cart.getItemList;

  ProductController();

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    if (_cart.isExistInCart(product)) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    // log("[setQuantity] Quantity: $_quantity, _inCartItems: $_inCartItems, inCartItems: $inCartItems");
    update();
  }

  int checkQuantity(int quantity) {
    // log("[checkQuantity] Quantity: $quantity");
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainBlackColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > AppConstants.MAX_QUANTITY) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: AppColors.mainBlackColor,
        colorText: Colors.white,
      );
      return AppConstants.MAX_QUANTITY - _inCartItems;
    } else {
      return quantity;
    }
  }

  void addItemToCart(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    // _cart.items.forEach(
    //   (key, value) {
    //     log("Id: ${value.id}, quantity: ${value.quantity}");
    //   },
    // );
    update();
  }
}
