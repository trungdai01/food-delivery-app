import 'dart:developer';
import 'package:food_delivery/data/repository/popular_product_repository.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepository popularProductRepository;
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  PopularProductController({required this.popularProductRepository});

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepository.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      log("[POP-PRODUCT-CTRL] Could not get popular products");
    }
  }
}
