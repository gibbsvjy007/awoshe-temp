import 'dart:async';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'dart:ui' as ui;
import 'package:rxdart/rxdart.dart';

enum _LoadStatus {LOADING, DONE}
class AspectRatioImage extends StatefulWidget {
  /// image path url
  final String imageUrl;
  /// aspectRatio value. Default is 1.0
  final double aspectRatio;

  AspectRatioImage(this.imageUrl, {this.aspectRatio = 1.0});

  @override
  State<StatefulWidget> createState() => _AspectRatioImageState();

}

class _AspectRatioImageState extends State<AspectRatioImage> {
  Completer<ui.Image> completer = Completer();
  final BehaviorSubject<_LoadStatus> _behaviorSubject = BehaviorSubject();
  ImageStreamListener listener;

  int width, height;
  AdvancedNetworkImage provider;

  @override
  void initState() {
    listener = ImageStreamListener( _processFunction );
    _getImage();
    super.initState();
  }

  @override
  void dispose() {
    _behaviorSubject?.close();
    super.dispose();
  }
  void _processFunction(ImageInfo info, bool _) {
    
    width = info.image.width;
    height = info.image.height;
    print('Image size W: ${info.image.width} H: ${info.image.height}');
    _behaviorSubject.add( _LoadStatus.DONE );
  }

  void _getImage() {
    provider = AdvancedNetworkImage(
      (widget.imageUrl) != null
          ? widget.imageUrl
          : COVER_PLACEHOLDER,
      useDiskCache: true,
      cacheRule: IMAGE_CACHE_RULE,
    );

    provider.resolve( ImageConfiguration()).addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    print('AspectRatioImage builder');
      return StreamBuilder<_LoadStatus>(
        stream: _behaviorSubject.stream,
        initialData: _LoadStatus.LOADING,
        builder: (context, snapshot){
          print('Future builder');

          if (snapshot.data == _LoadStatus.LOADING){
            return Container(
              child: AwosheDotLoading(),
              color: Colors.transparent,
              height: 250.0,
            );
          }
          var aspect = 1.0;

          if (width > height) {
            print('landscape image defining 4:3');
            aspect = 4.0 / 3.0;
          }

          else {
            print('portrait defining 3:4');
            aspect = 3.0 / 4.0;
          }

          return Container(
            child: AspectRatio(
                aspectRatio: aspect,
                child: Image(
                  width: width.toDouble(),
                  height: height.toDouble(),
                  image: provider,
                  fit: BoxFit.cover,
                ),
            ),
          );

        },
      );

  }
}
