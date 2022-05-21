import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controllers/auth_controller.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../routes/app_pages.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({Key? key}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(
          validators: [Validators.required],
        ),
        'email': FormControl<String>(
          validators: [
            Validators.required,
            Validators.email,
          ],
        ),
        'password': FormControl<String>(
          validators: [
            Validators.required,
            Validators.pattern(
                r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
          ],
        ),
        'passwordConfirmation': FormControl<String>(),
      }, [
        Validators.mustMatch('password', 'passwordConfirmation')
      ]);
  @override
  Widget build(BuildContext context) {
    controller.resetAll();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body:Column(children: [const Text("Tạo tài khoản mới",
          style: TextStyle(color: Colors.black87, fontSize: 26))
        ,SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: ReactiveFormBuilder(
            form: () => buildForm(),
            builder: (context, form, child) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // const Text(
                  //   "Đăng ký",
                  //   style: TextStyle(fontSize: 24, color: Colors.black87),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReactiveTextField<String>(
                    formControlName: 'name',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Họ và tên không được để trống',
                    },
                    onSubmitted: () => form.focus('email'),
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Họ và tên'),
                  ),
                  const SizedBox(height: 24.0),
                  Obx((() {
                    if (controller.isEmailExits_regis.value) {
                      return const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Tài khoản đã tồn tại',
                            style: TextStyle(color: Colors.red),
                          ));
                    }
                    return Container();
                  })),
                  ReactiveTextField<String>(
                    formControlName: 'email',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Email không được để trống',
                      ValidationMessage.email: 'Email không đúng định dạng',
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
                      ValidationMessage.pattern:
                      'Mật khẩu phải có ít nhất 8 ký tự, 1 chữ viết hoa, 1 chữ viết thường, 1 số và 1 ký tự đặc biệt',
                    },
                    onSubmitted: () => form.focus('passwordConfirmation'),
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Mật khẩu'),
                  ),
                  const SizedBox(height: 24.0),
                  ReactiveTextField<String>(
                    formControlName: 'passwordConfirmation',
                    decoration:
                    const InputDecoration(labelText: 'Nhập lại mật khẩu'),
                    obscureText: true,
                    validationMessages: (control) => {
                      ValidationMessage.mustMatch:
                      'Nhập lại mật khẩu phải giống nhau',
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 24.0),
                  ReactiveFormConsumer(
                    builder: (context, form, child) => ElevatedButton(
                      onPressed: form.valid
                          ? () => controller.registerSentCodeToEmail(form.value)
                          : null,
                      child: Obx(() {
                        if (controller.isLoading.value == true) {
                          return const SizedBox(
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1,),
                            height: 20.0,
                            width: 20.0,
                          );
                        }
                        return const Text('Đăng ký');
                      }),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        child: const Text('Đã có tài khoản ?'),
                        onPressed: () => {Get.toNamed(AppRoutes.LOGIN)}),
                  ),
                ],
              );
            },
          ),
        )),
    ],));
  }
}
