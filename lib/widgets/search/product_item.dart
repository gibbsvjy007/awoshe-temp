import 'package:Awoshe/models/search/search_result_item.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

import '../../constants.dart';
import '../loading.dart';

class ProductItem extends StatelessWidget {
  final SearchResultItem product;
  final Function onPressed;

  final isTile = false;
  ProductItem({this.product, this.onPressed});

  Widget buildListItem(BuildContext context) => ListTile(
    dense: true,
    leading: Container(
      child: TransitionToImage(
        image: AdvancedNetworkImage(
          product.imageUrl != null
              ? product.imageUrl
              : COVER_PLACEHOLDER,
          useDiskCache: true,
          cacheRule: IMAGE_CACHE_RULE,
        ),
        fit: BoxFit.cover,
        placeholder: const Icon(Icons.refresh),
        alignment: Alignment.centerRight,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.0),
            topRight: Radius.circular(2.0)),
        enableRefresh: true,
        loadingWidget: Container(
          child: AwosheDotLoading(),
          color: awLightColor300,
          height: 60.0,
          width: 55.0,
        ),
      )
    ),
    title: Text(
      product.title,
      style: boldText,
      textAlign: TextAlign.left,
    ),
    subtitle: Text(
      '${product.price}' + " " + '${product.currency}',
      style: hintStyle,
    ),
    onTap: onPressed,
  );

  @override
  Widget build(BuildContext context) {
    dynamic deviceSize = MediaQuery.of(context).size;
    return isTile ? Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            product.imageUrl,
            width: deviceSize.width * 0.5 - 5,
            height: deviceSize.height * 0.2,
            alignment: Alignment.topLeft,
            fit: BoxFit.fitWidth,
          ),
          Container(
              padding: EdgeInsets.only(top: 10.0, left: 5.0),
              width: deviceSize.width * 0.5 - 16,
              child: Text(
                product.title,
                style: boldText,
                textAlign: TextAlign.left,
              )),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        Text(product.id.substring(0, 10), style: textStyle12light),
                        SizedBox(height: 10.0),
                        Text(
                          '${product.price}' + " " + '${product.currency}',
                          style: boldText,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 25.0,
                          child: IconButton(
                              iconSize: 18.0, icon: Icon(Icons.favorite, color: Colors.red), onPressed: () {
                                
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ) : buildListItem(context);
  }
}
