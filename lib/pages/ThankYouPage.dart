import 'package:final_project/controllers/dashboard_controller.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/routes/app_pages.dart';

import 'package:get/get.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardController dbController = Get.put(DashboardController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:
              Align(alignment: Alignment.center, child: const Text("Cảm ơn bạn đã mua hàng")),
        ),
        body: Center(
            child: Column(children: [
          const SizedBox(height: 200),
          Image.asset(
            'assets/images/order_success.png',
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 12),
          const Text(
            'Đặt hàng thành công',
            style: TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              dbController.changeTabIndex(1);
              Get.toNamed(AppPages.rootPage);
            },
            child: const Text('Tiếp tục mua sắm'),
          ),
          const SizedBox(height: 12),
          TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.PROFILE);
              },
              child: const Text('Lịch sử mua hàng'))
        ])));
  }
}
