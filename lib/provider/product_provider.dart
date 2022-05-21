import 'package:final_project/models/category_model.dart';
import 'package:final_project/models/product_model.dart';
import 'package:final_project/models/publisher_model.dart';
import 'package:final_project/provider/base_provider.dart';

import '../models/author_model.dart';
import '../utils/conver_query.dart';

class ProductProvider extends BaseProvider {
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  // Fetch Data
  Future<Map<String, dynamic>> getAllProduct(Map<String, dynamic> query) async {
    try {
      String url = 'products?' + convertQuery(query);
      final response = await get(url);
      if (response.hasError) {
        throw response.body;
      }
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // Fetch Data
  Future<List<Category>> getAllCategory() async {
    try {
      String url = 'category';
      final response = await get(url);
      if (response.hasError) {
        throw response.body;
      }
      return categoryFromJson(response.body);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // Fetch Data
  Future<List<Author>> getAllAuthor() async {
    try {
      String url = 'author';
      final response = await get(url);
      if (response.hasError) {
        throw response.body;
      }
      return authorFromJson(response.body);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

// Fetch Data
  Future<List<Publisher>> getAllPublisher() async {
    try {
      String url = 'publisher';
      final response = await get(url);
      if (response.hasError) {
        throw response.body;
      }
      return publisherFromJson(response.body);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // fetch data by id
  Future<Product> getProduct(var id) async {
    try {
      final url = 'products/$id';
      final response = await get(url);

      var data = Product.fromJson(response.body);

      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // create Review
  Future<dynamic> createReview(var body, var id) async {
    try {
      final url = 'products/$id/createReview/';
      final response = await post(url, body);

      if (response.hasError) {
        throw response.body;
      }
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
