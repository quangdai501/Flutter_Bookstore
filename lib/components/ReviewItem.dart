import 'package:flutter/material.dart';
import 'package:final_project/models/review_model.dart';
import 'package:final_project/utils/convert_date_time.dart';
import 'package:getwidget/getwidget.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({Key? key, required this.review}) : super(key: key);
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(review.name),
            Text(ConvertDateTime(review.updatedAt)),
          ]),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: GFRating(
              color: Colors.yellow,
              borderColor: Colors.yellow,
              size: 16,
              value: review.rating.toDouble(),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 6),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                review.comment,
                textAlign: TextAlign.left,
              )),
          const Divider(
            height: 2,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
