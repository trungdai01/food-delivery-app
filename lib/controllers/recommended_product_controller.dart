import 'dart:developer';
import 'package:food_delivery/data/repository/recommended_product_repository.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepository recommendedProductRepository;
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  RecommendedProductController({required this.recommendedProductRepository});

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepository.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.deserialize(response.body).products);
      _isLoaded = true;
      update(); // setState
    } else {
      log("[RCD-PRODUCT-CTRL] Could not get recommended products");
    }
  }
}
