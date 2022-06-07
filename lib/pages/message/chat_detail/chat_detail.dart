import 'package:Awoshe/logic/bloc/message/message_form_bloc.dart';
import 'package:Awoshe/logic/stores/chat/chat_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/messages/message.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/pages/message/chat_detail/chat_input.dart';
import 'package:Awoshe/pages/message/chat_detail/received_message.dart';
import 'package:Awoshe/pages/message/chat_detail/sent_message.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/shared/infinite_list_view.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ChatDetail extends StatefulWidget {
  final String chatId;
  final User receiver;
  final UserStore userStore;
  ChatDetail({Key key, this.chatId, this.receiver, this.userStore}) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  bool isLoading = false;
  String groupChatId = "";
  String currentUserId = "";
  String peerId = "";
  ScrollController _listScrollController;
  MessageFormBloc messageFormBloc;
  List<Message> messageList;
  bool expanded = false;
  static double inputHeight = 80.0;
  double bottomHeight = 80.0;
  ChatStore chatStore;
  IconData fullscreen = CupertinoIcons.fullscreen;
  UserStore userStore;
  bool _fetchingMore = false;

  @override
  void initState() {
    super.initState();
    chatStore = ChatStore();
    chatStore.setChatId(widget.chatId);
    chatStore.setReceiver(widget.receiver);
    chatStore.subscribeToChat(chatId: widget.chatId);
    userStore = widget.userStore;
    print("__________________CHAT Initiated__________________________");
    print(widget.chatId);
    initialize();
    _listScrollController = ScrollController(initialScrollOffset: 0.0);
  }

  void initialize() async {
    await chatStore.fetchChatMessages();
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollController?.dispose();
//    chatStore?.dispose();
  }

  scrollToBottom() {
    ScrollPosition scrollPosition = _listScrollController.position;
    if (scrollPosition.pixels > scrollPosition.maxScrollExtent) {
      _listScrollController.animateTo(
        scrollPosition.maxScrollExtent,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onEndReached() async {
    if (chatStore.allMessagesFetched) return;
    if (!_fetchingMore) {
      if (!chatStore.loading && chatStore.messages.isEmpty) return;
      _fetchingMore = true;
      await chatStore.fetchChatMessages(userId: userStore.details.id);
      _fetchingMore = false;
    }
  }

  Widget buildListMessage() => Flexible(
        fit: FlexFit.loose,
        flex: 1,
        child: Observer(
            builder: (context) {
              if (chatStore.loading && !_fetchingMore)
                return AwosheLoadingV2();

              if (!chatStore.loading && chatStore.messages.isEmpty)
                return emptyChat();

              /// set the current message list
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                this.scrollToBottom();
              });

              return Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: InfiniteListView(
                    listPadding: EdgeInsets.all(8.0),
                    itemCount: chatStore.messages.length,
                    scrollController: _listScrollController,
                    endOffset: 250.0,
                    reverse: true,
                    onEndReached: _onEndReached,
                    itemBuilder: (context, index) {
                      final Message message = chatStore.messages[index];

                      print(widget.userStore.details.id == message.sender.id);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),

                        child: widget.userStore.details.id == message.sender.id

                            ? Provider<ChatStore>(
                                builder: (_) => chatStore,
                                child: SentMessage(message: message,),
                            )

                            : Provider<ChatStore>(
                                builder: (_) => chatStore,
                                child: ReceivedMessage(message: message,),
                            ),
                      );
                    }),
              );
            }),
      );

  Widget emptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgIcon(Assets.emptyChat, size: 150.0),
          SizedBox(height: 20.0),
          Text(
            "No conversation",
            style: TextStyle(fontSize: 18.0, color: awLightColor),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: secondaryColor),
        title: Text(
          StringUtils.capitalize(widget.receiver.name),
          style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          /// List of messages
          buildListMessage(),

          Container(
                padding: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: awLightColor300, width: 1.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, top: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          if (expanded) {
                            setState(() {
                              expanded = false;
                              inputHeight = 80.0;
                              fullscreen = CupertinoIcons.fullscreen;
//                              this.scrollToBottom();
                            });
                          } else {
                            setState(() {
                              expanded = true;
                              fullscreen = CupertinoIcons.fullscreen_exit;
                              inputHeight =
                                  MediaQuery.of(context).size.height * 0.3;
                            });
                          }
                        },
                        child: Icon(
                          fullscreen,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    ChatInputWidget(height: inputHeight, chatStore: chatStore),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                )),

        ],
      ),
    );
  }
}
