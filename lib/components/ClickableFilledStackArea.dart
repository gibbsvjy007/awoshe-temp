import 'package:flutter/material.dart';

typedef OnTap = void Function();

class ClickableFilledStackArea extends StatelessWidget {

  final OnTap onTap;

  const ClickableFilledStackArea({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        elevation: .0,
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
        ),
      ),
    );
  }
}
