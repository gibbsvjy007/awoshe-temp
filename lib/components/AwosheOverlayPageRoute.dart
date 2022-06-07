import 'package:flutter/material.dart';

class AwosheOverlayPageRoute extends ModalRoute<void> {

  final Widget child;

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  AwosheOverlayPageRoute({@required this.child});

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return GestureDetector(
      onTap: (){ Navigator.of(context).pop(); },
      child: Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          child: _buildOverlayContent(context),
        ),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) => this.child;

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
