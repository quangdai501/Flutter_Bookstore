import 'package:final_project/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UserInfo extends GetView<UserController> {
  final UserController uController = Get.find();

  UserInfo({Key? key}) : super(key: key);
  FormGroup buildForm(name, email, address) => fb.group(<String, Object>{
        'name':
            FormControl<String>(validators: [Validators.required], value: name),
        'email': FormControl<String>(validators: [
          Validators.required,
          Validators.email,
        ], value: email),
        'address': FormControl<String>(
            validators: [Validators.required], value: address),
      }, []);

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
        title: const Text("Thông tin chi tiết",
            style: TextStyle(color: Colors.black54)),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return uController.obx((state) => ReactiveFormBuilder(
              form: () => buildForm(state!.name, state.email, state.address),
              builder: (context, form, child) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ReactiveTextField<String>(
                        formControlName: 'name',
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Tên'),
                      ),
                      const SizedBox(height: 24.0),
                      ReactiveTextField<String>(
                        formControlName: 'email',
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(height: 24.0),
                      ReactiveTextField<String>(
                        formControlName: 'address',
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Địa chỉ'),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  )
                );
              }));
        },
      ),
    );
  }
}
