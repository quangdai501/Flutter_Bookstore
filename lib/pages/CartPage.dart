import 'package:final_project/controllers/dashboard_controller.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/routes/app_pages.dart';
import 'package:final_project/utils/convert_currency.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../components/CartItem.dart';

// ignore: must_be_immutable
class CartPage extends GetView<CartController> {
  UserController userController = Get.find();
DashboardController dbController = Get.put(DashboardController());

  CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () => Get.back(),
          ),
          title: const Text("Giỏ hàng", style: TextStyle(color: Colors.black54)),
          centerTitle: true,
        ),
        body: Obx(() => showListCart()));
  }

  Widget showListCart() {
    if (controller.carts.isEmpty) {
      return Center(
          child: Column(children: [
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () => {dbController.changeTabIndex(1)},
                child: const Text('Mua hàng ngay'))
          ]));
    }
    return Column(children: [
      Expanded(
          child: MasonryGridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: controller.carts.length,
            itemBuilder: (context, index) {
              // return ProducWidget(state![index]);
              return CartItem(
                cart: controller.carts[index],
                index: index,
              );
            },
          )),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Thành tiền: " +
                          ConvertNumberToCurrency(controller.total.value)),
                    )
                  ],
                )),
            Obx(() => checkout())
          ],
        ),
      )
    ]);
  }

  Widget checkout() {
    var route = AppRoutes.LOGIN;
    var title = 'Đăng nhập ngay';
    if (userController.isLogin.value) {
      route = AppRoutes.CHECKOUT;
      title = 'Thanh toán ngay';
    }
    return ElevatedButton(
        onPressed: () => {Get.toNamed(route)}, child: Text(title));
  }
}
