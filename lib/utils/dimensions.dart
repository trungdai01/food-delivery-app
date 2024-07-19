import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.78;
  static double pageViewContainer = screenHeight / 4.05;
  static double pageViewTextContainer = screenHeight / 6.85;

  // dynamic height with padding and margin
  static double height10 = screenHeight / 89.0;
  static double height15 = screenHeight / 59.3;
  static double height20 = screenHeight / 44.5;
  static double height30 = screenHeight / 29.67;
  static double height45 = screenHeight / 19.78;

  // dynamic width padding and margin
  static double width10 = screenHeight / 89.0;
  static double width15 = screenHeight / 59.3;
  static double width20 = screenHeight / 44.5;
  static double width30 = screenHeight / 29.67;

  //font size
  static double font16 = screenHeight / 55.625;
  static double font20 = screenHeight / 44.5;
  static double font26 = screenHeight / 34.23;

  //radius
  static double radius20 = screenHeight / 44.5;
  static double radius15 = screenHeight / 59.3;
  static double radius30 = screenHeight / 29.67;

  // icon size (pivot: 24)
  static double iconSize16 = screenHeight / 55.625;
  static double iconSize24 = screenHeight / 37.09;

  // list view size
  static double listViewImageSize = screenWidth / 3.425;
  static double listViewTextContainerSize = screenWidth / 4.11;

  // popular food
  static double popularFoodImageSize = screenHeight / 2.54;

  // bottom height
  static double bottomHeightBar = screenHeight / 7.42;
}
