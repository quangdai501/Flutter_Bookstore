import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/provider/auth_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:final_project/routes/app_routes.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  UserController userController = Get.find();
  AuthProvider authProvider = Get.find();
  final box = GetStorage();

  // register
  final registerInfo = {}.obs;
  // ignore: non_constant_identifier_names
  final isEmailExits_regis = false.obs;
  final isRegister = false.obs;

  //forgot pass
  // ignore: non_constant_identifier_names
  final isEmailExits_forgot = false.obs;
  final emailForgotPassword = "".obs;
  final isForgotPassword = false.obs;
  final isEnterCode = false.obs;
  // entercode
  final isInValidCode = false.obs;
  final loginSuccesfull = false.obs;
  final isLoading = false.obs;

  void login(var loginInfo) async {
    try {
      isLoading.value = true;
      var data = await authProvider.login({
        "email": loginInfo['email'].toLowerCase(),
        "password": loginInfo['password']
      });
      // print(data);
      await box.write("userInfo", data);
      loginSuccesfull.value = true;
      isLoading.value = false;

      //load user
      // ignore: invalid_use_of_protected_member
      userController.loadUserInfoFromStorage();
      Get.offNamed(AppRoutes.DASHBOARD);
      // go to home
    } catch (exception) {
      loginSuccesfull.value = false;
      isLoading.value = false;
      Get.snackbar('Đăng nhập', 'Sai tài khoản hoặc mật khẩu');
    }
  }

  //
  resetAll() {
    // register
    isEmailExits_regis.value = false;
    registerInfo.value = {};
    registerInfo.refresh();
    isRegister.value = false;

    //forgot pass
    emailForgotPassword.value = "";
    isForgotPassword.value = false;
    isEnterCode.value = false;
    // entercode
    isInValidCode.value = false;
  }

  setFalseInvalidCode() {
    isInValidCode.value = false;
  }

  switchEnterCode(var formdata) {
    if (isRegister.value) {
      registerEnterCode(formdata);
      return;
    }
    forgotPasswoodEnterCode(formdata);
  }

  // register step 1
  void registerSentCodeToEmail(var formdata) async {
    try {
      isLoading.value = true;
      var data = await authProvider.registerSentCodeToEmail({
        "email": formdata['email'].toLowerCase(),
        "name": formdata['name'],
        "password": formdata['password']
      });
      if (data['data'] != null && data['data'].isNotEmpty) {
        isRegister.value = true;
        registerInfo.value = formdata;
        registerInfo.refresh();
        Get.toNamed(AppRoutes.ENTER_CODE);
      } else {
        isEmailExits_regis.value = true;
      }
      isLoading.value = false;
    } catch (exception) {
      isLoading.value = false;
      Get.snackbar('Đăng ký', 'Đăng ký thất bại');
    }
  }

// register step 2
  void registerEnterCode(var formdata) async {
    try {
      isLoading.value = true;
      var data = await authProvider.registerEnterCode({
        "code": formdata["code"],
      });
      if (data['data'] != null && data['data'].isNotEmpty) {
        resetAll();
        Get.snackbar('Đăng ký', 'Đăng ký thành công');
        Get.toNamed(AppRoutes.LOGIN);
      } else {
        isInValidCode.value = true;
      }
      isLoading.value = false;
    } catch (exception) {
      isLoading.value = false;
      Get.snackbar('Đăng ký', 'Đăng ký thất bại');
    }
  }

  // forgot password step 1
  forgotPasswoodSentCode(var formdata) async {
    try {
      isLoading.value = true;
      var data = await authProvider.forgotPasswoodSentCode({
        "email": formdata['email'].toLowerCase(),
      });
      if (data['status'] != null && data['status'].isNotEmpty) {
        isForgotPassword.value = true;
        emailForgotPassword.value = formdata['email'].toLowerCase();
        Get.toNamed(AppRoutes.ENTER_CODE);
      } else {
        isEmailExits_forgot.value = true;
      }
      isLoading.value = false;
    } catch (exception) {
      isLoading.value = false;

      Get.snackbar('Quên mật khẩu', 'Quên mật khẩu thất bại');
    }
  }

  // forgot password step 2
  forgotPasswoodEnterCode(var formdata) async {
    try {
      isLoading.value = true;
      var data = await authProvider.forgotPasswoodEnterCode({
        "code": formdata["code"],
      });
      if (data['status'] != null && data['status'].isNotEmpty) {
        isEnterCode.value = true;
        Get.toNamed(AppRoutes.RESET_PASSWORD);
      } else {
        isInValidCode.value = true;
      }
      isLoading.value = false;
    } catch (exception) {
      isLoading.value = false;
      Get.snackbar('Quên mật khẩu', 'Quên mật khẩu thất bại');
    }
  }

  // forgot password step 3
  forgotPasswoodResetPassword(var formdata) async {
    try {
      isLoading.value = true;
      var data = await authProvider.forgotPasswoodResetPassword({
        "email": emailForgotPassword.value,
        "password": formdata["password"]
      });
      isLoading.value = false;
      resetAll();
      Get.snackbar('Quên mật khẩu', data["message"].toString());
      Get.toNamed(AppRoutes.LOGIN);
    } catch (exception) {
      isLoading.value = false;
      Get.snackbar('Quên mật khẩu', 'Quên mật khẩu thất bại');
    }
  }
}
