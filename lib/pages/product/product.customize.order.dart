import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/models/user_profile.dart';
import 'package:Awoshe/pages/product/product_select_color.dart';
import 'package:Awoshe/pages/product/product_select_fabric.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';

class CustomOrder extends StatefulWidget {
  final AnimationController controller;
  final BoxConstraints boxConstraint;
  final Product product;
  //final CartBloc cartBloc;

  CustomOrder({this.boxConstraint, this.controller, this.product});

  @override
  _CustomOrderState createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double containerHeight = 0.0;
  TextEditingController mHeight = TextEditingController();
  TextEditingController mHip = TextEditingController();
  TextEditingController mBurst = TextEditingController();
  TextEditingController mWaist = TextEditingController();
  TextEditingController mChest = TextEditingController();
  TextEditingController mArms = TextEditingController();
  Measurements measurements = Measurements(0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  GlobalKey<FormState> profileMeasurementKey = new GlobalKey<FormState>();
  bool autovalidate = false;
  double containerMaxHeight;
  //CartBloc cartBloc;
  String selectedColor;
  String selectedFabric;

  @override
  void initState() {
    _controller = widget.controller;
    //cartBloc = widget.cartBloc;
    super.initState();
  }

  @override
  void dispose() {
    mHeight.dispose();
    mHip.dispose();
    mBurst.dispose();
    mWaist.dispose();
    mChest.dispose();
    mArms.dispose();
    //cartBloc.dispose();
    super.dispose();
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final h = MediaQuery.of(context).size.height * 0.3;
    final Animation<RelativeRect> frontRelativeRect = new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, height, 0.0, height),
      end: new RelativeRect.fromLTRB(0.0, h, 0.0, 0.0),
    ).animate(new CurvedAnimation(
        parent: _controller, curve: Curves.fastOutSlowIn));
    return frontRelativeRect;
  }

  bool get _dismissUnderway => _controller.status == AnimationStatus.reverse;

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    print("_handleVerticalDragEnd___");
    if (_dismissUnderway) return;
    _controller.value -=
        details.primaryDelta / (containerHeight ?? details.primaryDelta);
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    if (_dismissUnderway) return;
    if (details == null) {
      _controller.fling(velocity: -2.0);
      return;
    }
    final double flingVelocity = details.velocity.pixelsPerSecond.dy / 10.0;
    if (flingVelocity < 0.0) {
      _controller.fling(velocity: math.max(1.0, flingVelocity));
    } else if (flingVelocity > 0.0) {
      _controller.fling(velocity: math.min(-1.0, flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -1.0 : 1.0);
    }
    Navigator.pop(context);
  }

  _fnSelectColor(String color) {
    print("Selected Color: " + color);
    selectedColor = color;
  }

  _fnSelectFabric(String fabric) {
    print("Selected Fabric: " + fabric);
    selectedFabric = fabric;
  }

//  addToCartPressed() {
//    if (widget.product.id == AuthenticationService.appUserId) {
//      ShowFlushToast(context, ToastType.INFO,
//          Localization.of(context).productOwnerIsSameAsLoggedIn);
//      return false;
//    }
//
//    if (selectedColor == null || selectedColor == "") {
//      Awoshe.showToast('Please select one color', this.context);
//      return false;
//    }
//    if (selectedFabric == null || selectedFabric == "") {
//      Awoshe.showToast('Please select one Fabric', this.context);
//      return false;
//    }
//    final FormState form = profileMeasurementKey.currentState;
//    if (!form.validate()) {
//      autovalidate = true; // Start validating on every change.
//      Awoshe.showToast(
//          'Please fix the errors before adding to cart.', this.context);
//    } else {
//      form.save();
//
//      CartItem item = CartItem(
//        productId: widget.product.id,
//          promotionId: widget.product.itemId,
//        price: widget.product.price.toString(),
//          quantity: 1,
//          selectedColor: selectedColor,
//          fabric: selectedFabric,
//          measurements: measurements.toJson(),
//      );
//
//      cartBloc.dispatch(
//        CartEventAdd(
//          event: CartEventType.add,
//          cartItem: item,
//        ),
//      );
//    }
//  }

  String validateMeasurement(value) {
    if (value.isEmpty) {
      return '*required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    containerMaxHeight = MediaQuery.of(context).size.height * 0.6;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          PositionedTransition(
            rect: getPanelAnimation(widget.boxConstraint),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onVerticalDragUpdate: _handleVerticalDragUpdate,
                    onVerticalDragEnd: _handleVerticalDragEnd,
                    child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          child: SvgPicture.asset(
                            Assets.drag,
                            height: 10.0,
                            width: 22.0,
                            color: awLightColor,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            color: Colors.grey[100]),
                        height: _controller.status !=
                            AnimationStatus.dismissed
                            ? 30.0
                            : 0.0,
                        width: MediaQuery.of(context).size.width
                      // color: primaryColor,
                    ),
                  ),
                  AnimatedContainer(
                    height:
                    _controller.status != AnimationStatus.dismissed
                        ? containerMaxHeight
                        : 0.0,
                    curve: Curves.easeInOut,
                    duration: Duration(
                      milliseconds: 500,
                    ),
                    color: Colors.grey[100],
                    margin: EdgeInsets.only(top: 28.0, bottom: 0.0),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      children: <Widget>[
                        SelectColor(
                            product: widget.product,
                            callback: _fnSelectColor),
                        if (widget.product.fabricTags.length > 0)
                          SelectFabric(
                              product: widget.product,
                              callback: _fnSelectFabric),
                        Padding(padding: EdgeInsets.only(bottom: 20.0)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Custom measurements",
                                    style: TextStyle(
                                      color: awBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Text("")),
                              FittedBox(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          top: 5.0,
                                          bottom: 5.0),
                                      decoration: BoxDecoration(
                                          color: awYellowColor,
                                          borderRadius:
                                          BorderRadius.circular(
                                              44.0)),
                                      child: Center(
                                          child: Text(
                                            "Help",
                                            style: TextStyle(
                                                color: secondaryColor),
                                          ))))
                            ],
                          ),
                        ),
                        Form(
                          key: profileMeasurementKey,
                          autovalidate: autovalidate,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(children: <Widget>[
                              Padding(padding: EdgeInsets.all(0.0)),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: InputField(
                                        hintText: Localization.of(context)
                                            .height,
                                        obscureText: false,
                                        hintStyle: TextStyle(
                                            color: secondaryColor),
                                        textInputType:
                                        TextInputType.number,
                                        floatingLabel:
                                        Localization.of(context)
                                            .height,
                                        textStyle: textStyle,
                                        isBorder: true,
                                        leftPadding: 15.0,
                                        controller: mHeight,
                                        radius: 2.0,
                                        validateFunction:
                                        validateMeasurement,
                                        borderColor: secondaryColor,
                                        textFieldColor: textFieldColor,
                                        bottomMargin: 20.0,
                                        onSaved: (String height) {
                                          print(height);
                                          if (height != null &&
                                              height != "")
                                            this.measurements.height =
                                                double.parse(height);
                                        }),
                                  ),
                                  Padding(
                                      padding:
                                      EdgeInsets.only(right: 15.0)),
                                  Flexible(
                                    child: InputField(
                                        hintText:
                                        Localization.of(context).hip,
                                        obscureText: false,
                                        hintStyle: TextStyle(
                                            color: secondaryColor),
                                        textInputType:
                                        TextInputType.number,
                                        textStyle: textStyle,
                                        controller: mHip,
                                        floatingLabel:
                                        Localization.of(context).hip,
                                        borderColor: secondaryColor,
                                        radius: 2.0,
                                        isBorder: true,
                                        leftPadding: 15.0,
                                        validateFunction:
                                        validateMeasurement,
                                        textFieldColor: textFieldColor,
                                        bottomMargin: 20.0,
                                        onSaved: (String hip) {
                                          if (hip != null && hip != "")
                                            this.measurements.hip =
                                                double.parse(hip);
                                        }),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: InputField(
                                        hintText: Localization.of(context)
                                            .chest,
                                        obscureText: false,
                                        hintStyle: TextStyle(
                                            color: secondaryColor),
                                        textInputType:
                                        TextInputType.number,
                                        textStyle: textStyle,
                                        controller: mChest,
                                        floatingLabel:
                                        Localization.of(context)
                                            .chest,
                                        borderColor: secondaryColor,
                                        radius: 2.0,
                                        isBorder: true,
                                        leftPadding: 15.0,
                                        validateFunction:
                                        validateMeasurement,
                                        textFieldColor: textFieldColor,
                                        bottomMargin: 20.0,
                                        onSaved: (String chest) {
                                          if (chest != null &&
                                              chest != "")
                                            this.measurements.chest =
                                                double.parse(chest);
                                        }),
                                  ),
                                  Padding(
                                      padding:
                                      EdgeInsets.only(right: 15.0)),
                                  Flexible(
                                    child: InputField(
                                        hintText: Localization.of(context)
                                            .burst,
                                        obscureText: false,
                                        hintStyle: TextStyle(
                                            color: secondaryColor),
                                        textInputType:
                                        TextInputType.number,
                                        textStyle: textStyle,
                                        floatingLabel:
                                        Localization.of(context)
                                            .burst,
                                        controller: mBurst,
                                        radius: 2.0,
                                        leftPadding: 15.0,
                                        isBorder: true,
                                        validateFunction:
                                        validateMeasurement,
                                        borderColor: secondaryColor,
                                        textFieldColor: textFieldColor,
                                        bottomMargin: 20.0,
                                        onSaved: (String burst) {
                                          if (burst != null &&
                                              burst != "")
                                            this.measurements.burst =
                                                double.parse(burst);
                                        }),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: InputField(
                                        hintText:
                                        Localization.of(context).arms,
                                        obscureText: false,
                                        hintStyle: TextStyle(
                                            color: secondaryColor),
                                        textInputType:
                                        TextInputType.number,
                                        textStyle: textStyle,
                                        controller: mArms,
                                        isBorder: true,
                                        leftPadding: 15.0,
                                        radius: 2.0,
                                        validateFunction:
                                        validateMeasurement,
                                        floatingLabel:
                                        Localization.of(context).arms,
                                        borderColor: secondaryColor,
                                        textFieldColor: textFieldColor,
                                        bottomMargin: 20.0,
                                        onSaved: (String arms) {
                                          if (arms != null && arms != "")
                                            this.measurements.arms =
                                                double.parse(arms);
                                        }),
                                  ),
                                  Padding(
                                      padding:
                                      EdgeInsets.only(right: 15.0)),
                                  Flexible(
                                    child: InputField(
                                        hintText: Localization.of(context)
                                            .waist,
                                        obscureText: false,
                                        hintStyle: TextStyle(
                                            color: secondaryColor),
                                        textInputType:
                                        TextInputType.number,
                                        floatingLabel:
                                        Localization.of(context)
                                            .waist,
                                        textStyle: textStyle,
                                        controller: mWaist,
                                        radius: 2.0,
                                        leftPadding: 15.0,
                                        isBorder: true,
                                        validateFunction:
                                        validateMeasurement,
                                        borderColor: secondaryColor,
                                        textFieldColor: textFieldColor,
                                        bottomMargin: 20.0,
                                        onSaved: (String waist) {
                                          if (waist != null &&
                                              waist != "")
                                            this.measurements.waist =
                                                double.parse(waist);
                                        }),
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width:
                            MediaQuery.of(context).size.width * 0.6,
                            child: AwosheButton(
                              radius: 30.0,
                              //onTap: addToCartPressed,
                              childWidget: Text("Add to cart",
                                  style: buttonTextStyle),
                              buttonColor: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 50.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
