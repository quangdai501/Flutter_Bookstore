import 'package:flutter/material.dart';
import 'package:final_project/controllers/cart_controller.dart';
import 'package:final_project/models/cart_model.dart';
import 'package:final_project/utils/convert_currency.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

class CartItem extends GetView<CartController> {
  const CartItem({
    Key? key,
    required this.cart,
    required this.index,
  }) : super(key: key);
  final Cart cart;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: StaggeredGrid.count(
              crossAxisCount: 12,
              mainAxisSpacing: 3,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 3,
                  mainAxisCellCount: 3,
                  child: Image.network(
                    cart.image,
                    fit: BoxFit.cover,
                    // height: 220,
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 8,
                  mainAxisCellCount: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      cart.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 8,
                  mainAxisCellCount: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ConvertNumberToCurrency(cart.price),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 8,
                  mainAxisCellCount: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () =>
                                {controller.changeCartQuantity(index, -1)},
                            icon: const Icon(
                              Icons.remove,
                              size: 16,
                            )),
                        Text(
                          cart.qty.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () =>
                              {controller.changeCartQuantity(index, 1)},
                          icon: const Icon(
                            Icons.add,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              ConvertNumberToCurrency(cart.price * cart.qty),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                ),
                StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () =>
                              {controller.removeFromCart(cart.productId)},
                          icon: const Icon(Icons.close)),
                    )),
              ],
            )));
  }
}
