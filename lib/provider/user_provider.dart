import 'dart:typed_data';

import 'package:final_project/models/user_model.dart';
import 'package:final_project/provider/base_provider.dart';
import 'package:get/get.dart';

class UserProvider extends BaseProvider {
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  // update user profile
  Future<User> updateProfile(var body, var id) async {
    try {
      String url = 'users/update-info/$id';
      final response = await put(url, body);
      if (response.hasError) {
        throw response.body;
      }
      var data = User.fromJson(response.body);
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // update user profile
  Future<dynamic> updateUserAvatar(var image, var id) async {
    try {
      String url = 'users/$id/update-image';
      Uint8List imageBytes = await image.readAsBytes();
      List<int> list = imageBytes.cast();
      final form = FormData({
        "image": MultipartFile(list, filename: image.name),
      });
      final response = await post(url, form);
      if (response.hasError) {
        throw response.body;
      }
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
