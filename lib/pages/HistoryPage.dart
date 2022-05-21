import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:final_project/controllers/my_order_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../components/OrderItem.dart';
import '../controllers/my_order_controller.dart';

class HistoryPage extends GetView<MyOrderController> {
  HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black54),
                onPressed: () => Get.back(),
              ),
              title: const Text(
                "Lịch sử mua hàng",
                style: TextStyle(color: Colors.black87),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                  child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.black87,
                      indicatorColor: Colors.blue,
                      labelColor: Colors.blue,
                      onTap: (index) => controller.getOrder(0),
                      tabs: const [
                        Tab(
                          child: Text('Tất cả'),
                        ),
                        Tab(
                          child: Text('Đang xử lý'),
                        ),
                        Tab(
                          child: Text('Đang giao'),
                        ),
                        Tab(
                          child: Text('Đã giao'),
                        ),
                        Tab(
                          child: Text('Đã hủy'),
                        ),
                      ]),
                  preferredSize: Size.fromHeight(30.0)),
            ),
            body: controller.obx(
                (state) => TabBarView(
                      children: [
                        Expanded(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 4,
                            itemCount: state!.length,
                            itemBuilder: (context, index) {
                              return OrderItem(order: state[index]);
                            },
                          ),
                        ),
                        Expanded(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 4,
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              if(state[index].deliveryStatus== "Đang chờ xử lý"){
                                return OrderItem(order: state[index]);
                              }
                              return Container();
                            },
                          ),
                        ),
                        Expanded(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 4,
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              if(state[index].deliveryStatus== "Đang giao"){
                                return OrderItem(order: state[index]);
                              }
                              return Container();
                            },
                          ),
                        ),
                        Expanded(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 4,
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              if(state[index].deliveryStatus== "Đã giao"){
                                return OrderItem(order: state[index]);
                              }
                              return Container();
                            },
                          ),
                        ),
                        Expanded(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 4,
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              if(state[index].deliveryStatus== "Đã hủy"){
                                return OrderItem(order: state[index]);
                              }
                              return Container();
                            },
                          ),
                        )
                      ],
                    ),
                onEmpty: const Align(
                  alignment: Alignment.center,
                  child: Text("Không có đơn hàng nào"),
                ))));
  }
}
