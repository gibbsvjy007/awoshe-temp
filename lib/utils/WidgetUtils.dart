import 'dart:ui';
import 'package:Awoshe/components/browser.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget getBlurEffectWidget(
        {final double width,
        final double height,
        final double sigmaX = 10,
        final Color color = Colors.transparent,
        final double sigmaY = 15}) =>

    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: color),
      ),
    );

Widget shimmerLoader(Widget child) =>
    Shimmer.fromColors(
      //period: Duration(milliseconds: 500),
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: child,

    );

Widget optionSeparatorWidget({double radius,
  double verticalMargin,
  double horizontalMargin,}) =>
    Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? .0,
          vertical: verticalMargin ?? .0
      ),
      width: double.infinity,
      height: 2,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.05),
          borderRadius: BorderRadius.circular(radius ?? 10.0)
  ),
);

launchURL(String label, url, BuildContext context) async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
  await remoteConfig.fetch(expiration: const Duration(hours: 5));
  await remoteConfig.activateFetched();
//    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WebviewScaffold(
//      url: remoteConfig.getString(url),
//      appBar: AppBar(
//        title: Text(label),
//      ),
//    )));

  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastLinearToSlowEaseIn,
              ),
            ),
            child: child,
          ),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, _, __) =>
          AwosheBrowser(url: "https://awoshe.com/awoshe")));
}
