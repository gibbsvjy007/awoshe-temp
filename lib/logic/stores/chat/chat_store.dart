import 'dart:async';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/api/message_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/ChatMessageCacheStore.dart';
import 'package:Awoshe/models/messages/message.dart';
import 'package:Awoshe/models/offer/Offer.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

const int MESSAGES_FETCH_LIMIT = 15;
abstract class _ChatStore with Store {
  bool initChat = true;

  @observable
  String chatId;

  @observable
  bool loading = false;

  @observable
  bool allMessagesFetched = false;

  User receiver;
  int fetchMessagePage = 0;

  @observable
  ObservableList<Message> messages = ObservableList<Message>();
  StreamSubscription<QuerySnapshot> _chatSubscription;

  @observable
  ObservableMap<String, Offer> offersCache = ObservableMap();

  @action addOffer(String offerId, Offer offer ) =>
      offersCache.putIfAbsent(offerId, () => offer);

  @action removeOffer(String offerId) => offersCache.remove(offerId);

  @action
  void setLoading(bool l) {
    loading = l;
  }

  void setChatId(String c) {
    chatId = c;
  }

  void setReceiver(User u) {
    receiver = u;
  }

  @action
  void setMessages(List<Message> l) {
    messages.addAll(l);
  }

  Future<void> fetchChatMessages({String userId}) async {
    print("fetching messages");
    setLoading(true);
    try {
      RestServiceResponse response = await MessageApi.fetchChatMessages(userId: userId, chatId: chatId, page: fetchMessagePage, limit: MESSAGES_FETCH_LIMIT);
      if (response.success) {
        final List<Message> allMessages = response.content.map<Message>((m) {
          print(m);
          return Message.fromJson(m);
        }).toList();
        setMessages(allMessages);
        fetchMessagePage++;
        if (allMessages.length < MESSAGES_FETCH_LIMIT) {
          allMessagesFetched = true;
        }
      }
      setLoading(false);
      initChat = false;
    } catch (e) {
      print(e);
      setLoading(false);
    }

  }

  Future<void> sendMessage(
      {String message, MessageType type, String userId}) async {
    print('$userId is sending message to ${receiver.id}');
    initChat = false;
    await MessageApi.sendMessage(
        chatId: chatId,
        message: message,
        receiver: receiver,
        userId: userId,
        type: type
    );
  }

  StreamSubscription<QuerySnapshot> subscribeToChat({String chatId}) {
    print('subscribeToChat start');
    _chatSubscription = MessageApi.listenForMessage(chatId: chatId).listen(newMessageListner);
    return _chatSubscription;
  }

  void unSubscribeToChat() {
    _chatSubscription?.cancel();
  }

  void newMessageListner(final QuerySnapshot querySnapshot) async {
    print('newMessageListner ${querySnapshot.documents.length}');
    DocumentChange change = querySnapshot.documentChanges.elementAt(0);
    if (change.type == DocumentChangeType.modified || change.type == DocumentChangeType.added) {
      print('Message added: ');
      print(change.document.data);
      print(change.document.metadata.hasPendingWrites);
      Map<String, dynamic> data = change.document.data;
      Message chatMsg = Message.fromJson(data);
      print(chatMsg.toJson());
      if (!initChat) {
        messages.insert(0, chatMsg);
        // caching only the latest 15 messages.
        var data = messages.sublist(0, 15).map((map) => map.toJson()).toList();

        ChatMessageCacheStore.instance.setData(data: data,chatId: chatId);
      }
    }
  }
}
