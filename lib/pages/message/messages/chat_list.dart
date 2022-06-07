import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/message/message_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/messages/chat.dart';
import 'package:Awoshe/pages/message/chat_detail/chat_detail.dart';
import 'package:Awoshe/pages/message/messages/chat_item.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/shared/infinite_list_view.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  ChatListScreen({Key key}) : super(key: key);

  @override
  ChatListScreenState createState() {
    return ChatListScreenState();
  }
}

class ChatListScreenState extends State<ChatListScreen> {
  String searchText = "";
  List<Chat> conversationList = <Chat>[];
  TextEditingController searchTextController;
  ScrollController scrollController;
  MessageStore messageStore;
  UserStore userStore;
  bool _fetchingMore = false;

  void initialize() async {
    messageStore.fetchUserChats(userId: userStore.details.id);
  }

  @override
  void initState() {
    messageStore = Provider.of<MessageStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);
    searchTextController = TextEditingController();
    scrollController = ScrollController();
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController?.dispose();
    scrollController?.dispose();
  }

  filterChat(String query) {
    searchText = query;
  }

  Widget noChat() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 100.0),
            SvgIcon(Assets.emptyChat, size: 150.0),
            SizedBox(height: 20.0),
            Text(
              "No Conversation available",
              style: TextStyle(fontSize: 18.0, color: awLightColor),
            )
          ],
        ),
      );

  void _onEndReached() async {
    if (messageStore.allChatsFetched)
      return;

    if (!_fetchingMore) {
      if (!messageStore.loading && messageStore.chats.isEmpty) return;
      _fetchingMore = true;
      await messageStore.fetchUserChats(userId: userStore.details.id);
      _fetchingMore = false;
    }
  }

  Widget buildChatList() => Observer(
        name: 'conversation_list',
        builder: (BuildContext context) {

          print(messageStore.chats.length);

          if (messageStore.loading && !_fetchingMore) return AwosheLoadingV2();

          if (!messageStore.loading && messageStore.chats.isEmpty)
            return noChat();

          return InfiniteListView(
              listPadding: EdgeInsets.all(8.0),
              itemCount: messageStore.chats.length,
              scrollController: scrollController,
              endOffset: 50.0,
              onEndReached: _onEndReached,
              itemBuilder: (context, index) {
                final Chat chat = messageStore.chats[index];
//                if (chat.messageType == MessageType.REVIEW)
//                  return Container();

                return ChatItem(
                    currentUserId: userStore.details.id,
                    chat: chat,
                    onTap:() =>
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => ChatDetail(
                              chatId: chat.chatId,
                              userStore: userStore,
                              receiver: chat.receiver
                          ),
                        ),
                      ),
                );

              });
        },
      );

  Widget searchField() => Container(
        padding: EdgeInsets.only(top: 25.0, right: 20.0, left: 20.0),
        child: InputFieldV2(
            hintText: Localization.of(context).search + "..",
            obscureText: false,
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.emailAddress,
            textStyle: textStyle,
            textFieldColor: textFieldColor,
            fillColor: awLightColor300,
            bottomMargin: 5.0,
            controller: searchTextController,
//            maxLines: 1,
            suffixIcon: (searchText != null && searchText != "")
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    iconSize: 20.0,
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      searchText = "";
                      searchTextController.clear();
                      setState(() {});
                    },
                  )
                : Container(
                    height: 15.0,
                    width: 20.0,
                  ),
            onChanged: filterChat,
            verticalPadding: 5.0,
            leftPadding: 20.0),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        searchField(),
        // SizedBox(height: 10.0),
        Expanded(child: buildChatList())
      ],
    );
  }

}
