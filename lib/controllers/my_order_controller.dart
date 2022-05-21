import 'package:final_project/models/order_model.dart';
import 'package:final_project/provider/my_order_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyOrderController extends GetxController with StateMixin<List<Order>>   {
  final box = GetStorage();
  MyOrderProvider myOrderProvider = Get.find();

  @override
  void onInit() {
    super.onInit();
    getOrder();
  }

  getOrder([var type = 0]) async {
    try {
      var userInfo = await box.read("userInfo");
      if (userInfo == null) {
        return;
      }
      change(null, status: RxStatus.loading());
      var data = await myOrderProvider.getAllOrder(userInfo["_id"], type);
      if (data.isEmpty) {
        change(data, status: RxStatus.empty());
        return;
      }
      change(data, status: RxStatus.success());
    } catch (ex) {
      change(null, status: RxStatus.error());
    }
  }
}
