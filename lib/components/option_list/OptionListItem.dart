import 'package:Awoshe/components/checkbox/AwosheCircleCheckBox.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class OptionListItem extends StatelessWidget {
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle titleStyle;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const OptionListItem({Key key, this.selectedColor = primaryColor,
    this.isSelected = false, this.unselectedColor = awLightColor,
    this.titleStyle, @required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Text(          
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titleStyle ?? TextStyle(
              fontSize: 22.0,
              color: awLightColor,
            ),
          ),

          Container(width: 12.0,),

          Expanded(
            flex: 1,
            child: Container(
              height: 1.0,
              color: awLightColor.withOpacity(.9),
            ),
//            child: AnimatedOpacity(
//              opacity: (isSelected) ? 1.0 : .0,
//              duration: Duration(milliseconds: 700),
//              child: Container(
//                height: 1.0,
//                color: awLightColor,
//              ),
//            ),

          ),

          AwosheCircleCheckBox(
            onTap: onTap,
            isSelected: isSelected,
            iconSize: 30,
          ),

        ],
    );
  }
}
