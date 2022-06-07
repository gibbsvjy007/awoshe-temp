import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/models/messages/message.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class MessageService {
  String content;
  String password;
  String name;
  String currentUserId;
  String _groupChatId;
  String conversationId;
  String peerId;

  MessageService({@required this.currentUserId, this.peerId, this.conversationId}) {
    _groupChatId = conversationId ?? Utils.getGroupChatId(this.currentUserId, this.peerId);
  }
  final BehaviorSubject<List<Message>> _onMessagesChangedSubject =
      BehaviorSubject();
  Stream<List<Message>> get onMessagesChanged =>
      _onMessagesChangedSubject.stream;
  List<Message> _messages = List();

  void disposeChatDetail(String id, String peerId) async {
    _onMessagesChangedSubject.close();
  }

  CollectionReference get _followings =>
      Firestore.instance.collection("profiles/$currentUserId/following");

  CollectionReference get _followers =>
      Firestore.instance.collection("profiles/$currentUserId/followers");
      
  /// get message. limit is set to 20  currently. need to add pagination logic when user starts scrolling
  Stream<List<Message>> getMessages() => Firestore.instance
      .collection('conversations')
      .document(_groupChatId)
      .collection('messages')
      .orderBy('timestamp', descending: true)
      .limit(20)
      .snapshots()
      .asyncMap((QuerySnapshot d) => d.documents
          .map((DocumentSnapshot dt) => _toMessageModel(dt))
          .toList());

  Message _toMessageModel(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data..['id'] = documentSnapshot.documentID;
    return Message.fromJson(data);
  }

//  Conversation _toConversationModel(DocumentSnapshot documentSnapshot) {
//    final data = documentSnapshot.data..['id'] = documentSnapshot.documentID;
//    return Conversation.fromJson(data);
//  }

  Stream<List<DocumentSnapshot>> getFollowingFollowers() =>
      (AppData.isDesigner != null && AppData.isDesigner ? _followers : _followings)
          .snapshots()
          .asyncMap((snap) => snap.documents);

  setGroupChatId(String chatId) {
    _groupChatId = chatId;
  }

  Future<List<Message>> sendMessage(Message message) async {
    try {
//        _groupChatId = Utils.getGroupChatId(this.currentUserId, this.peerId);

      /// adding message to stream before so we dont have delay for listing message in chat window
      _messages.add(message);
      _onMessagesChangedSubject.add(_messages);
      DocumentReference documentReference = Firestore.instance.document(
          'conversations/$_groupChatId/messages/${DateTime.now().millisecondsSinceEpoch.toString()}');
      documentReference.setData(message.toJson());

      /// create conversation document to fetch all the conversation of the user.
      /// it contains the last message, unreadcount etc
//      Conversation _conversation = Conversation(
//        conversationId: _groupChatId,
//        message: message.content,
//        messageType: message.type,
//        receiverImage: message.receiverImage,
//        timestamp: message.timestamp,
//        receiverName: message.receiverName,
//        receiverId: message.receiverId,
//        unReadCount: 0,
//      );
      // _userConversations.document(_groupChatId).setData(_conversation.toJson());

      /// Transaction is not working somehow. I researched a bit and I found that
      /// this is an existing issue of flutter firestore plugin
      /// we have to switch to transaction in future
      ///
      // Firestore.instance.runTransaction((transaction) async {
      //   await transaction.set(
      //     documentReference1,
      //     {'content': 'test'},
      //   );
      // });

    } catch (e) {
      print(e.toString());
    }
    return _messages;
  }
}
