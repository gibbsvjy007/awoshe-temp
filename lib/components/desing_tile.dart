import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/utils/assets.dart';

class DesignTile extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  DesignTile({this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Card(
        elevation: 0.4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
        color: Colors.white,

        child: Container(
          height: 100.0,
          width: 100.0,
          child: CachedNetworkImage(
            placeholder: (context, url) => Container(
                  child: AwosheLoading(),
                  padding: EdgeInsets.all(90.0),
                  decoration: BoxDecoration(
                    color: awLightColor300,
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
            ),

            errorWidget: (context, url, error) => Material(
                  child: Image.asset(
                    Assets.imgNotAvailable,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
            imageUrl: imageUrl ?? PLACEHOLDER_DESIGN_IMAGE,
            width: 120.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
