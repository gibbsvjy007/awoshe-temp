import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;
  final VoidCallback onSaveExitPressed;

  const UploadAppBar({Key key, @required this.title, this.onBackPressed, this.onSaveExitPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0.5,
      brightness: Brightness.light,
      leading:IconButton(
        icon: Icon(CupertinoIcons.back, color: awBlack,),
        onPressed: onBackPressed,
      ),

      actions: <Widget>[
        (onSaveExitPressed != null) ?
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Center(
            child: InkWell(

              child: Text('Save And Exit', style: TextStyle(color: primaryColor)),
              onTap: onSaveExitPressed,
            ),
          ),
        ) : Container(),
      ],

      title: Text(title, style: TextStyle(color: awBlack)),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(50.0);
}
