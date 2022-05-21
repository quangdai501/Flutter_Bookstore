import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:final_project/controllers/auth_controller.dart';
import 'package:final_project/routes/app_pages.dart';
import 'package:get/get.dart';

class EnterCodeMiddleware extends GetMiddleware {
//   Get the auth service
  final authController = Get.find<AuthController>();

//   The default is 0 but you can update it to any number. Please ensure you match the priority based
//   on the number of guards you have.
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Navigate to login if client is not authenticated other wise continue
    if (authController.isForgotPassword.value ||
        authController.isForgotPassword.value) {
      return super.redirect(route);
    }
    Get.snackbar("Lỗi xác thực", "Bạn Không thể vào trang này");
    return const RouteSettings(name: AppRoutes.LOGIN);
  }
}
