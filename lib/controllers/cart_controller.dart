import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repository.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepository cartRepository;
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  CartController({required this.cartRepository});

  bool isExistInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (thisProductInCart) {
          totalQuantity = thisProductInCart.quantity! + quantity;
          return CartModel(
            id: thisProductInCart.id,
            name: thisProductInCart.name,
            img: thisProductInCart.img,
            price: thisProductInCart.price,
            quantity: thisProductInCart.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
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
            log("[CART CONTROLLER] Adding a new item to the cart id: ${product.id!}, quantity: $quantity");
            return CartModel(
              id: product.id,
              name: product.name,
              img: product.img,
              price: product.price,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product,
            );
          },
        );
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add in one item into the cart!",
          backgroundColor: AppColors.mainBlackColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepository.addToCartList(getItems);
    update();
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      quantity = _items[product.id]!.quantity!;
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach(
      (key, product) {
        totalQuantity += product.quantity!;
      },
    );
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map(
      (entry) {
        return entry.value;
      },
    ).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach(
      (key, product) {
        total += product.quantity! * product.price!;
      },
    );
    return total;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(
        storageItems[i].product!.id!,
        () => storageItems[i],
      );
    }
  }

  List<CartModel> getCartData() {
    setCart = cartRepository.getCartList();
    return storageItems;
  }

  void addToCartHistoryList() {
    cartRepository.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }
}
