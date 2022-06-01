import 'package:final_project/models/address_info_model.dart';
import 'package:final_project/provider/address_info_provider.dart';
import 'package:final_project/provider/my_order_provider.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../provider/ghn_provider.dart';

class CheckoutController extends GetxController {
  GHNProvider ghnProvider = Get.find();
  AddressInfoProvider addressInfoProvider = Get.find();
  MyOrderProvider myOrderProvider = Get.find();
  final shippingFee = 15000.obs;
  final addressInfos = <AddressInfo>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAddressInfo();
  }

  fetchAddressInfo() async {
    try {
      isLoading.value = true;
      var data = await addressInfoProvider.getAllAddressInfo();
      addressInfos.value = data;
      isLoading.value = false;
      if (data.isNotEmpty) {
        calculateShippingFee(data[0].district.id, data[0].ward.id);
      }
      // ignore: empty_catches
    } catch (ex) {
      isLoading.value = false;
    }
  }

  removeAddressInfo(var id) async {
    try {
      await addressInfoProvider.deleteAddressInfo(id);
      Get.snackbar('Xóa địa chỉ giao hàng', 'Xóa địa chỉ giao hàng thành công');
      fetchAddressInfo();
    } catch (ex) {
      Get.snackbar('Xóa địa chỉ giao hàng', 'Xóa địa chỉ giao hàng thất bại');
    }
  }

  calculateShippingFee(var districtId, var wardCode) async {
    var item = 1;
    try {
      var body = {
        "from_district_id": 1459,
        "service_id": 53320,
        "service_type_id": null,
        "to_district_id": districtId,
        "to_ward_code": wardCode,
        "height": item,
        "length": 20,
        "weight": 100 * item,
        "width": 10,
        "insurance_value": 10000,
        "coupon": null
      };
      var data = await ghnProvider.getShippingFee(body);
      // print(data);
      shippingFee.value = data;
    }
    // ignore: empty_catches
    catch (ex) {}
  }

  createOrder(AddressInfo addressInfo, List<Cart> carts, var total,
      Function clearCart) async {
    try {
      Address address = Address(
          toWardCode: addressInfo.ward.id,
          toDistrictId: addressInfo.district.id.toString(),
          province: addressInfo.province.name,
          district: addressInfo.district.name,
          ward: addressInfo.ward.name,
          detail: addressInfo.address);

      List<BillDetail> billDetails = billDetailFromCart(carts);

      var order = Order(
              address: address,
              // payment: 'Thanh toán khi nhận hàng',
              billDetail: billDetails,
              name: addressInfo.name,
              total: total + shippingFee.value,
              phone: addressInfo.phone)
          .toJson();
      // return order;
      bool isOrderSuccess = await myOrderProvider.createOrder(order);
      if (isOrderSuccess) {
        Get.snackbar('Đặt hàng', 'Đặt hành thành công');
        bool isSendMail = await myOrderProvider.sendMail({
          "userInfo": {"name": addressInfo.name},
          "cartItems": carts
        });
        clearCart();
        if (isSendMail) {
          Get.snackbar('Đặt hàng', 'Chúng tôi vừa gửi mail tới bạn');
        }
        Get.offNamed(AppRoutes.ORDER_SUCCESS);
      } else {
        Get.snackbar('Đặt hàng', 'Đặt hàng thấy bại');
      }
    }
    // ignore: empty_catches
    catch (ex) {
      Get.snackbar('Đặt hàng', ex.toString());
    }
  }
}
