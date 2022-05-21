import 'package:flutter/material.dart';
import 'package:final_project/controllers/auth_controller.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EnterCodePage extends GetView<AuthController> {
  const EnterCodePage({Key? key}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'code': FormControl<String>(
          validators: [Validators.required, Validators.pattern(r'^[0-9]{6}$')],
        ),
      });
  @override
  Widget build(BuildContext context) {
    controller.setFalseInvalidCode();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
        title: const Text("Nhập mã code", style: TextStyle(color: Colors.black87),),
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
                const Text(
                  "Chúng tôi vừa gửi mã xác nhận vào email của bạn",
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx((() {
                  if (controller.isInValidCode.value) {
                    return const Align(alignment: Alignment.topLeft,child: Text(
                      'Bạn đã nhập sai mã xác nhận',
                      style: TextStyle(color: Colors.red),
                    ));
                  }
                  return Container();
                })),
                ReactiveTextField<String>(
                  formControlName: 'code',
                  validationMessages: (control) => {
                    ValidationMessage.required:
                        'Mã xác nhận không được để trống',
                    ValidationMessage.pattern:
                        'Mã xác nhận là 1 số có 6 chữ số',
                  },
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Mã xác nhận'),
                ),
                const SizedBox(height: 24.0),
                ReactiveFormConsumer(
                  builder: (context, form, child) => ElevatedButton(
                    onPressed: form.valid
                        ? () => controller.switchEnterCode(form.value)
                        : null,
                    child: Obx(() {
                      if (controller.isLoading.value == true) {
                        return const SizedBox(
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1,),
                          height: 20.0,
                          width: 20.0,
                        );
                      }
                      return const Text('Nhập mã xác nhận');
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
