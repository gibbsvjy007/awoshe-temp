import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


typedef OnTap = void Function( UploadType type);
class AwosheUploadBottomSheet extends StatelessWidget {

  final OnTap onTap;

  AwosheUploadBottomSheet({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: SvgIcon(
              Assets.designProducts,
              size: 35.0,
            ),
            title: Text('Product / Design',
                style: TextStyle(color: Colors.white)),
            onTap: () async {
              Navigator.pop(context);
              if (onTap != null)
                onTap(UploadType.DESIGN);
              //_bloc.navigateToUpload(UploadType.DESIGN);
            },
          ),
          ListTile(
            leading: SvgIcon(
              Assets.fabric,
              size: 35.0,
            ),
            title: Text('Fabric', style: TextStyle(color: Colors.white)),
            onTap: () async {
              Navigator.pop(context);
              if (onTap != null)
                onTap(UploadType.FABRIC);
            },
          ),
          ListTile(
            leading: SvgIcon(
              Assets.blog,
              size: 35.0,
              color: Colors.white,
            ),
            title: Text('Blog', style: TextStyle(color: Colors.white)),
            onTap: () async {
              Navigator.pop(context);
              if (onTap != null)
                onTap(UploadType.BLOG);
              //_bloc.navigateToUpload(UploadType.BLOG);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            title: Text('Cancel', style: TextStyle(color: Colors.white)),
            onTap: () {
              if (onTap != null)
                onTap(null);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
