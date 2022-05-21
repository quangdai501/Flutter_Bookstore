import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/models/product_model.dart';
import 'package:final_project/models/review_model.dart';
import 'package:get/get.dart';

import '../provider/product_provider.dart';

class ProductDetailController extends GetxController with StateMixin<Product> {
  final ProductProvider productProvider = Get.find();
  final UserController userController = Get.find();
  final rating = 0.obs;
  final comment = "".obs;

  getProduct(var id) async {
    await Future.delayed(const Duration(seconds: 2));
    if (state == null) {
      getProductById(id);
    }
  }

  getProductById(var productId) async {
    try {
      change(null, status: RxStatus.loading());
      Product data = await productProvider.getProduct(productId);
      change(data, status: RxStatus.success());
      findReviewByUserId();
    } catch (exception) {
      change(null, status: RxStatus.error());
    }
  }

  createReview(var comment) async {
    try {
      await productProvider.createReview(
          {"rating": rating.value, "comment": comment}, state!.id);
      await getProductById(state!.id);
      Get.snackbar('Bình luận', 'Bình luận thành công');
    } catch (exception) {
      Get.snackbar('Bình luận', 'Bình luận thất bại');
    }
  }

  findReviewByUserId() {
    try {
      Review review = state!.reviews
          .firstWhere((element) => element.user == userController.state!.id);
      rating.value = review.rating;
      comment.value = review.comment;
    }
    // ignore: empty_catches
    catch (ex) {}
  }
}
