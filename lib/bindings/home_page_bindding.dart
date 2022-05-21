import 'package:final_project/controllers/home_page_controller.dart';
import 'package:get/get.dart';

import '../controllers/filter_controller.dart';
import '../controllers/product_detail_controller.dart';
import '../provider/product_provider.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(ProductProvider());
    Get.lazyPut<ProductProvider>(
      () => ProductProvider(),
    );
    Get.lazyPut<HomePageController>(
      () => HomePageController(),
    );
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(),
    );
    Get.lazyPut<FilterController>(
      () => FilterController(),
    );
  }
}
