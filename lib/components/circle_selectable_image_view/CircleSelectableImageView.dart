import 'package:Awoshe/components/checkbox/AwosheCircleCheckBox.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class CircleSelectableImageView extends StatelessWidget {
  final String imageUrl;
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final double size;
  final double borderWidth;

  CircleSelectableImageView(
      {this.imageUrl,
      this.isChecked = false,
      this.onChanged,
      this.size = 100,
      this.borderWidth = 2.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: (isChecked) ? primaryColor : Colors.transparent,
                width: borderWidth,
                style: BorderStyle.solid),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AdvancedNetworkImage(
                imageUrl ?? PLACEHOLDER_DESIGN_IMAGE,
                useDiskCache: true,
                cacheRule: IMAGE_CACHE_RULE,
              ),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Material(
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: primaryColor.withOpacity(.5),
                    customBorder: CircleBorder(),
                    onTap: () {
                      if (this.onChanged != null) this.onChanged(!isChecked);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          width: (size / 3),
          height: (size / 3),
          top: size * .70,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
            opacity: (isChecked) ? 1.0 : .0,
            child: (isChecked)
                ? AwosheCircleCheckBox(
                    isSelected: isChecked,
                    iconSize: size / 3.5,
                    onTap: () {},
                  )
                : Container(),
          ),
        ),
      ],
    );
  }
}
