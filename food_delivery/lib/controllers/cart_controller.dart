import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repository.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepository cartRepository;
  Map<int, CartModel> _cartItems = {};
  Map<int, CartModel> get cartItems => _cartItems;
  List<CartModel> storageItems = [];

  CartController({required this.cartRepository});

  bool isExistInCart(ProductModel product) {
    if (_cartItems.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
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
        _cartItems.remove(product.id);
      }
    } else if (quantity > 0) {
      _cartItems.putIfAbsent(
        product.id!,
        () {
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
    addToCartRepository();
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_cartItems.containsKey(product.id)) {
      quantity = _cartItems[product.id]!.quantity!;
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _cartItems.forEach(
      (key, product) {
        totalQuantity += product.quantity!;
      },
    );
    return totalQuantity;
  }

  int get totalAmount {
    var total = 0;
    _cartItems.forEach(
      (key, product) {
        total += product.quantity! * product.price!;
      },
    );
    return total;
  }

  List<CartModel> get getItemList {
    return _cartItems.entries.map(
      (entry) {
        return entry.value;
      },
    ).toList();
  }

  set setItemList(List<CartModel> itemList) {
    storageItems = itemList;
    for (int i = 0; i < storageItems.length; i++) {
      _cartItems.putIfAbsent(
        storageItems[i].product!.id!,
        () => storageItems[i],
      );
    }
  }

  List<CartModel> loadCartItems() {
    setItemList = cartRepository.getItemList();
    return storageItems;
  }

  void addToCartHistoryList() {
    cartRepository.addToCartHistoryList();
    clearCart();
  }

  List<CartModel> get getCartHistoryList => cartRepository.getCartHistoryList();

  set setCartItems(Map<int, CartModel> cartItems) {
    _cartItems = {};
    _cartItems = cartItems;
  }

  void addToCartRepository() {
    cartRepository.addToCartRepository(getItemList);
    update();
  }

  void clearCart() {
    _cartItems = {};
    update();
  }
}
