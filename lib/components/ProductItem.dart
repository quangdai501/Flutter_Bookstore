import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/models/product_model.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';
import '../customs/CustomSeparateBox.dart';
import '../customs/CustomTextStyle.dart';
import '../utils/convert_currency.dart';

class ProductItem extends StatelessWidget {
  final ProductDetailController productDetailController = Get.find();
  ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;
  double leftMargin = 10;
  double rightMargin = 10;
  @override
  Widget build(BuildContext context) {
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
              child: InkWell(
                onTap: () {
                  productDetailController.getProductById(product.id);
                  Get.toNamed(
                    AppRoutes.PRODUCT_DETAIL + product.id,
                  );
                },
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  height: 160,
                  width: 220,
                ),
              ),
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(product.image),
              //     ),
              //     borderRadius: const BorderRadius.only(
              //         topLeft: Radius.circular(8),
              //         topRight: Radius.circular(8))),
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
}
