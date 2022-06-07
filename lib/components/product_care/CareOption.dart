import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/product_care_assets.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

typedef OnTap = Function(ProductCareType type);

class CareOption extends StatelessWidget {
  final ProductCareType type;
  final bool isSelected;
  final String title;
  final OnTap onTap;
  final double iconSize;
  final EdgeInsets margin;


  const CareOption({Key key,
    @required this.type, this.isSelected = false,
    @required this.title, this.iconSize = 32.0,
    this.margin,
    this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      if (onTap != null)
        onTap(type);
    },
      child: Container(
        //color: Colors.grey,
        margin: margin ?? const EdgeInsets.only(top: 4.0),
        width: iconSize * 2.5,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SvgIcon(
                getProductCareIconPath(type),
                color: (isSelected) ? primaryColor : awLightColor,
                size: iconSize,
              ),

              Text(title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textStyle.copyWith(
                    fontSize: 12,

                    color: (isSelected) ? primaryColor : awLightColor,
                  ),
              ),
            ],
        ),
      ),
    );
  }
}
