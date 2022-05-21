import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controllers/auth_controller.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../routes/app_pages.dart';

class ForgotPage extends GetView<AuthController> {
  const ForgotPage({Key? key}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
      });
  @override
  Widget build(BuildContext context) {
    controller.resetAll();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
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
                // Row(children: [
                //
                // ],),

                const Text(
                  "Quên mật khẩu",
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                const Text(
                  "Bạn vui lòng nhập địa chỉ email để lấy lại mật khẩu!",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),

                const SizedBox(
                  height: 20,
                ),
                Obx((() {
                  if (controller.isEmailExits_forgot.value) {
                    return const Text(
                      'Tài khoản chưa được đăng ký',
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return Container();
                })),
                ReactiveTextField<String>(
                  formControlName: 'email',
                  validationMessages: (control) => {
                    ValidationMessage.required: 'Email không được để trống',
                    ValidationMessage.email: 'Email không đúng định dạng',
                  },
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 24.0),
                ReactiveFormConsumer(
                  builder: (context, form, child) => ElevatedButton(
                    onPressed: form.valid
                        ? () => controller.forgotPasswoodSentCode(form.value)
                        : null,
                    child: Obx(() {
                      if (controller.isLoading.value == true) {
                        return const SizedBox(
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1,),
                          height: 20.0,
                          width: 20.0,
                        );
                      }
                      return const Text('Quên mật khẩu');
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
