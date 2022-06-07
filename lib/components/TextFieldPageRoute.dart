import 'package:flutter/cupertino.dart';

class TextFieldPageRoute extends PageRouteBuilder{
  final Widget page;

  TextFieldPageRoute({@required this.page}) :

    super(
        pageBuilder: (context, mainAnimation, secondaryAnimation)
          => page,

        transitionsBuilder: (context, mainAnimation,
            secondaryAnimation, Widget child) {
          return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(mainAnimation),
            child: child,
          );
        }
      );

}