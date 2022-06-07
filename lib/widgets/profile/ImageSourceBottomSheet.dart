import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnTap = void Function(ImageSource);
class ImageSourceBottomSheet extends StatelessWidget {

  final OnTap onTap;
  const ImageSourceBottomSheet({Key key, @required this.onTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: new Icon(Icons.camera),
          title: new Text('Camera'),
          onTap: () {
            if (onTap != null)
              onTap(ImageSource.camera);
            Navigator.pop(context);
            },
        ),

        ListTile(
          leading: new Icon(Icons.photo_album),
          title: new Text('Gallery'),
          onTap: () {
            if (onTap != null)
              onTap(ImageSource.gallery);

            Navigator.pop(context);
          }
        ),
      ],
    );
  }
}