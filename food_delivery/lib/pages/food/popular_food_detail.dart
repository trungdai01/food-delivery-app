// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String arrivalPage;
  const PopularFoodDetail({super.key, required this.pageId, required this.arrivalPage});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<ProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${product.img!}"),
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45 + 10,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(arrivalPage);
                  },
                  child: const AppIcon(icon: Icons.arrow_back),
                ),
                GetBuilder<ProductController>(
                  builder: (productController) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getFoodCart());
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_outlined),
                          productController.totalItems > 0
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: Dimensions.height20,
                                    height: Dimensions.height20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.mainColor,
                                    ),
                                    child: Center(
                                      child: BigText(
                                        text: "${productController.totalItems}",
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImageSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name,
                    ratingStars: product.stars,
                  ),
                  SizedBox(height: Dimensions.height20),
                  const BigText(text: "Introduction"),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<ProductController>(
        builder: (productController) {
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
            child: Row(
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
                        GestureDetector(
                          onTap: () {
                            productController.setQuantity(false);
                          },
                          child: const Icon(Icons.remove, color: AppColors.signColor),
                        ),
                        SizedBox(width: Dimensions.width10 / 2),
                        BigText(text: "${productController.inCartItems}"),
                        SizedBox(width: Dimensions.width10 / 2),
                        GestureDetector(
                          onTap: () {
                            productController.setQuantity(true);
                          },
                          child: const Icon(Icons.add, color: AppColors.signColor),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    productController.addItemToCart(product);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Center(
                      child: BigText(
                        text: "\$${product.price!} | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
