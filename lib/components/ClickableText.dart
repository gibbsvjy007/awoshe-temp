import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {

  final double width;
  final String title;
  final Color selectedColor;
  final Color defaultColor;
  final bool selected;
  final void Function() onTap;

  const ClickableText(this.title, {Key key, this.width = 115,
    this.selectedColor = Colors.orange,
    this.selected = false,
    this.onTap,
    this.defaultColor = Colors.grey} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (onTap != null)
          onTap();
      },
      child: Container(
        width: width,
        child: Text(title, textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: (width / 5.2),
            color: (selected) ? selectedColor : defaultColor,
          ),
        ),
        margin: EdgeInsets.only(bottom: 8.0),
      ),
    );
  }
}