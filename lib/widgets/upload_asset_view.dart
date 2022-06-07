import 'dart:io';

import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetView extends StatefulWidget {
  final File asset;
  final EdgeInsets margin;
  final double height;
  final double width;
  final Function onDelete;
  final int index;
  AssetView({this.asset, this.margin, this.index, this.width = 50.0, this.height = 50.0, this.onDelete});

  @override
  State<StatefulWidget> createState() => AssetState();
}

class AssetState extends State<AssetView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (null != widget.asset) {
      //print(widget.asset);
      return Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              width: widget.width,
              height: widget.height,
              margin: widget.margin != null ? widget.margin : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(15.0)),
              ),
              child: Image.file(
                widget.asset,
                fit: BoxFit.cover,
                gaplessPlayback: true,
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.6,
              child: GestureDetector(
                onTap: () {
                  print("delete image");
                  //widget.onDelete(widget.asset, widget.index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  child: SvgPicture.asset(
                    Assets.deleteIcon,
                    color: primaryColor,
                    height: 20.0,
                    width: 20.0,
                  ),
                ),
              ),
            )
          ]);
    }

    return Center(
      child: Container(
        height: 15.0,
        width: 15.0,
        child: CircularProgressIndicator(
          strokeWidth: 1.0,
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
