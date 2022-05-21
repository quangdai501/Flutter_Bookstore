import 'package:final_project/models/user_model.dart';
import 'package:final_project/provider/user_provider.dart';
import 'package:final_project/utils/is_expire_time.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController with StateMixin<User> {
  final box = GetStorage();
  final isLogin = false.obs;
  UserProvider userProvider = Get.find();
  @override
  void onInit() {
    super.onInit();
    loadUserInfoFromStorage();
  }

  loadUserInfoFromStorage() async {
    // box.erase();
    try {
      var data = await box.read("userInfo");
      change(User.fromJson(data), status: RxStatus.success());
      isLogin.value = isExpireTime(data["timeExpire"]);
    } catch (ex) {
      change(null, status: RxStatus.error());
      isLogin.value = false;
    }
  }

  updateProfile(var formData) async {
    try {
      var data = await userProvider.updateProfile(formData, state!.id);
      change(data, status: RxStatus.success());

      var userInfo = await box.read("userInfo");
      userInfo["name"] = formData["name"];
      userInfo["phone"] = formData["phone"];
      userInfo["address"] = formData["address"];

      await box.write("userInfo", userInfo);

      Get.snackbar('Đổi thông tin', 'Đổi thông tin thành công');
    } catch (ex) {
      Get.snackbar('Đổi thông tin', 'Đổi thông tin thất bại');
    }
  }

  updateUserAvatar(var image) async {
    try {
      var data = await userProvider.updateUserAvatar(image, state!.id);
      state!.image = data;
      change(state, status: RxStatus.success());
      var userInfo = await box.read("userInfo");
      userInfo["image"] = data;

      await box.write("userInfo", userInfo);

      Get.snackbar('Lưu hình ảnh', 'Lưu hình ảnh thành công');
    } catch (ex) {
      Get.snackbar('Lưu hình ảnh', 'Lưu hình ảnh thất bại');
    }
  }
  logout() async {
    // change(null, status: RxStatus.error());
    await box.remove("userInfo");
    isLogin.value = false;
  }
}
