import 'package:final_project/controllers/auth_controller.dart';
import 'package:final_project/controllers/filter_controller.dart';
import 'package:final_project/controllers/home_page_controller.dart';
import 'package:final_project/controllers/my_order_controller.dart';
import 'package:final_project/controllers/product_detail_controller.dart';
import 'package:final_project/controllers/shop_page_controller.dart';
import 'package:final_project/pages/HomePage.dart';
import 'package:final_project/provider/auth_provider.dart';
import 'package:final_project/provider/my_order_provider.dart';
import 'package:final_project/provider/product_provider.dart';
import 'package:final_project/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/cart_controller.dart';
import 'controllers/user_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';

void main() async {
  await GetStorage.init();
  Get.lazyPut<AuthProvider>(() => AuthProvider());
  Get.lazyPut<UserProvider>(() => UserProvider());
  Get.lazyPut<CartController>(() => CartController());
  Get.lazyPut<UserController>(() => UserController());
  Get.lazyPut<HomePageController>(() => HomePageController());
  Get.lazyPut<ProductProvider>(() => ProductProvider());
  Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  Get.lazyPut<ShopPageController>(() => ShopPageController());
  Get.lazyPut<AuthProvider>(() => AuthProvider());
  Get.lazyPut(() => MyOrderProvider());
  Get.lazyPut(()=>FilterController());


  Get.put(MyOrderController());
  Get.put(FilterController());
  Get.put(AuthController());
  Get.put(CartController());
  Get.put(UserController());
  Get.put(HomePageController());
  Get.put(ShopPageController());
  Get.put(ProductDetailController());
  Get.lazyPut<AuthController>(() => AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white
    // ));
    return GetMaterialApp(
      initialRoute: AppPages.rootPage,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
