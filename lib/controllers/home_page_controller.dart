import 'package:final_project/models/product_model.dart';
import 'package:final_project/provider/product_provider.dart';
import 'package:get/get.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePageController extends GetxController {
  ProductProvider productProvider = Get.find();
  final bestSellingProduct = <Product>[].obs;
  final newProduct = <Product>[].obs;
  final featureProduct = <Product>[].obs;
  var selectedSliderPosition = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getBestSellingProduct();
    getNewProduct();
    getFeatureProduct();
  }

  getBestSellingProduct() async {
    try {
      var data = await productProvider
          .getAllProduct({"size": "6", "sort": "-quantity"});
      List<Product> products = productFromJson(data['product']);
      bestSellingProduct.value = products;
      // ignore: empty_catches
    } catch (exception) {}
  }

  getFeatureProduct() async {
    try {
      var data =
          await productProvider.getAllProduct({"size": "6", "sort": "price"});
      List<Product> products = productFromJson(data['product']);
      featureProduct.value = products;
      // ignore: empty_catches
    } catch (exception) {}
  }

  getNewProduct() async {
    try {
      var data = await productProvider
          .getAllProduct({"size": "6", "sort": "-createdAt"});
      List<Product> products = productFromJson(data['product']);
      newProduct.value = products;
      // ignore: empty_catches
    } catch (exception) {}
  }
}
