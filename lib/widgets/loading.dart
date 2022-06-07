import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            backgroundColor: secondaryColor,
          ),
        ),
        ModalBarrier(
          dismissible: false,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    );
  }
}

class AwosheLoading extends StatelessWidget {
  final double size;
  AwosheLoading({this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 30.0,
        width: size ?? 30.0,
        child: CircularProgressIndicator(
          strokeWidth: 1.0,
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}

class AwosheDotLoading extends StatelessWidget {
  final Color color;

  const AwosheDotLoading({Key key, this.color}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DotSpinner(
        height: 30.0,
        dotType: DotType.circle,
        dotOneColor: color ?? primaryColor,
        dotThreeColor: color ?? primaryColor,
        dotTwoColor: color ?? primaryColor,
      ),
    );
  }
}

class ModalAwosheLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ModalBarrier(
          color: Colors.black.withOpacity(.7),
        ),
        AwosheLoadingV2()
      ],
    );
  }
}




class AwosheLoadingV2 extends StatelessWidget {
  final Color innerColor;
  final Color outerColor;
  final double radius;
  const AwosheLoadingV2({
    Key key,
    this.innerColor = primaryColor,
    this.outerColor = primaryColor,
    this.radius = 36.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: radius,
            width: radius,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(innerColor),
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..scale(0.8)
              ..rotateZ(pi),
            child: SizedBox(
              height: radius,
              width: radius,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(outerColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}