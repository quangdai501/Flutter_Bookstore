import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/pages/ProfilePage.dart';
import 'package:final_project/pages/CartPage.dart';
import 'package:final_project/pages/HomePage.dart';
import 'package:final_project/pages/ShopPage.dart';

import '../controllers/dashboard_controller.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(),
                const ShopPage(),
                CartPage(),
                const ProfilePage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.lightBlue,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: "Danh sách"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Giỏ hàng"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Tài khoản"),
            ],
          ),
        );
      },
    );
  }
}
