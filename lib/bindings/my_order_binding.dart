import 'package:final_project/controllers/my_order_controller.dart';
import 'package:final_project/provider/my_order_provider.dart';
import 'package:get/get.dart';

class MyOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderProvider>(
      () => MyOrderProvider(),
    );
    Get.lazyPut<MyOrderController>(
      () => MyOrderController(),
    );
  }
}
