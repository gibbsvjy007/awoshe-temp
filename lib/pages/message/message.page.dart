import 'package:Awoshe/common/sliver_appbar_delegate.dart';
import 'package:Awoshe/logic/stores/message/message_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/message/active/active_users.dart';
import 'package:Awoshe/pages/message/following_followers/following_followers.dart';
import 'package:Awoshe/pages/message/messages/chat_list.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  final UserStore userStore;

  MessagePage({this.userStore});

  @override
  _MessagePageState createState() => new _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  String currentUserId;
  UserStore userStore;

  List<Tab> _messageTabs = <Tab>[
    Tab(
      text: "MESSAGES",
    ),
    Tab(
      text: "ACTIVE",
    )
  ];

  @override
  void initState() {
    super.initState();
    print("___________initMessageBloc______________");
    userStore = Provider.of<UserStore>(context, listen: false);

    _scrollController = ScrollController();
    if (widget.userStore.details.isDesigner) {
      _messageTabs.add(Tab(
        text: "FOLLOWERS",
      ));
    } else {
      _messageTabs.add(Tab(
        text: "FOLLOWING",
      ));
    }
    _tabController = TabController(
      vsync: this,
      initialIndex: 0,
      length: 3,
    );

    /// clear the message count here once page is opened
    userStore.resetMessageCount();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
    _scrollController?.dispose();
  }

  Widget buildSliverAppBar() => SliverAppBar(
        expandedHeight: 38.0,
        pinned: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: secondaryColor),
        centerTitle: false,
        title: Text(
          "Messages",
          style: appBarTextStyle,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _messageTabs.length,
      child: Scaffold(
        //floatingActionButton: AwosheLeftCloseFab(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: buildSliverAppBar(),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      labelColor: primaryColor,
                      controller: _tabController,
                      unselectedLabelColor: awLightColor,
                      indicatorColor: primaryColor,
                      tabs: _messageTabs,
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ChatListScreen(),
                ActiveUsers(),
                MessageFollowingFollowers(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
