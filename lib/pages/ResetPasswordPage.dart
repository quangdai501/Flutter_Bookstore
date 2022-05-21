import 'package:flutter/material.dart';
import 'package:final_project/controllers/auth_controller.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';


class ResetPasswordPage extends GetView<AuthController> {
  const ResetPasswordPage({Key? key}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
        title: const Text("Tạo mật khẩu mới", style: TextStyle(color: Colors.black87),),
        centerTitle: true,
      ),
      body: SafeArea(
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
              children: [
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   "Đăng ký",
                //   style: TextStyle(fontSize: 20, color: Colors.black87),
                // ),
                const SizedBox(
                  height: 20,
                ),
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
                        ? () =>
                            controller.forgotPasswoodResetPassword(form.value)
                        : null,
                    child: Obx(() {
                      if (controller.isLoading.value == true) {
                        return const SizedBox(
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1,),
                          height: 20.0,
                          width: 20.0,
                        );
                      }
                      return const Text('Đổi lại mật khẩu');
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}
