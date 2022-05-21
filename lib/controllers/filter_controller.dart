import 'package:final_project/models/query_model.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final from = 0.0.obs;
  final isSelectFrom = false.obs;
  final to = 0.0.obs;
  final isSelectTo = false.obs;
  final initAuthors = [].obs;
  final initCategories = [].obs;
  final initPublishers = [].obs;

  Query filter() {
    Query query = Query(page: 1);
    if (isSelectFrom.value) {
      query.from = from.value;
    }
    if (isSelectTo.value) {
      query.to = to.value;
    }
    if (initAuthors.isNotEmpty) {
      query.authors =
          initAuthors.map((e) => e.id).cast<String>().toList().toString();
    }
    if (initCategories.isNotEmpty) {
      query.categories =
          initCategories.map((e) => e.id).cast<String>().toList().toString();
    }
    if (initPublishers.isNotEmpty) {
      query.publishers =
          initPublishers.map((e) => e.id).cast<String>().toList().toString();
    }
    return query;
  }

  clearFilter() {
    from.value = 0.0;
    isSelectFrom.value = false;
    to.value = 0.0;
    isSelectTo.value = false;
    initAuthors.value = [];
    initCategories.value = [];
    initPublishers.value = [];
  }
}
