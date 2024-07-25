import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dp.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().loadCartItems();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'E-commerce Delivery App (Demo)',
              // theme: ThemeData(
              //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              //   useMaterial3: true,
              // ),
              initialRoute: RouteHelper.getSplashPage(),
              getPages: RouteHelper.routes,
            );
          },
        );
      },
    );
  }
}
