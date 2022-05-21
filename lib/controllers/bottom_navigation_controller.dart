import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final index = 0.obs;
  changeIndex(val) {
    index.value = val;
  }
}
