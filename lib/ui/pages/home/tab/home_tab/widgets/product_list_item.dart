import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/date_time_utils.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/product_summary.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/product_detail/product_detail_page.dart';
import 'package:intl/intl.dart';

class ProductListItem extends StatelessWidget {
  ProductListItem(this.productSummary);

  final ProductSummary productSummary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailPage(productSummary.id);
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        height: 120,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  productSummary.thumbnail.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productSummary.title, style: TextStyle(fontSize: 15)),
                  Text(
                    '${productSummary.address.displayName} ${DateTimeUtils.formatString(productSummary.updatedAt)}',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  Text(
                    NumberFormat('#,###원').format(productSummary.price),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(CupertinoIcons.heart, size: 14),
                      SizedBox(width: 4),
                      Text(
                        '${productSummary.likeCnt}',
                        style: TextStyle(fontSize: 12, height: 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
