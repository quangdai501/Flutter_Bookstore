import 'package:final_project/models/address_info_model.dart';
import 'package:final_project/provider/address_info_provider.dart';
import 'package:get/get.dart';

import '../provider/ghn_provider.dart';

class CheckoutInfoController extends GetxController {
  GHNProvider ghnProvider = Get.find();
  AddressInfoProvider addressInfoProvider = Get.find();
  final addressInfo =
      AddressInfo(district: District(), province: District(), ward: Ward()).obs;
  final provinces = [].obs;
  final districts = [].obs;
  final wards = [].obs;
  @override
  void onInit() {
    super.onInit();
    fetchProvince();
  }

  changeAddressInfo(AddressInfo data) async {
    if (data.id != null) {
      fetchDistrict(data.province.id);
      fetchWard(data.district.id);
    }
    setAddressInfo(data);
  }

  setAddressInfo(AddressInfo data) {
    addressInfo.value = data;
    addressInfo.refresh();
  }

  onSubmit(var formdata, Function fecthAddressInfo) async {
    var provinceName = provinces.firstWhere((element) =>
        element["ProvinceID"] == formdata["province"])["ProvinceName"];
    var districName = districts.firstWhere((element) =>
        element["DistrictID"] == formdata["district"])["DistrictName"];
    var wardName = wards.firstWhere(
        (element) => element["WardCode"] == formdata["ward"])["WardName"];

    AddressInfo addressInfoData = AddressInfo(
        province: District(id: formdata["province"], name: provinceName),
        district: District(id: formdata["district"], name: districName),
        ward: Ward(id: formdata["ward"], name: wardName),
        name: formdata["name"],
        phone: formdata["phone"],
        address: formdata["address"]);

    if (addressInfo.value.id == null) {
      await createAddressInfo(addressInfoData.toJson());
    } else {
      await updateAddressInfo(addressInfoData.toJson());
    }
    fecthAddressInfo();
    // print(formdata);
  }

  createAddressInfo(var formdata) async {
    try {
      var data = await addressInfoProvider.createAddressInfo(formdata);
      setAddressInfo(data);
      Get.snackbar('Lưu', 'Lưu thông tin thành công');
      // ignore: empty_catches
    } catch (ex) {}
  }

  updateAddressInfo(var formdata) async {
    try {
      var data = await addressInfoProvider.updateAddressInfo(
          addressInfo.value.id, formdata);
      setAddressInfo(data);
      Get.snackbar('Lưu', 'Lưu thông tin thành công');
      // ignore: empty_catches
    } catch (ex) {}
  }

  fetchProvince() async {
    try {
      var data = await ghnProvider.getProvince();
      provinces.value = data;
      // ignore: empty_catches
    } catch (ex) {}
  }

  fetchDistrict(var provinceID) async {
    try {
      var data = await ghnProvider.getDistrict(provinceID);
      districts.value = data;
      wards.value = [];
      districts.refresh();
      wards.refresh();
      // ignore: empty_catches
    } catch (ex) {}
  }

  fetchWard(var districtID) async {
    try {
      var data = await ghnProvider.getWard(districtID);
      wards.value = data;
      wards.refresh();
      // ignore: empty_catches
    } catch (ex) {}
  }
}
