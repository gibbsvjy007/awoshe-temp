import 'dart:ui';

import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/models/product/product_color.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:flutter/material.dart';

class SelectColor extends StatefulWidget {
  final Product product;
  final Function callback;
  SelectColor({this.product, this.callback});

  @override
  _SelectColorState createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  int currentColor = -1;
  List<ProductColor> productColors = List<ProductColor>();

  @override
  void initState() {
    productColors = Utils.getListWithProductColor(Utils.uniqueList(widget.product.availableColors));
    _settingProductCustomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select Color",
              style: TextStyle(
                color: awBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 70.0,
            padding: const EdgeInsets.only(left: 20.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Row(
                  children: (productColors.length >
                      0 &&
                      productColors != null)
                      ? productColors
                      .map<Widget>((ProductColor color) {

                    return Tooltip(
                      message: '${color.name}',
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: InkWell(
                              onTap: () {
                                currentColor = productColors.indexOf(color);
                                setState(() {});
                                widget.callback(color.name);
                                print(color.toString());
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                    color: color.colorCode,
                                    border: Border.all(width: 1.0, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(50.0)),
                              ),
                            ),
                          ),
                          currentColor ==
                              productColors
                                  .indexOf(color)
                              ? Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50.0)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 0.0, sigmaY: 0.0),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 10.0),
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: Colors.black87
                                          .withOpacity(0.5),
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          50.0)),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ) : Container(),
                        ],
                      ),
                    );

                  }).toList()
                      : <Widget>[Container()],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ProductColor> _settingProductCustomColors() {
    var colors = <ProductColor>[];

    widget.product.customColors.keys.forEach(  (colorName) =>
        productColors.add( ProductColor(colorName, Color(widget.product.customColors[colorName]) ) ));

    return colors;
  }
}


