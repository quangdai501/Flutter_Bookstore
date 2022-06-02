import 'package:final_project/models/author_model.dart';
import 'package:final_project/models/category_model.dart';
import 'package:final_project/models/product_model.dart';
import 'package:final_project/models/publisher_model.dart';
import 'package:final_project/models/query_model.dart';
import 'package:final_project/provider/product_provider.dart';
import 'package:get/get.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ShopPageController extends GetxController with StateMixin<List<Product>> {
  var isLoadMorePage = false.obs;
  final query = Query(page: 1).obs;
  final searchHistory = <dynamic>[].obs;
  final authors = <Author>[].obs;
  final category = <Category>[].obs;
  final publishers = <Publisher>[].obs;

  ProductProvider productProvider = Get.find();

  @override
  void onInit() {
    super.onInit();
    getInitPage();
    getAllAuthor();
    getAllCategory();
    getAllPublisher();
  }

  incPage([int val = 1]) {
    query.value.page += val;
    query.refresh();
  }

  getAllAuthor() async {
    try {
      authors.value = await productProvider.getAllAuthor();
      // ignore: empty_catches
    } catch (ex) {}
  }

  getAllCategory() async {
    try {
      category.value = await productProvider.getAllCategory();
      // ignore: empty_catches
    } catch (ex) {}
  }

  getAllPublisher() async {
    try {
      publishers.value = await productProvider.getAllPublisher();
      // ignore: empty_catches
    } catch (ex) {}
  }

  // clearQueryFilter() {
  //   query.update((val) {
  //     val!.authors = null;
  //     val.categories = null;
  //     val.publishers = null;
  //     val.from = null;
  //     val.to = null;
  //   });
  // }

  updateQueryFilter(Query filter) {
    query.update((val) {
      val!.authors = filter.authors;
      val.categories = filter.categories;
      val.publishers = filter.publishers;
      val.from = filter.from;
      val.to = filter.to;
    });
  }

  updateSort(int sort) {
    switch (sort) {
      case 1:
        query.value.sort = "price";
        break;
      case 2:
        query.value.sort = "-price";
        break;
      case 11:
        query.value.sort = "createdAt";
        break;
      case 12:
        query.value.sort = "-createdAt";
        break;
      case 21:
        query.value.sort = "quantity";
        break;
      case 22:
        query.value.sort = "-quantity";
        break;
      default:
        query.value.sort = null;
    }
    getInitPage();
  }

  getInitPage() async {
    try {
      query.update((val) {
        val!.page = 1;
      });
      change(null, status: RxStatus.loading());
      var data = await productProvider.getAllProduct(query.value.toJson());
      List<Product> products = productFromJson(data['product']);
      var totalPage = data['totalPages'];

      if (products.isEmpty) {
        isLoadMorePage.value = false;
        change([], status: RxStatus.empty());
        return;
      }
      change(products, status: RxStatus.success());

      if (query.value.page < totalPage) {
        isLoadMorePage.value = true;
        return;
      }
      isLoadMorePage.value = false;
    } catch (exception) {
      change(null, status: RxStatus.error());
    }
  }

  Future getMorePages() async {
    try {
      change(state, status: RxStatus.loadingMore());
      var data = await productProvider.getAllProduct(query.value.toJson());
      List<Product> products = productFromJson(data['product']);
      var totalPage = data['totalPages'];

      if (data.isEmpty) {
        isLoadMorePage.value = false;
        return;
      }
      state!.addAll(products);
      change(state, status: RxStatus.success());
      if (query.value.page < totalPage) {
        isLoadMorePage.value = true;
        return;
      }
      isLoadMorePage.value = false;
    } catch (exception) {
      // print(exception);
    }
  }

  setSearchHistory(var search) {
    searchHistory.add(search);
    if (searchHistory.length > 5) {
      searchHistory.removeAt(0);
    }
    searchHistory.refresh();
  }
}
