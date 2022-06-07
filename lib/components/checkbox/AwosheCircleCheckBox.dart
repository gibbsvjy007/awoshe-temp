import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class AwosheCircleCheckBox extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final double iconSize;
  final Color defaultColor, selectedColor;

  const AwosheCircleCheckBox(
      {Key key,
      this.iconSize = 30.0,
      this.defaultColor = awLightColor,
      this.selectedColor = primaryColor,
      this.isSelected = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(.0),
      margin: EdgeInsets.all(.0),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.check_circle,
          size: iconSize,
          color: (isSelected) ? selectedColor : defaultColor,
        ),
      ),
    );
  }
}
