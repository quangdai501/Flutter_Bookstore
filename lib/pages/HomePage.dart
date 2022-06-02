import 'dart:async';

import 'package:final_project/components/ProductItem.dart';
import 'package:final_project/controllers/dashboard_controller.dart';
import 'package:final_project/controllers/home_page_controller.dart';
import 'package:final_project/controllers/shop_page_controller.dart';
import 'package:final_project/models/product_model.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/utils/convert_currency.dart';
import 'package:flutter/material.dart';
import 'package:final_project/customs/CustomBorder.dart';
import 'package:final_project/customs/CustomTextStyle.dart';
import 'package:final_project/customs/CustomSeparateBox.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({Key? key}) : super(key: key);

  List<String> listImage = [];
  List<String> ListBooksImage = [];
  List<Product> bestSellProducts = [];
  List<Product> featureProducts = [];

  DashboardController dbController = Get.put(DashboardController());
  ShopPageController shopPageController = Get.find();
  final searchKey = ''.obs;
  final selectedSliderPosition = 0.obs;

  void sliderImage() {
    listImage.add("assets/images/banner.jpg");
    listImage.add("assets/images/banner.jpg");
    listImage.add("assets/images/banner.jpg");
  }

  void booksImage() {
    ListBooksImage.add("assets/images/img1.jpg");
    ListBooksImage.add("assets/images/img2.jpg");
    ListBooksImage.add("assets/images/img3.jpg");
    ListBooksImage.add("assets/images/img4.jpg");
    ListBooksImage.add("assets/images/img5.jpg");
  }

  void initData() {
    bestSellProducts = controller.bestSellingProduct.value;
    featureProducts = controller.featureProduct.value;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    booksImage();
    sliderImage();
    initData();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.lightBlueAccent,
                      height: height / 4,
                    ),
                    Container(
                      height: height / 3,
                      margin:
                          const EdgeInsets.only(top: 40, right: 20, left: 20),
                      child: TextField(
                        style: const TextStyle(color: Colors.black54),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                shopPageController.query.update((val) {
                                  val!.search = searchKey.value;
                                });
                                shopPageController.getInitPage();
                                dbController.setSearchKey(searchKey.value);
                                dbController.changeTabIndex(1);
                                // Get.toNamed(AppRoutes.CATEGORY, arguments: searchKey.value);
                              }),
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
                          searchKey.value = text;
                        },
                      ),
                    ),
                    Container(
                        height: (height / 4) + 75,
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: height / 5,
                          child: PageView.builder(
                            itemBuilder: (context, position) {
                              return createSlider(listImage[position]);
                            },
                            controller: PageController(viewportFraction: .95),
                            itemCount: listImage.length,
                            onPageChanged: (position) {
                              dbController.idx.value = position;
                            },
                          ),
                        )),
                    Container(
                        height: (height / 3) + 30,
                        alignment: Alignment.bottomCenter,
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(listImage.length,
                                (index) {
                              return Container(
                                margin: EdgeInsets.all(3),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: dbController.idx.value == index
                                        ? Colors.black87
                                        : Colors.black26,
                                    shape: BoxShape.circle),
                              );
                            }),
                          );
                        }))
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(new MaterialPageRoute(
                    //     builder: (context) => SeeAllProductPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 26),
                        child: Text(
                          "Bán chạy",
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 16),
                        child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Text("Tất cả",
                                    style: CustomTextStyle.textFormFieldRegular
                                        .copyWith(color: Colors.lightBlue)),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 14, color: Colors.lightBlue),
                              ],
                            ),
                            onTap: () => dbController.changeTabIndex(1)),
                      )
                    ],
                  ),
                ),
                CustomSeparateBox.getSizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ProductItem(product: bestSellProducts[index]);
                    },
                    itemCount: bestSellProducts.length,
                  ),
                ),
                CustomSeparateBox.getSizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 26),
                      child: Text(
                        "Đặc sắc",
                        style: CustomTextStyle.textFormFieldRegular
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, right: 16),
                        child: InkWell(
                            child: Row(
                              children: <Widget>[
                                Text("Tất cả",
                                    style: CustomTextStyle.textFormFieldRegular
                                        .copyWith(color: Colors.lightBlue)),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 14, color: Colors.lightBlue),
                              ],
                            ),
                            onTap: () => dbController.changeTabIndex(1)))
                  ],
                ),
                CustomSeparateBox.getSizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ProductItem(product: featureProducts[index]);
                    },
                    itemCount: featureProducts.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  createSlider(String image) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      ),
    );
  }

  createGroupBuyListItem(Product product, int index) {
    double leftMargin = 10;
    double rightMargin = 10;

    return Container(
      margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.image),
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
            ),
            flex: 65,
          ),
          Expanded(
            flex: 35,
            child: Container(
              padding: EdgeInsets.only(
                  left: leftMargin, right: rightMargin, top: 10),
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                    style: CustomTextStyle.textFormFieldMedium
                        .copyWith(color: Colors.black54, fontSize: 12),
                  ),
                  CustomSeparateBox.getSizedBox(height: 4),
                  Text(
                    ConvertNumberToCurrency(product.price),
                    style: CustomTextStyle.textFormFieldMedium
                        .copyWith(color: Colors.redAccent, fontSize: 13),
                  )
                ],
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
            ),
          )
        ],
      ),
    );
  }

  createMostBigListItem(String image, int index, BuildContext context) {
    double leftMargin = 0;
    double rightMargin = 0;
    double radius = 16;
    if (index != featureProducts.length - 1) {
      leftMargin = 10;
    } else {
      leftMargin = 10;
      rightMargin = 10;
    }
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: "$image,$index",
                child: Container(
                  width: 120,
                  height: 120,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius),
                          topRight: Radius.circular(radius))),
                ),
                transitionOnUserGestures: true,
              ),
              flex: 70,
            ),
            CustomSeparateBox.getSizedBox(height: 8),
            Expanded(
              flex: 30,
              child: Container(
                padding: EdgeInsets.only(
                    left: leftMargin, right: rightMargin, top: 10),
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tên sách",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                          color: Colors.black.withOpacity(.7), fontSize: 14),
                    ),
                    CustomSeparateBox.getSizedBox(height: 4),
                    Text(
                      "50000đ",
                      style: CustomTextStyle.textFormFieldSemiBold
                          .copyWith(color: Colors.redAccent, fontSize: 12),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(radius))),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        // Navigator.of(context).push(new MaterialPageRoute(
        //     builder: (context) => ProductDetailsPage("$image,$index")));
      },
    );
  }
}
