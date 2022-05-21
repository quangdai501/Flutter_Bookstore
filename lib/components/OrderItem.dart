import 'package:flutter/material.dart';
import 'package:final_project/models/order_model.dart';
import 'package:final_project/utils/convert_currency.dart';
import 'package:final_project/utils/convert_date_time.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'BillDetaiItem.dart';

class Field {
  String key;
  String value;

  Field({required this.key, required this.value});
  @override
  String toString() {
    return '$key: $value';
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          top: 10,
          right: 0,
          bottom: 10,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text("Đơn hàng", style: titleStyle),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        order.id.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )),
              ],
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            const SizedBox(height: 12),
            section("Thông tin", info()),
            const SizedBox(height: 12),
            section("Địa chỉ giao hàng", addressInfo()),
            const SizedBox(height: 12),
            MasonryGridView.count(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: order.billDetail.length,
              itemBuilder: (context, index) {
                return BillDetailItem(billDetail: order.billDetail[index]);
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Tổng", style: titleStyle),
                const SizedBox(width: 12),
                Text(ConvertNumberToCurrency(order.total)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget section(String title, List<Field> arr) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: titleStyle)),
        Padding(
            padding: const EdgeInsets.all(12),
            child: StaggeredGrid.count(
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
              children: [
                for (var i in arr) Text(i.toString()),
              ],
            )),
        const Divider(height: 2, thickness: 2),
        const SizedBox(height: 12),
      ],
    );
  }

  final TextStyle titleStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  List<Field> info() {
    return [
      Field(key: "Trạng thái", value: order.deliveryStatus.toString()),
      Field(key: "Thời gian đặt", value: ConvertDateTime(order.createdAt)),
      Field(key: "Phương thức thanh toán", value: order.payment.toString()),
    ];
  }

  List<Field> addressInfo() {
    return [
      Field(key: "Người nhận", value: order.name),
      Field(key: "Điện thoại", value: order.phone),
      Field(key: "Địa chỉ", value: order.address.toString()),
    ];
  }
}
