import 'dart:io';

import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageView extends StatelessWidget {

  final VoidCallback onTap;
  final String imageUrl;
  final Function onDelete;

  const ImageView({Key key, this.onDelete, this.imageUrl, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = (imageUrl == null) ?

    Container(
      height: 110.0,
      width: 110.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: awLightColor300,
      ),
      child: Center(
        child: SizedBox(
          height: 30.0,
          width: 30.0,
          child: SvgPicture.asset(Assets.camera),
        ),
      ),
    ) :
    Container(
      height: 110.0,
      width: 110.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: (imageUrl.contains('https://')) ?
              NetworkImage(imageUrl) :

              FileImage(File(imageUrl))
          )
      ),
    );

    return Stack(
      children: <Widget>[
        InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: onTap,
            child: body
        ),

        Align(
          alignment: Alignment.topRight,
          child: (imageUrl == null) ? Container(width: .0, height: .0,) :
          GestureDetector(
            onTap: onDelete,
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
      ],
    );
  }
}
