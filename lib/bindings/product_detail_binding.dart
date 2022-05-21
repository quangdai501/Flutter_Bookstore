import 'package:final_project/controllers/product_detail_controller.dart';

import 'package:get/get.dart';

import '../provider/product_provider.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(ProductProvider());
    Get.lazyPut<ProductProvider>(
      () => ProductProvider(),
    );
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(),
    );
  }
}
