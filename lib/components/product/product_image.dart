import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;

  ProductImage({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return Material(
                color: Colors.black38,
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: TransitionToImage(
                      image: AdvancedNetworkImage(
                        this.imageUrl,
                        useDiskCache: true,
                        cacheRule: IMAGE_CACHE_RULE,
                      ),
                      fit: BoxFit.fitWidth,
                      loadingWidget: Container(
                        child: AwosheDotLoading(),
                        color: awLightColor,
                        height: 300.0,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              );
            }));
      },
      child: Container(
        height: 70.0,
        width: 70.0,
        child: TransitionToImage(
          borderRadius: BorderRadius.circular(2.0),
          image: AdvancedNetworkImage(
            this.imageUrl,
            useDiskCache: true,
            cacheRule: IMAGE_CACHE_RULE,
          ),
          fit: BoxFit.cover,
          loadingWidget: Container(
            child: AwosheDotLoading(),
            color: awLightColor,
          ),
        ),
      ),
    );
  }
}
