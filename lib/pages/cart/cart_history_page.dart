import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CartModel> cartHistoryList = Get.find<CartController>().getCartHistoryList.reversed.toList();
    Map<String, int> itemsPerOrder = {};
    for (int index = 0; index < cartHistoryList.length; index++) {
      if (itemsPerOrder.containsKey(cartHistoryList[index].time)) {
        itemsPerOrder.update(cartHistoryList[index].time!, (value) => ++value);
      } else {
        itemsPerOrder.putIfAbsent(cartHistoryList[index].time!, () => 1);
      }
    }

    List<int> itemsPerOrderList = itemsPerOrder.entries.map((entry) => entry.value).toList();
    List<String> timeOrderList = itemsPerOrder.entries.map((entry) => entry.key).toList();
    var indexCounter = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(
              text: "My Cart History",
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // height: Dimensions.height20 * 1,
              margin: EdgeInsets.only(
                top: Dimensions.height10,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemsPerOrder.length,
                  itemBuilder: (context, order) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (() {
                          DateTime parseTime =
                              DateFormat("yyyy-MM-dd HH:mm:ss").parse(cartHistoryList[indexCounter].time!);
                          var inputTime = DateTime.parse(parseTime.toString());
                          var outputTime = DateFormat("dd/MM/yyyy HH:mm").format(inputTime);
                          return BigText(text: outputTime);
                        }()),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Dimensions.width10 * 25,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      children: List.generate(
                                        itemsPerOrderList[order],
                                        (item) {
                                          return Container(
                                            height: Dimensions.cartItem,
                                            width: Dimensions.cartItem,
                                            margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${cartHistoryList[indexCounter++].img!}",
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: Dimensions.cartItem,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SmallText(
                                    text: "Total",
                                    color: AppColors.titleColor,
                                  ),
                                  BigText(text: "${itemsPerOrderList[order]} Items"),
                                  GestureDetector(
                                    onTap: () {
                                      log(timeOrderList[order]);
                                      Map<int, CartModel> modifyOrderCart = {};
                                      for (int index = 0; index < cartHistoryList.length; index++) {
                                        if (cartHistoryList[index].time == timeOrderList[order]) {
                                          log("product id: ${cartHistoryList[index].id}");
                                          modifyOrderCart.putIfAbsent(
                                            cartHistoryList[index].id!,
                                            () => CartModel.fromJson(jsonDecode(jsonEncode(cartHistoryList[index]))),
                                          );
                                        }
                                      }
                                      Get.find<CartController>().setCartItems = modifyOrderCart;
                                      Get.find<CartController>().addToCartRepository();
                                      Get.toNamed(RouteHelper.getFoodCart());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                        vertical: Dimensions.height10 / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                      child: const SmallText(
                                        text: "See more",
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
