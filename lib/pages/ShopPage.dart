import 'dart:async';
import 'dart:math';

import 'package:final_project/components/ProductItem.dart';
import 'package:final_project/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controllers/shop_page_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../controllers/filter_controller.dart';
import '../customs/CustomBorder.dart';
import '../models/author_model.dart';
import '../models/category_model.dart';
import '../models/publisher_model.dart';
import '../utils/convert_currency.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// import 'package:grouped_list/grouped_list.dart';

class MyGlobals {
  late GlobalKey _scaffoldKey;
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  ScrollController scrollController = ScrollController();
  ShopPageController controller = Get.find();
  DashboardController dashboardController = Get.find();
  final FilterController filterController = Get.find();
  final sortActive = (-1).obs;
  final sorts = ['Giá', "Mới nhất", "Bán chạy"];
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          controller.isLoadMorePage.value) {
        controller.incPage();
        controller.getMorePages();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: TextEditingController(text: dashboardController.getSearchKey()),
                style: const TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Tìm kiếm",
                  hintStyle: const TextStyle(color: Colors.black26),
                  enabledBorder: CustomBorder.enabledBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  contentPadding: const EdgeInsets.only(
                      top: 10, left: 12, right: 12, bottom: 6),
                  border: CustomBorder.enabledBorder.copyWith(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  filled: true,
                ),
                onChanged: (text) {
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce = Timer(const Duration(milliseconds: 500), () {
                    controller.query.update((val) {
                      val!.search = text;
                    });
                    controller.getInitPage();
                  });
                },
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: GetPlatform.isAndroid ? 60 : 40,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < sorts.length; i++)
                          sortBarItem(sorts[i], i),
                        // FilterModal(),
                        Card(
                          child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: InkWell(
                                  onTap: () {
                                    openFilter();
                                    // Get.toNamed(AppRoutes.FILTER_PAGE);
                                  },
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text("Lọc",
                                            style: TextStyle(fontSize: 16)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.filter_alt)
                                      ]))),
                        )
                      ]),
                ),
                Expanded(
                  child: controller.obx(
                      (state) => GridView.builder(
                            controller: scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 16),
                            itemBuilder: (_, index) =>
                                ProductItem(product: state![index]),
                            itemCount: state?.length,
                          ),
                      onEmpty: const Text('Không có dữ liệu')),
                ),
              ],
            ),
            // SearchBar(),
          ],
        ));
  }

  Widget sortBarItem(String str, int index) {
    final status = 0.obs;
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: InkWell(
              onTap: () {
                if (sortActive.value != index) {
                  status.value = 0;
                }
                sortActive.value = index;

                status.value += 1;
                if (status.value > 2) {
                  status.value = 0;
                }
                controller.updateSort(status.value + index * 10);
                if (status.value == 0) {
                  sortActive.value = -1;
                }
              },
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(str, style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  width: 5,
                ),
                Obx(() {
                  if (index == sortActive.value) {
                    switch (status.value) {
                      case 1:
                        return const Icon(Icons.arrow_upward, size: 16);
                      case 2:
                        return const Icon(Icons.arrow_downward, size: 16);
                      default:
                        return const SizedBox(width: 16);
                    }
                  }
                  return const SizedBox(width: 16);
                })
              ]))),
    );
  }

  openFilter() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: ListView(
              children: <Widget>[
                priceFilter(),
                const SizedBox(height: 12),
                select(category(), "Danh sách thể loại", "Thể loại",
                    filterController.initCategories),
                const SizedBox(height: 12),
                select(authors(), "Danh sách tác giả", "Tác giả",
                    filterController.initAuthors),
                const SizedBox(height: 12),
                select(publisher(), "Danh sách nhà xuất bản", "Nhà xuât bản",
                    filterController.initPublishers),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          filterController.clearFilter();
                          controller
                              .updateQueryFilter(filterController.filter());
                          controller.getInitPage();
                          Get.back();
                        },
                        child: Text("Xóa bộ lọc")),
                    ElevatedButton(
                        onPressed: () {
                          controller
                              .updateQueryFilter(filterController.filter());
                          controller.getInitPage();
                          Get.back();
                        },
                        child: Text("Áp dụng"))
                  ],
                ),
              ],
            )),
      ),
      enableDrag: false,
      isScrollControlled: true,
    );
  }

  Widget priceFilter() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Giá",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            range("Thấp nhất", filterController.from,
                filterController.isSelectFrom),
            const SizedBox(height: 12),
            range("Cao nhất", filterController.to, filterController.isSelectTo),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget range(String title, RxDouble val, RxBool isSelect) {
    // final isSelect = false.obs;
    return Obx(() => Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 12),
                Text(title),
                const SizedBox(width: 12),
                isSelect.value
                    ? Text(ConvertNumberToCurrency(val.value.toInt()))
                    : Container(),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: isSelect.value
                              ? const Icon(Icons.arrow_drop_up)
                              : const Icon(Icons.arrow_drop_down),
                          onPressed: () {
                            isSelect.value = !isSelect.value;
                          },
                        )))
              ],
            ),
            const SizedBox(height: 12),
            isSelect.value
                ? SfSlider(
                    min: 0,
                    max: 1000000,
                    value: val.value,
                    interval: 1000000,
                    stepSize: 10000,
                    showLabels: true,
                    minorTicksPerInterval: 1,
                    onChanged: (value) {
                      val.value = value;
                    })
                : Container()
          ],
        ));
  }

  Widget select(
      _items, String title, String filterTitle, RxList<dynamic> init) {
    return MultiSelectDialogField(
      items: _items,
      initialValue: init,
      title: Text(filterTitle),
      searchable: true,
      separateSelectedItems: true,
      chipDisplay: MultiSelectChipDisplay(
        chipColor: Colors.black12,
        textStyle: const TextStyle(color: Colors.blue),
      ),
      buttonIcon: const Icon(Icons.arrow_drop_down),
      buttonText: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onConfirm: (results) {
        init.value = results;
      },
    );
  }

  authors() {
    return controller.authors
        .map((author) => MultiSelectItem<Author>(author, author.name))
        .toList();
  }

  category() {
    return controller.category
        .map((category) => MultiSelectItem<Category>(category, category.name))
        .toList();
  }

  publisher() {
    return controller.publishers
        .map((publisher) =>
            MultiSelectItem<Publisher>(publisher, publisher.name))
        .toList();
  }
}
