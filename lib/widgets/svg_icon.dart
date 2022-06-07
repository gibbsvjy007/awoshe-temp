import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
      this.icon, {
        Key key,
        this.size,
        this.color,
      }) : super(key: key);
  final String icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconSize = size ?? iconTheme.size;
    Color iconColor = color ?? null;

    return Container(
      width: iconSize,
      height: iconSize,
      child: Center(
        child: SvgPicture.asset(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
