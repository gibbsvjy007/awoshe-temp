import 'package:flutter/material.dart';

class DotColor extends StatelessWidget {
  DotColor({this.color, this.height, this.width});

  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height ?? 40.0,
      height: width ?? 40.0,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(50.0)),
    );
  }
}
