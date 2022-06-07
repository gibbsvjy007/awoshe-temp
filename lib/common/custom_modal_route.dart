import 'package:flutter/material.dart';

const Duration _kBottomSheetDuration = const Duration(milliseconds: 200);

class AwosheCustomBottomModalRoute<T> extends PopupRoute<T> {
  AwosheCustomBottomModalRoute({
    this.builder,
    this.theme,
    this.barrierLabel,
    RouteSettings settings,
    this.child,
    this.resizeToAvoidBottomPadding,
    this.dismissOnTap,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final ThemeData theme;
  final bool resizeToAvoidBottomPadding;
  final bool dismissOnTap;
  final Widget child;

  @override
  Duration get transitionDuration => _kBottomSheetDuration;

  @override
  bool get barrierDismissible => false;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black12;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: child,
    );
    if (theme != null)
      bottomSheet = new Theme(data: theme, child: bottomSheet);
    return bottomSheet;
  }
}


