import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repository/auth_repository.dart';
import 'package:food_delivery/data/repository/cart_repository.dart';
import 'package:food_delivery/data/repository/popular_product_repository.dart';
import 'package:food_delivery/data/repository/recommended_product_repository.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // repository
  Get.lazyPut(() => PopularProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find()));

  // controller
  Get.lazyPut(() => PopularProductController(popularProductRepository: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepository: Get.find()));
  Get.lazyPut(() => CartController(cartRepository: Get.find()));
  Get.lazyPut(() => ProductController());
  Get.lazyPut(() => AuthController(authRepository: Get.find()));
}
