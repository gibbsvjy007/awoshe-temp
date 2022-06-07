import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  ///whether the button is an outline button. Defaults to false.
  final bool isOutlined;

  ///Width of the button. Fills the width of its parent if not provided and the parent
  ///has definite width. If the parent has infinite width it defaults to 200.0.
  final double width;

  ///Height of the button. Fills the height of its parent if not provided and the parent
  ///has definite width. If the parent has infinite height it defaults to 50.0.
  final double height;

  ///child to be displayed in the button.
  final Widget child;

  ///Color of the text displayed in the button.
  final Color textColor;

  ///The text style that needs to be applied to the text. If not provided
  ///defaults to the default text style.
  final TextStyle textStyle;

  ///Background color of the button.
  final Color backgroundColor;

  ///Color of the button when it is disabled.
  final Color disabledColor;

  ///Color of the text button when it is disabled. Defaults to White
  final Color disabledTextColor;

  final TextStyle disabledTextStyle;

  ///Gradient used as the background to the button. If provided, it overrides
  ///the backgroundColor property.
  final Gradient gradientBackground;

  ///Border radius of the button. Defaults to 6.5.
  final double borderRadius;

  ///The border color.
  final Color borderColor;

  ///Width of the border. Defaults to 1.5.
  final double borderWidth;

  ///Whether the button is in loading state. Defaults to false.
  final bool loading;

  final EdgeInsets padding;

  ///Callback that is executed when the button is pressed. If null the button
  ///will be disabled.
  @required
  final VoidCallback onPressed;

  const Button({
    Key key,
    @required this.child,
    this.backgroundColor = Colors.transparent,
    this.width = 50.0,
    this.height = 50.0,
    this.gradientBackground,
    @required this.onPressed,
    this.textStyle,
    this.textColor,
    this.borderRadius = 6.5,
    this.isOutlined = false,
    this.borderColor = Colors.white,
    this.borderWidth = 1.5,
    this.loading = false,
    this.disabledColor,
    this.padding,
    this.disabledTextColor = Colors.white,
    this.disabledTextStyle,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  final int _animationDuration = 200;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: _animationDuration), vsync: this);

    //Animation that shrinks down the button to provide the feedback of button being pressed.
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.98).animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            }
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(minWidth: widget.width, minHeight: widget.height),
      child: GestureDetector(
        onTap: _handleTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            padding: widget.padding,
            duration: Duration(milliseconds: _animationDuration),
            decoration: BoxDecoration(
              color: buttonColor(),
              gradient: widget.isOutlined || disabled || widget.loading
                  ? null
                  : widget.gradientBackground,
              border: widget.isOutlined
                  ? Border.all(
                      color: disabled ? Colors.transparent : widget.borderColor,
                      width: widget.borderWidth,
                    )
                  : null,
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
            ),
            child: Center(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: !widget.loading
                  ? DefaultTextStyle(
                      style: _textStyle(context),
                      child: IconTheme(
                        data: IconThemeData(color: widget.textColor),
                        child: widget.child,
                      ),
                    )
                  : DotSpinner(),
            ),
          ),
        ),
      ),
    );
  }

  bool get disabled => widget.onPressed == null;

  void _handleTap() {
    if (!disabled && !widget.loading) {
      _animationController.forward();
      widget.onPressed();
    }
  }

  TextStyle _textStyle(context) {
    TextStyle style = Theme.of(context).textTheme.body1;
    if (disabled) {
      return widget.disabledTextStyle ??
          style.copyWith(color: widget.disabledTextColor);
    }
    return widget.textStyle ??
        style.copyWith(
          color: widget.textColor ?? Colors.black,
          fontSize: 14.0,
        );
  }

  Color buttonColor() {
    if (disabled) {
      if (widget.disabledColor != null) {
        return widget.disabledColor;
      }
      return Color.fromRGBO(198, 198, 198, 1.0);
    } else if (widget.loading) {
      return widget.backgroundColor;
    } else {
      if (widget.isOutlined) {
        if (widget.backgroundColor != null) {
          return widget.backgroundColor;
        }
        return Colors.transparent;
      } else {
        return widget.backgroundColor;
      }
    }
  }
}

CupertinoButton x;
