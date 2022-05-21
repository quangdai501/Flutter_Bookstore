import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    final box = GetStorage();
    // httpClient.baseUrl = 'https://book-store-ute.herokuapp.com/api/';
    httpClient.baseUrl = 'https://books-store-ute.herokuapp.com/api/';
    // httpClient.baseUrl = 'http://localhost:5000/api/';

    httpClient.timeout = const Duration(seconds: 15);

    httpClient.addRequestModifier<void>((request) async {
      var userInfo = await box.read("userInfo");
      if (userInfo != null) {
        request.headers['authorization'] = "Bearer " + userInfo["token"];
      }
      return request;
    });
  }
}
