import 'package:final_project/provider/address_info_provider.dart';
import 'package:final_project/provider/ghn_provider.dart';
import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';
import '../controllers/checkout_info_controller.dart';
import '../provider/my_order_provider.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GHNProvider>(
      () => GHNProvider(),
    );
    Get.lazyPut<AddressInfoProvider>(
      () => AddressInfoProvider(),
    );
    Get.lazyPut<MyOrderProvider>(
      () => MyOrderProvider(),
    );
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
    Get.lazyPut<CheckoutInfoController>(
      () => CheckoutInfoController(),
    );
  }
}
