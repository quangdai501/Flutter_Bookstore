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
                        "Th??ng tin giao h??ng",
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
                          ValidationMessage.required: 'Kh??ng ????? tr???ng',
                        },
                        decoration: InputDecoration(labelText: 'T??n'),
                      ),
                      const SizedBox(height: 24.0),
                      // phone
                      ReactiveTextField<String>(
                        formControlName: 'phone',
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Kh??ng ????? tr???ng',
                        },
                        decoration: InputDecoration(labelText: '??i???n tho???i'),
                      ),
                      // province
                      const SizedBox(height: 24.0),
                      ReactiveDropdownField<dynamic>(
                        decoration:
                        InputDecoration(labelText: 'T???nh'),
                        onChanged: (value) =>
                        {controller.fetchDistrict(value)},
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Kh??ng ????? tr???ng',
                        },
                        formControlName: 'province',
                        // hint: const Text('Ch???n T???nh/Th??nh ph???...'),
                        items: getAllProvince(controller.provinces),
                      ),
                      const SizedBox(height: 24.0),
                      // district
                      ReactiveDropdownField<dynamic>(
                        decoration:
                        InputDecoration(labelText: 'Qu???n/Huy???n'),
                        onChanged: (value) => {controller.fetchWard(value)},
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Kh??ng ????? tr???ng',
                        },
                        formControlName: 'district',
                        // hint: const Text('Ch???n Qu???n/Huy???n...'),
                        items: getAllDistrict(controller.districts),
                      ),
                      const SizedBox(height: 24.0),
                      // ward
                      ReactiveDropdownField<dynamic>(
                        decoration: InputDecoration(labelText: 'X??/Ph?????ng'),
                        onChanged: (value) => {},
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Kh??ng ????? tr???ng',
                        },
                        formControlName: 'ward',
                        // hint: const Text('Ch???n X??/Ph?????ng...'),
                        items: getAllWard(controller.wards),
                      ),
                      // address
                      ReactiveTextField<String>(
                        decoration:
                        InputDecoration(labelText: 'Chi ti???t'),
                        formControlName: 'address',
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Kh??ng ????? tr???ng',
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
            child: Text('Thanh to??n')),
        ReactiveFormConsumer(
          builder: (context, form, child) => ElevatedButton(
            onPressed: form.valid
                ? () {
              controller.onSubmit(form.value, () {
                checkoutController.fetchAddressInfo();
              });
            }
                : null,
            child: Text('L??u'),
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
