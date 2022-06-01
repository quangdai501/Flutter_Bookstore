import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  final box = GetStorage();

  void changeTabIndex(int index) {
    print(index);
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
    return key;
  }
}
