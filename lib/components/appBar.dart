import 'package:Awoshe/components/browser.dart';
import 'package:Awoshe/components/dialog/support_dialog.dart';
import 'package:Awoshe/logic/bloc_helpers/bloc_singleton.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/popupmenuitems.dart';
import 'package:Awoshe/pages/about/about.page.dart';
import 'package:Awoshe/pages/menu/menu.dart';
import 'package:Awoshe/router.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AwosheAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool hideActions;
  final bool center;

  //passing props in the Constructor.
  //Java like style
  AwosheAppBar(
      {Key key, this.title, this.hideActions = false, this.center = false})
      : super(key: key);

  @override
  _AwosheAppBarState createState() => _AwosheAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(54.0);
}

class _AwosheAppBarState extends State<AwosheAppBar> {
  @override
  Widget build(BuildContext context) {

    var isDesigner = Provider.of<UserStore>(context).details.isDesigner;
    
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0.5,

      brightness: Brightness.light,
      title: widget.center
          ? Center(
              child: Text(widget.title, style: TextStyle(color: awBlack)),
            )
          : Text(widget.title, style: TextStyle(color: awBlack)),
      leading: widget.hideActions
          ? null
          : IconButton(
              //Color awBlack = const Color.fromRGBO(37,48,56, 1.0);
              icon: const Icon(
                const IconData(0xe905, fontFamily: 'icomoon'),
                color: secondaryColor,
              ),
              onPressed: () {
                _openAddMenuDialog();
              }),
      actions: widget.hideActions
          ? null
          : <Widget>[
              (isDesigner) ? IconButton(
                  icon: SvgPicture.asset(
                    Assets.search,
                    color: secondaryColor,
                    height: 22.0,
                    width: 22.0,
                  ),
                  onPressed: () {
                    print("hello world");
                  }) : Container(),

              Padding(padding: EdgeInsets.all(3.0)),
              Stack(
                  alignment: Alignment.centerRight,
                  fit: StackFit.loose,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset(
                        Assets.message,
                        color: secondaryColor,
                        height: 24.0,
                        width: 24.0,
                      ),
                      onPressed: () {
                        AppRouter.router.navigateTo(context, Routes.message);
                      },
                    ),
                    StreamBuilder<int>(
                        stream: globalBloc.unreadMessageCountStream,
                        initialData: 0,
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          if (snapshot.data != null && snapshot.data > 0) {
                            return Align(
                              alignment: Alignment(0.3, -0.4),
                              child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    radius: 8.0,
                                    backgroundColor: primaryColor,
                                    child: Text(
                                      snapshot.data.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ]),
              PopupMenuButton<String>(
                offset: Offset(0.0, 36.0),
                onSelected: choiceAction,
                icon: Icon(
                  Icons.more_vert,
                  color: secondaryColor,
                ),
                elevation: 0.5,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
    );
    /*
      backgroundColor: const Color(0xFFFFFFFF),
      centerTitle: false,
      elevation: 0.5,
      brightness: Brightness.light,
      title: Text(
        widget.title ?? '',
        style: TextStyle(color: awBlack),
      ),
      leading: IconButton(
          //Color awBlack = const Color.fromRGBO(37,48,56, 1.0);
          icon: const Icon(
            const IconData(0xe905, fontFamily: 'icomoon'),
            color: secondaryColor,
          ),
          onPressed: () {
            _openAddMenuDialog();
          }),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              IconData(0xe988, fontFamily: 'icomoon'),
              color: awLightColor,
              size: 20.0,
            ),
            onPressed: () {
              print("hello world");
            }),
        Padding(padding: EdgeInsets.all(3.0)),
        IconButton(
          icon: const Icon(
            const IconData(
              0xe904,
              fontFamily: 'icomoon',
            ),
            color: secondaryColor,
            size: 22.0,
          ),
          onPressed: () {
            AppRouter.router.navigateTo(context, Routes.message);
          },
        ),
        PopupMenuButton<String>(
          offset: Offset(0.0, 36.0),
          onSelected: choiceAction,
          icon: Icon(
            Icons.more_vert,
            color: secondaryColor,
          ),
          elevation: 0.5,
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );*/
  }

  void _openAddMenuDialog() {
//    Navigator.of(context).userGestureInProgress(MaterialPageRoute<Null>(
//      maintainState: true,
//        builder: (BuildContext context) {
//          return AddEntryDialog();
//        },
//        fullscreenDialog: true
//
//    ));

    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        fullscreenDialog: true,
        builder: (BuildContext context) => AddMenuDialog(),
      ),
    );
  }

//  void _openSelectCat() {
//    Navigator.of(context).userGestureInProgress(MaterialPageRoute<Null>(
//      maintainState: true,
//        builder: (BuildContext context) {
//          return AddEntryDialog();
//        },
//        fullscreenDialog: true
//
//    ));

//    Navigator.of(context, rootNavigator: true).push(
//      CupertinoPageRoute<bool>(
//        fullscreenDialog: true,
//        builder: (BuildContext context) => SelectCat(),
//      ),
//    );
//  }

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      print('Settings');
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AwosheBrowser(url: "https://awoshe.com/awoshe")));
    } else if (choice == Constants.about) {
      Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute<bool>(
          fullscreenDialog: true,
          builder: (BuildContext context) => AboutPage(),
        ),
      );
    } else if (choice == Constants.support)
      showDialog(context: context,
        builder: (_) => AwosheSupportDialog(
          onPress: (){},
        ),
      );
    /*else if (choice == Constants.Subscribe) {
      print('Subscribe');
    } else if (choice == Constants.SignOut) {
      print('SignOut');
      _openSelectCat();
    }*/
  }
}

class AwosheSimpleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool hideActions;
  final bool center;
  @override
  Size get preferredSize => Size.fromHeight(50.0);
  //passing props in the Constructor.
  //Java like style
  AwosheSimpleAppBar(
      {Key key, this.title, this.hideActions = false, this.center = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0.5,
      brightness: Brightness.light,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back_ios, color: awBlack,),
      ),
      title: center
          ? Center(
              child: Text(title, style: TextStyle(color: awBlack)),
            )
          : Text(title, style: TextStyle(color: awBlack)),
    );
  }
}
