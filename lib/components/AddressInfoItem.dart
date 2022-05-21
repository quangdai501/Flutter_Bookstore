import 'package:flutter/material.dart';
import 'package:final_project/models/address_info_model.dart';
// import 'package:flutter_final_project/routes/app_pages.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/address_info_model.dart';
// import 'package:get/get.dart';

class AddressInfoItem extends StatelessWidget {
  const AddressInfoItem({Key? key, required this.addressInfo})
      : super(key: key);
  final AddressInfo addressInfo;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: StaggeredGrid.count(
          crossAxisCount: 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 4,
          children: [
            Text('Họ và tên: ${addressInfo.name}'),
            Text('SDT: ${addressInfo.phone}'),
            Text(
              'Địa chỉ: ${addressInfo.toAddresString()}',
            ),
          ],
        ));
  }
}
