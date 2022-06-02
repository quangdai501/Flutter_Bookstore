import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  final idx = 0.obs;
  final box = GetStorage();

  void changeTabIndex(int index) {
    idx.value = index;
    tabIndex = index;
    update();
  }

  setSearchKey(var key) async {
    try {
      await box.write("searchKey", key);
    } catch (ex) {}
  }

  String getSearchKey() {
    var key = box.read("searchKey");
    if(key == null) return '';
    return key;
  }
}
