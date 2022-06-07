import 'package:Awoshe/components/product/product_image.dart';
import 'package:Awoshe/models/order/designer_order_item.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class ProductInfoTile extends StatelessWidget {
  final DesignerOrderItem orderItem;

  ProductInfoTile({this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      child: Row(
        children: <Widget>[
          ProductImage(imageUrl: orderItem.productImageUrl),
          SizedBox(width: 15.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    orderItem.productTitle,
                    style: textStyle1,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    orderItem.productCreator.name,
                    style: const TextStyle(
                      color: awLightColor,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    "\$" + orderItem.price.toString(),
                    style: textStyle1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
