import 'package:Awoshe/components/browser.dart';
import 'package:Awoshe/components/dialog/support_dialog.dart';
import 'package:Awoshe/logic/bloc_helpers/bloc_singleton.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/popupmenuitems.dart';
import 'package:Awoshe/pages/about/about.page.dart';
import 'package:Awoshe/pages/menu/menu.dart';
import 'package:Awoshe/pages/search/search.page.dart';
import 'package:Awoshe/router.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AwosheSliverAppBar extends StatefulWidget {
  final String title;
  final Widget bottom;
  final bool showSearch;
  final bool showSubscriptionMenuOption;
  final List<Widget> actions;
 // final VoidCallback onTap;

  AwosheSliverAppBar({this.title = "Explore", this.bottom,
    this.showSubscriptionMenuOption,
    this.actions,
    this.showSearch = false,});

  @override
  _AwosheSliverAppBarState createState() => _AwosheSliverAppBarState();
}

class _AwosheSliverAppBarState extends State<AwosheSliverAppBar> {
  UserStore userStore;

  @override
  void didChangeDependencies() {
    userStore = Provider.of<UserStore>(context);
    super.didChangeDependencies();
  }

  void choiceAction(String choice) {

    if (choice == Constants.Settings) {
      print('Settings');
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                ),),
                child: child,
              ),
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, _, __) =>
              AwosheBrowser(url: "https://awoshe.com/awoshe")));
        return;
    }

    else if (choice == Constants.about) {
      Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute<bool>(
          fullscreenDialog: true,
          builder: (BuildContext context) => AboutPage(),
        ),
      );
      return;
    }

    else if (choice == Constants.support){
      showDialog(context: context,
        builder: (_) => AwosheSupportDialog(
          onPress: (){},
        ),

      );
      return;
    }

    // else if (choice == Constants.subscription){
    //   Navigator.of(context, rootNavigator: true).push(
    //     CupertinoPageRoute<bool>(
          
    //       fullscreenDialog: true,
    //       builder: (BuildContext context) => AwosheSubscriptionWebPage(
    //         url: 'https://sankara.awoshe.com/pricing',
    //       ),
    //       // builder: (BuildContext context) => AwosheSubscriptionPage(),
    //     ),
    //   );
    //   return;
    // }

  }

  void _openAddMenuDialog() {
    Navigator.of(context, rootNavigator: false).push(
      new MaterialPageRoute<bool>(
        maintainState: true,
        fullscreenDialog: false,
        builder: (BuildContext context) => new AddMenuDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        //backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.5,
        expandedHeight: 38.0,
        floating: true,
        pinned: false,
        forceElevated: true,

        snap: true,

        bottom: widget.bottom ?? null,
        // brightness: Brightness.dark,

        title: new Text(
          widget.title,
          style: new TextStyle(color: awBlack),
        ),
        leading: new IconButton(
          //Color awBlack = const Color.fromRGBO(37,48,56, 1.0);
            icon: const Icon(
              const IconData(0xe905, fontFamily: 'icomoon'),
              color: secondaryColor,
            ),
            onPressed: () {
              _openAddMenuDialog();
            }),

        actions: buildingActions(),
      );
  }

  List<Widget> buildingActions() {
    var action = <Widget>[];
    if (widget.actions != null)
      action.addAll(widget.actions);

    final defaultActions = <Widget>[
      (widget.showSearch == true) ? IconButton(
          icon: SvgPicture.asset(
            Assets.search,
            color: secondaryColor,
            height: 22.0,
            width: 22.0,
          ),
          onPressed: () {
            print("hello world");
            Navigator.of(this.context, rootNavigator: true).push(
              CupertinoPageRoute<bool>(
                fullscreenDialog: true,
                builder: (BuildContext context) => Search(),
              ),
            );
          }): Container(),


      Padding(padding: EdgeInsets.all(3.0)),
      if (!userStore.details.isAnonymous)
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
                  print('hem');
                  AppRouter.router.navigateTo(context, Routes.message);
                },
              ),
              Observer(
                  name: 'message_badge',
                  builder: (BuildContext context) {
                    print("----------------inside message badge observe-------");
                    print(userStore.details.messageCount);
                    print(userStore.details.id);
                    int count = userStore.details.messageCount;
                    if (count > 0) {
                      print("returning widget");
                      return Align(
                        alignment: Alignment(1, -0.3),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                            child: CircleAvatar(
                              radius: 10.0,
                              backgroundColor: primaryColor,
                              child: Text(
                                count.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
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
    ];

    action.addAll( defaultActions);
    return action;
  }
}