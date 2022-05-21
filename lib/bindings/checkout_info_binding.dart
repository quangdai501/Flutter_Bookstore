import 'package:final_project/controllers/checkout_info_controller.dart';
import 'package:final_project/provider/address_info_provider.dart';
import 'package:final_project/provider/ghn_provider.dart';
import 'package:get/get.dart';

class CheckoutInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GHNProvider>(
      () => GHNProvider(),
    );
    Get.lazyPut<AddressInfoProvider>(
      () => AddressInfoProvider(),
    );
    Get.lazyPut<CheckoutInfoController>(
      () => CheckoutInfoController(),
    );
  }
}
