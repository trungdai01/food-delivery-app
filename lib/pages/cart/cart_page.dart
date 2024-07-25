// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/empty_cart_page.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 + 40,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.initial);
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (cartController) {
              return cartController.cartItems.isNotEmpty
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (cartController) {
                              List<CartModel> itemList = cartController.getItemList;
                              return ListView.builder(
                                itemCount: itemList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 100,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularProductIndex = Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(itemList[index].product!);
                                            // var cartPage = RouteHelper.getFoodCart();
                                            if (popularProductIndex >= 0) {
                                              Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                  pageId: popularProductIndex,
                                                  arrivalPage: RouteHelper.getFoodCart(),
                                                ),
                                              );
                                            } else {
                                              var recommendedProductIndex = Get.find<RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(itemList[index].product!);
                                              if (recommendedProductIndex < 0) {
                                                Get.snackbar(
                                                  "History product",
                                                  "Product review is no longer available for this product",
                                                  backgroundColor: AppColors.mainColor,
                                                  colorText: Colors.white,
                                                );
                                              } else {
                                                Get.toNamed(
                                                  RouteHelper.getRecommendedFood(
                                                    pageId: recommendedProductIndex,
                                                    arrivalPage: RouteHelper.getFoodCart(),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${itemList[index].img}",
                                                ),
                                              ),
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        Expanded(
                                          child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: cartController.getItemList[index].name!,
                                                  color: Colors.black54,
                                                ),
                                                const SmallText(text: "Juice"),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: "\$${cartController.getItemList[index].price}",
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(itemList[index].product!, -1);
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: AppColors.signColor,
                                                              ),
                                                            ),
                                                            SizedBox(width: Dimensions.width10 / 2),
                                                            BigText(text: "${itemList[index].quantity}"),
                                                            SizedBox(width: Dimensions.width10 / 2),
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(itemList[index].product!, 1);
                                                              },
                                                              child: const Icon(Icons.add, color: AppColors.signColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : const EmptyCartPage(notificationText: "My cart is empty");
            },
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.height30,
              horizontal: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: cartController.cartItems.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(width: Dimensions.width10 / 2),
                              BigText(text: "\$ ${cartController.totalAmount}"),
                              SizedBox(width: Dimensions.width10 / 2),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cartController.addToCartHistoryList();
                          // cartController.cartRepository.getCartHistoryList();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: const Center(
                            child: BigText(
                              text: "Checkout",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
