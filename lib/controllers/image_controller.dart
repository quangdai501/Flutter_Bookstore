import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  dynamic image;
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = pickedFile;
      }
      update();
      // ignore: empty_catches
    } catch (ex) {}
  }
}
