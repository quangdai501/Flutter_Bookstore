import 'package:flutter/material.dart';
import 'package:final_project/models/order_model.dart';
import 'package:final_project/utils/convert_currency.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/order_model.dart';

class BillDetailItem extends StatelessWidget {
  const BillDetailItem({Key? key, required this.billDetail}) : super(key: key);
  final BillDetail billDetail;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: StaggeredGrid.count(
              crossAxisCount: 12,
              mainAxisSpacing: 2,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 2,
                    child: SizedBox(
                      height: 120,
                      width: 90,
                      child: Image.network(
                        billDetail.image,
                        // fit: BoxFit.cover,
                      ),
                    )),
                StaggeredGridTile.count(
                  crossAxisCellCount: 8,
                  mainAxisCellCount: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      billDetail.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 8,
                  mainAxisCellCount: 1,
                  child: Row(children: [
                    Text(
                      ConvertNumberToCurrency(billDetail.price),
                      style: const TextStyle(color: Colors.red),
                    ),
                    Text(
                      ' X ' + billDetail.qty.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ConvertNumberToCurrency(
                              billDetail.price * billDetail.qty),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            )));
  }
}
