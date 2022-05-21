import 'package:final_project/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/product_model.dart';

class CartController extends GetxController {
  final carts = <Cart>[].obs;
  final box = GetStorage();
  final total = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
  }

  loadCartFromStorage() async {
    try {
      var cart = await box.read("cart");
      // box.erase();
      if (cart != null) {
        carts.addAll(cartFromJson(cart));
      }
      getTotalCart();
    }
    // ignore: empty_catches
    catch (ex) {}
  }

  getTotalCart() {
    total.value =
        carts.fold(0, (int sum, element) => element.price * element.qty + sum);
  }

  addProductToCart(Product product, {var qty = 1}) async {
    // ignore: iterable_contains_unrelated_type
    var index = carts.indexWhere((element) => element.productId == product.id);
    // ignore: unnecessary_null_comparison
    if (index > -1) {
      carts[index].qty = qty;
      carts.refresh();
    } else {
      carts.add(Cart.fromProduct(product, qty));
    }
    getTotalCart();
    await box.write("cart", cartToJson(carts));
    Get.snackbar('Mua hàng', 'Đã thêm vào giỏ hàng của bạn');
  }

  changeCartQuantity(int index, int qty) async {
    if (carts[index].qty + qty > 0) {
      carts[index].qty += qty;
      carts.refresh();
    }
    getTotalCart();
    await box.write("cart", cartToJson(carts));
  }

  removeFromCart(var productid) async {
    // ignore: unrelated_type_equality_checks
    carts.removeWhere((element) => element.productId == productid);
    getTotalCart();
    await box.write("cart", cartToJson(carts));
  }

  clearCart() async {
    carts.clear();
    getTotalCart();
    await box.write("cart", cartToJson(carts));
  }
}
