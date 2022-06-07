import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

/// @author - Vijay
/// TODO - related product section is pending this can be reusable at other places well.
/// passing the product Id only so that we can simly reuse it
class RelatedProduct extends StatelessWidget {
  final String productId;
  RelatedProduct({this.productId});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: const EdgeInsets.only(bottom: 50.0),
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                color: awLightColor,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                color: awYellowColor,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    color: awDarkColor,
                    image: DecorationImage(
                        image: NetworkImage(
                            "http://lorempixel.com/640/480/fashion"),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                color: awBlack,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                color: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
