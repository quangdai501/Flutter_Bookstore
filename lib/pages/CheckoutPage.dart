import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/controllers/checkout_controller.dart';
import 'package:final_project/controllers/checkout_info_controller.dart';
import 'package:final_project/models/address_info_model.dart';
import 'package:final_project/models/order_model.dart';
import 'package:final_project/routes/app_pages.dart';
import 'package:final_project/utils/convert_currency.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../components/AddressInfoItem.dart';
import '../components/BillDetaiItem.dart';

class CheckoutPage extends GetView<CheckoutController> {
  final CartController cartController = Get.find();
  final CheckoutInfoController checkoutInfoController = Get.find();
  CheckoutPage({Key? key}) : super(key: key);
  final indexOfList = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Thanh toán"),
        ),
        // backgroundColor: Colors.black12,
        body: ReactiveForm(
            formGroup:
                fb.group({'paymentMethod': FormControl<String>(value: "cash")}),
            child: Column(children: [
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                children: [ showListBillDetail(),addressInfo(), orderMethod()],
              )),
              createOrder()
            ])));
  }

  static const headerInfo = TextStyle(fontWeight: FontWeight.bold);

  Widget showAllAddressInfo() {
    return TextButton(
        onPressed: () {
          Get.defaultDialog(
              titleStyle: const TextStyle(fontSize: 16),
              title: "Danh sách địa chỉ nhận hàng",
              content: SizedBox(
                height: Get.height * 0.8,
                width: Get.width * 0.8,
                child: ReactiveForm(
                    formGroup: fb.group({
                      'addressInfo': FormControl<int>(value: indexOfList.value)
                    }),
                    child: Column(children: [
                      Expanded(
                          child: Obx(() => MasonryGridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 1,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                itemCount: controller.addressInfos.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      child: ReactiveRadioListTile(
                                    value: index,
                                    formControlName: 'addressInfo',
                                    title: AddressInfoItem(
                                        addressInfo:
                                            controller.addressInfos[index]),
                                  ));
                                },
                              ))),
                      ReactiveFormConsumer(
                        builder: (context, form, child) {
                          return ElevatedButton(
                            child: const Text('Chọn địa chỉ'),
                            onPressed: () {
                              indexOfList.value =
                                  form.value["addressInfo"] as int;
                            },
                          );
                        },
                      ),
                    ])),
              ));
        },
        child: const Text('Tất cả'));
  }

  Widget showAddressInfo() {
    return Obx(() {
      if(controller.isLoading.value){
        return const CircularProgressIndicator();
      }
      if (controller.addressInfos.isNotEmpty) {
        return Row(children: [
          Expanded(
              child: AddressInfoItem(
                  addressInfo: controller.addressInfos[indexOfList.value])),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.blue),
                onPressed: () {
                  Get.defaultDialog(
                      title: "Xóa địa chỉ giao hàng",
                      middleText: 'Bạn có muốn xóa',
                      onConfirm: () {
                        indexOfList.value = 0;
                        controller.removeAddressInfo(
                            controller.addressInfos[indexOfList.value].id);
                      },
                      onCancel: () {});
                },
              ),
              IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    await checkoutInfoController.changeAddressInfo(
                        controller.addressInfos[indexOfList.value]);
                    Get.toNamed(AppRoutes.CHECKOUT_INFO);
                  })
            ],
          )
        ]);
      }
      return const Text('Bạn chưa có địa chỉ nào');
    });
  }

  Widget addressInfo() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Đia chỉ nhận hàng",
                      style: headerInfo,
                    ),
                    // showAllAddressInfo()
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                showAddressInfo(),
                // TextButton(
                //     onPressed: () async {
                //       await checkoutInfoController.changeAddressInfo(
                //           AddressInfo(
                //               district: District(),
                //               province: District(),
                //               ward: Ward()));
                //       Get.toNamed(AppRoutes.CHECKOUT_INFO);
                //     },
                //     child: const Text('Thêm địa chỉ nhận hàng')),
              ],
            )));
  }

  Widget showListBillDetail() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              Row(
                children: const [
                  Text(
                    "Sản phẩm của bạn",
                    style: headerInfo,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(() => MasonryGridView.count(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 1,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: cartController.carts.length,
                    itemBuilder: (context, index) {
                      return BillDetailItem(
                        billDetail:
                            BillDetail.fromCart(cartController.carts[index]),
                      );
                    },
                  ))
            ])));
  }

  Widget amount(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Text(key), const SizedBox(width: 5), Text(value)],
    );
  }

  Widget orderMethod() {
    return Obx(() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "Phương thức thanh toán",
                      style: headerInfo,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                ReactiveRadioListTile(
                  formControlName: "paymentMethod",
                  value: "cash",
                  title: const Text('Thanh toán bằng tiển mặt'),
                ),
                const SizedBox(
                  height: 12,
                ),
                amount('Tổng tiền hàng:',
                    ConvertNumberToCurrency(cartController.total.value)),
                const SizedBox(height: 12),
                amount('Chi phí vận chuyển:',
                    ConvertNumberToCurrency(controller.shippingFee.value)),
                const SizedBox(height: 12),
                amount(
                    'Thành tiền:',
                    ConvertNumberToCurrency(cartController.total.value +
                        controller.shippingFee.value)),
              ],
            ))));
  }

  Widget createOrder() {
    return Obx(() {
      if (controller.addressInfos.isNotEmpty) {
        return ElevatedButton(
            onPressed: () {
              controller.createOrder(controller.addressInfos[indexOfList.value],
                  cartController.carts, cartController.total.value);
            },
            child: const Text('Thanh toán'));
      }
      return const Text('Bạn cần có địa chỉ để thanh toán');
    });
  }
}
