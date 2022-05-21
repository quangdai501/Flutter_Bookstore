import 'package:final_project/controllers/filter_controller.dart';
import 'package:get/get.dart';

class FilterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(
      () => FilterController(),
    );
  }
}
