import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repository.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepository cartRepository;

  final Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  CartController({required this.cartRepository});

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(
        product.id!,
        (productInCart) {
          totalQuantity = productInCart.quantity! + quantity;
          return CartModel(
            id: productInCart.id,
            name: productInCart.name,
            img: productInCart.img,
            price: productInCart.price,
            quantity: productInCart.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
          );
        },
      );
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          product.id!,
          () {
            log("[CART CONTROLLER] Adding item to the cart id: ${product.id!}, quantity: $quantity");
            return CartModel(
              id: product.id,
              name: product.name,
              img: product.img,
              price: product.price,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
            );
          },
        );
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add in one item in the cart!",
          backgroundColor: AppColors.mainBlackColor,
          colorText: Colors.white,
        );
      }
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.forEach(
        (key, value) {
          if (key == product.id!) {
            quantity = value.quantity!;
          }
        },
      );
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach(
      (key, value) {
        totalQuantity += value.quantity!;
      },
    );
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map(
      (e) {
        return e.value;
      },
    ).toList();
  }
}
