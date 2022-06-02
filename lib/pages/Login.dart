import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controllers/auth_controller.dart';
import 'package:final_project/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({Key? key}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required],
        ),
        'password': FormControl<String>(
          validators: [Validators.required],
        ),
      });
  static void showToast(context, isLoginSuccess) {
    String text =
        isLoginSuccess ? "Đăng nhập thành công" : "Sai email hoặc mật khẩu";
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 100.0,
        ),
        child: ReactiveFormBuilder(
          form: () => buildForm(),
          builder: (context, form, child) {
            return Column(children: [
              const SizedBox(
                height: 20,
              ),
               Image.asset('assets/images/logo.png', width: 200),
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Đăng nhập",
                style: TextStyle(fontSize: 30, color: Colors.black87),
              ),
              const SizedBox(
                height: 20,
              ),
              ReactiveTextField<String>(
                formControlName: 'email',
                validationMessages: (control) => {
                  ValidationMessage.required: 'Email không được để trống',
                },
                onSubmitted: () => form.focus('password'),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 24.0),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                validationMessages: (control) => {
                  ValidationMessage.required: 'Mật khẩu không được để trống',
                },
                onSubmitted: () => form.focus('passwordConfirmation'),
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Mật khẩu'),
              ),
              const SizedBox(height: 50),
              ReactiveFormConsumer(
                builder: (context, form, child) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      if (form.valid) {
                        controller.login(form.value);
                      }
                    },
                    child: Obx(() {
                      if (controller.isLoading.value == true) {
                        return const SizedBox(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          ),
                          height: 20.0,
                          width: 20.0,
                        );
                      }
                      return const Text('Đăng nhập');
                    })),
              ),
              const SizedBox(height: 50),
              Row(mainAxisSize: MainAxisSize.min, children: [
                TextButton(
                    child: const Text('Tạo tài khoản mới'),
                    onPressed: () => {Get.toNamed(AppRoutes.REGISTER)}),
                const SizedBox(height: 12.0),
                TextButton(
                    child: const Text('Quên mật khẩu'),
                    onPressed: () => {Get.toNamed(AppRoutes.FORGOT_PASSWORD)}),
              ])
            ]);
          },
        ),
      )),
    );
  }
}
