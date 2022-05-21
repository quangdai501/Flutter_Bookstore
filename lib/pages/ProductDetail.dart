import 'package:final_project/controllers/dashboard_controller.dart';
import 'package:final_project/customs/CustomSeparateBox.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/controllers/product_detail_controller.dart';
import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/utils/convert_currency.dart';
// import 'package:final_project/views/components/review_item.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../models/review_model.dart';
import '../components/ReviewItem.dart';
// import 'components/review_item.dart';

class ProductDetail extends GetView<ProductDetailController> {
  final CartController cartController = Get.find();
  final UserController userController = Get.find();
  final quantity = 1.obs;
  DashboardController dbController = Get.put(DashboardController());

  ProductDetail({Key? key}) : super(key: key);
  changeQuantity(int qty) {
    if (quantity.value + qty > 0) {
      quantity.value += qty;
    }
  }

  @override
  Widget build(BuildContext context) {
    var id = Get.parameters["productId"];
    controller.getProduct(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
        actions: <Widget>[
          IconButton(
              color: Colors.black,
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Get.toNamed(AppRoutes.CART))
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      // floatingActionButton: reviewButton(),
      body: controller.obx(
        (state) => Stack(children: [
          ListView(shrinkWrap: true, children: [
            infoSection(state),
            const SizedBox(
              height: 5,
            ),
            descriptionSection(state!.description),
            const SizedBox(
              height: 5,
            ),
            reviewSection(state.reviews),
            const SizedBox(
              height: 50,
            ),
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: addToCardWidget(state),
          )
        ]),

        onLoading: const Center(child: CircularProgressIndicator()), // optional
        onError: (error) => Center(
          // optional
          child: Text(
            'Error: $error',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget authorInfo(String key, String value) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Text(
          key,
          style: const TextStyle(fontSize: 16, color: Colors.black38),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
            child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      overflow: TextOverflow.ellipsis),
                ))
          ],
        )),
      ],
    );
  }

  Widget priceBar(int price) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Text(
          ConvertNumberToCurrency(price).toString(),
          style: const TextStyle(fontSize: 20, color: Colors.red),
        ),
      ],
    );
  }

  Widget addToCardWidget(state) {
    return Container(
        height: 50,
        color: Colors.blue,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => {changeQuantity(-1)},
                            icon: const Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.white,
                            )),
                        Obx(
                          () => Text(
                            quantity.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => {changeQuantity(1)},
                          icon: const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ]))),
          Expanded(
            child: Container(
                // color: Colors.red,
                height: 60,
                decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.white))),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: InkWell(
                    onTap: () => {
                          cartController.addProductToCart(state,
                              qty: quantity.value)
                        },
                    child: const Text(
                      "Thêm vào giỏ",
                      style: TextStyle(color: Colors.white),
                    ))),
          )
        ]));
  }

  Widget infoSection(state) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GFImageOverlay(
                boxFit: BoxFit.cover,
                height: 320,
                image: NetworkImage(state!.image)),
            CustomSeparateBox.getSizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Text(
                state.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            CustomSeparateBox.getSizedBox(height: 15),
            priceBar(state.price),
            const SizedBox(
              height: 12,
            ),
            authorInfo("Tác giả:", state.author.name),
            const SizedBox(
              height: 12,
            ),
            authorInfo("Nhà xuất bản:", state.publisher.name),
            const SizedBox(
              height: 12,
            ),
          ],
        ));
  }

  Widget descriptionSection(String description) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Mô tả sản phẩm",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                description,
                style: const TextStyle(height: 1.7),
              ),
            ])));
  }

  Widget reviewSection(List<Review> reviews) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bình luận đánh giá từ khách hàng",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reviews.length,
                      itemBuilder: (_, index) {
                        if (reviews.isEmpty) {
                          return const Text("Chưa có bình luận nào");
                        }
                        return ReviewItem(review: reviews[index]);
                      }),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [reviewButton()])
                ])));
  }

  Widget reviewButton() {
    return Obx(() {
      if (userController.isLogin.value) {
        return ElevatedButton(
          onPressed: () => openFilter(),
          child: const Text('Thêm bình luận'),
        );
      }
      return ElevatedButton(
          onPressed: () => Get.toNamed(AppRoutes.LOGIN),
          child: const Text('Đăng nhập để thêm bình luận'));
    });
  }

  openFilter() {
    Get.bottomSheet(
      ReactiveForm(
          formGroup: fb.group({
            'comment': FormControl<String>(value: controller.comment.value)
          }),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    const Text(
                      "Mô tả sản phẩm",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Đánh giá',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Obx(() => GFRating(
                            allowHalfRating: false,
                            color: Colors.yellow,
                            borderColor: Colors.yellow,
                            size: 25,
                            onChanged: (val) {
                              controller.rating.value = val as int;
                            },
                            value: controller.rating.value.toDouble()))
                      ],
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'comment',
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(labelText: 'Bình luận'),
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ReactiveFormConsumer(
                      builder: (context, form, child) => ElevatedButton(
                        onPressed: form.valid
                            ? () =>
                                {controller.createReview(form.value["comment"])}
                            : null,
                        child: const Text('Gửi đánh giá'),
                      ),
                    ),
                  ])))),
      enableDrag: false,
    );
  }
}
