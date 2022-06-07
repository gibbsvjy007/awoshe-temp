import 'package:Awoshe/models/upload.dart';
import 'package:flutter/material.dart';

class AwosheCheckBox extends StatelessWidget {
  final VoidCallback callback;
  final SelectableItem item;
  final double padding;
  final double stretchSpace;
  final TextStyle textStyle;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color iconColor;
  final double iconSize;

  AwosheCheckBox(
      {Key key,
      this.item,
      this.callback,
      this.padding,
      this.stretchSpace,
      this.selectedColor,
      this.iconColor,
      this.iconSize,
      this.textStyle,
      this.unSelectedColor});

  Widget _buildCheckBox(SelectableItem item, VoidCallback callback) =>
      GestureDetector(
        onTap: callback,
        child: Padding(
          padding: EdgeInsets.all(padding ?? 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: item.isSelected ? selectedColor : unSelectedColor,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.check,
                      color: iconColor ?? Colors.white,
                      size: iconSize ?? 14.0,
                    ),
                  ),
                ),
              ),
              item.title != null && item.title != "" ? SizedBox(
                width: stretchSpace ?? 10.0,
              ) : Container(),
              item.title != null && item.title != "" ? Text(
                item.title,
                style: textStyle,
              ): Container()
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _buildCheckBox(item, callback);
  }
}
