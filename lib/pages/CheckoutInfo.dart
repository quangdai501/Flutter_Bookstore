import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controllers/checkout_controller.dart';
import 'package:final_project/controllers/checkout_info_controller.dart';
import 'package:final_project/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';


class CheckoutInfoPage extends GetView<CheckoutInfoController> {
  CheckoutInfoPage({Key? key}) : super(key: key);
  final CheckoutController checkoutController = Get.find();
  FormGroup buildForm() => fb.group(<String, Object>{
    'name': FormControl<String>(
        validators: [Validators.required],
        value: controller.addressInfo.value.name),
    'phone': FormControl<String>(
        validators: [Validators.required],
        value: controller.addressInfo.value.phone),
    'province': FormControl<int>(
        validators: [Validators.required],
        value: controller.addressInfo.value.province.id),
    'district': FormControl<int>(
        validators: [Validators.required],
        value: controller.addressInfo.value.district.id),
    'ward': FormControl<String>(
        validators: [Validators.required],
        value: controller.addressInfo.value.ward.id),
    'address': FormControl<String>(
        validators: [Validators.required],
        value: controller.addressInfo.value.address),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
                  return Obx(() => Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Thông tin giao hàng",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // name
                      ReactiveTextField<String>(
                        formControlName: 'name',
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Không để trống',
                        },
                        decoration: InputDecoration(labelText: 'Tên'),
                      ),
                      const SizedBox(height: 24.0),
                      // phone
                      ReactiveTextField<String>(
                        formControlName: 'phone',
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Không để trống',
                        },
                        decoration: InputDecoration(labelText: 'Điện thoại'),
                      ),
                      // province
                      const SizedBox(height: 24.0),
                      ReactiveDropdownField<dynamic>(
                        decoration:
                        InputDecoration(labelText: 'Tỉnh'),
                        onChanged: (value) =>
                        {controller.fetchDistrict(value)},
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Không để trống',
                        },
                        formControlName: 'province',
                        // hint: const Text('Chọn Tỉnh/Thành phố...'),
                        items: getAllProvince(controller.provinces),
                      ),
                      const SizedBox(height: 24.0),
                      // district
                      ReactiveDropdownField<dynamic>(
                        decoration:
                        InputDecoration(labelText: 'Quận/Huyện'),
                        onChanged: (value) => {controller.fetchWard(value)},
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Không để trống',
                        },
                        formControlName: 'district',
                        // hint: const Text('Chọn Quận/Huyện...'),
                        items: getAllDistrict(controller.districts),
                      ),
                      const SizedBox(height: 24.0),
                      // ward
                      ReactiveDropdownField<dynamic>(
                        decoration: InputDecoration(labelText: 'Xã/Phường'),
                        onChanged: (value) => {},
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Không để trống',
                        },
                        formControlName: 'ward',
                        // hint: const Text('Chọn Xã/Phường...'),
                        items: getAllWard(controller.wards),
                      ),
                      // address
                      ReactiveTextField<String>(
                        decoration:
                        InputDecoration(labelText: 'Chi tiết'),
                        formControlName: 'address',
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Không để trống',
                        },
                      ),
                      const SizedBox(height: 24.0),

                      botomNavigation()
                    ],
                  ));
                }),
          ),
        ));
  }

  Widget botomNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.CHECKOUT);
            },
            child: Text('Thanh toán')),
        ReactiveFormConsumer(
          builder: (context, form, child) => ElevatedButton(
            onPressed: form.valid
                ? () {
              controller.onSubmit(form.value, () {
                checkoutController.fetchAddressInfo();
              });
            }
                : null,
            child: Text('Lưu'),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem> getAllProvince(var data) {
    return <DropdownMenuItem>[
      for (var i in data)
        DropdownMenuItem(
            child: Text(i['ProvinceName']),
            // value: json
            //     .encode({"name": i["ProvinceName"], "id": i["ProvinceID"]})),
            value: i["ProvinceID"]),
    ];
  }

  List<DropdownMenuItem> getAllDistrict(var data) {
    return <DropdownMenuItem>[
      for (var i in data)
        DropdownMenuItem(
            child: Text(i['DistrictName']),
            // value: json
            //     .encode({"name": i["DistrictName"], "id": i["DistrictID"]})),
            value: i["DistrictID"]),
    ];
  }

  List<DropdownMenuItem> getAllWard(var data) {
    return <DropdownMenuItem>[
      for (var i in data)
        DropdownMenuItem(
            child: Text(i['WardName']),
            // value: json.encode({"name": i["WardName"], "id": i["WardCode"]})),
            value: i["WardCode"]),
    ];
  }
}
