import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:flutter/material.dart';
import '../svg_icon.dart';

class ActionButton extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final VoidCallback onTap;
  final Color svgColor;
  const ActionButton({
    Key key,
    this.height = 30.0,
    this.onTap,
    this.svgColor,
    this.assetPath,
    this.width = 51.0,
  })  : assert(assetPath != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Button(
      width: width,
      height: height,
      child: SvgIcon(
        assetPath,
        size: width,
        color: svgColor,
      ),
      // child: Image.asset(assetPath, height: height),
      backgroundColor: Colors.transparent,
      borderRadius: 17.0,
      onPressed: onTap,
    );
  }
}
