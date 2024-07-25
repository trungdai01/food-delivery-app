import 'package:food_delivery/pages/home/home_page.dart';
// import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/intro/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String foodCart = "/food-cart";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood({required int pageId, required String arrivalPage}) {
    return "$popularFood?pageId=$pageId&arrivalPage=$arrivalPage";
  }

  static String getRecommendedFood({required int pageId, required String arrivalPage}) {
    return "$recommendedFood?pageId=$pageId&arrivalPage=$arrivalPage";
  }

  static String getFoodCart() => foodCart;

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: initial,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters["pageId"];
        var arrivalPage = Get.parameters["arrivalPage"];
        return PopularFoodDetail(
          pageId: int.parse(pageId!),
          arrivalPage: arrivalPage!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters["pageId"];
        var arrivalPage = Get.parameters["arrivalPage"];
        return RecommendedFoodDetail(
          pageId: int.parse(pageId!),
          arrivalPage: arrivalPage!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: foodCart,
      page: () {
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
