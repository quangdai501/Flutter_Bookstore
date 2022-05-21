import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
//   Get the auth service
  final authController = Get.find<UserController>();

//   The default is 0 but you can update it to any number. Please ensure you match the priority based
//   on the number of guards you have.
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Navigate to login if client is not authenticated other wise continue
    if (authController.isLogin.value) {
      return super.redirect(route);
    }
    Get.snackbar("Lỗi xác thực", "Bạn cần phải đăng nhập để vào trang này");
    return const RouteSettings(name: AppRoutes.LOGIN);
  }
}
