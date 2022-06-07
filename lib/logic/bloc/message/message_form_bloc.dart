import 'dart:async';
import 'package:Awoshe/logic/bloc/message/message_event.dart';
import 'package:Awoshe/logic/bloc/message/message_state.dart';
import 'package:Awoshe/logic/services/message_services.dart';
import 'package:Awoshe/models/messages/message.dart';
import 'package:Awoshe/services/validations.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';

class MessageFormBloc extends Bloc<MessageEvent, MessageState> with Validators {

  final MessageService _messageService;
  final String currentUserId;
  final String peerId;
  final BehaviorSubject<List<Message>> _messagesSubject = BehaviorSubject();
  Sink<List<Message>> get addMessages => _messagesSubject.sink;

  MessageFormBloc(this.currentUserId, this.peerId)
      : _messageService = MessageService(currentUserId: currentUserId, peerId: peerId) {
    _messageService.onMessagesChanged.listen(_emitMessages);
  }

  @override
  void dispose() async {
    _messagesSubject.drain().then( (_) => _messagesSubject?.close());
    super.dispose();
  }

  void _emitMessages(List<Message> messages) => _messagesSubject.sink.add(messages);


  Stream<List<Message>> get messages => _messageService.getMessages();

//  @override
//  Stream<MessageState> eventHandler(
//      MessageEvent event, MessageState currentState) async* {
//    if (event.event == MessageEventType.send_message) {
//      yield MessageState.busy();
//      print('Message sent to ${event.receiverName} successfully....');
//      try {
//        Message message = Message(
//            senderId: event.senderId,
//            receiverId: event.receiverId,
//            content: event.content,
//            timestamp: event.timestamp,
//            receiverImage: event.receiverImage,
//            type: event.type,
//            senderName: AuthenticationService.userFullName,
//            receiverName: event.receiverName);
//        List<Message> _message = await _messageService.sendMessage(message);
//        await Future.delayed(const Duration(seconds: 1));
//        yield MessageState.success();
//      } on PlatformException catch (e) {
//        print("BLOC: Message failed.");
//        print(e.message);
//        yield MessageState.failure(e.message);
//      }
//    }
//  }

  @override
  MessageState get initialState => MessageState.noAction();

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event.event == MessageEventType.send_message) {
      yield MessageState.busy();
      print('Message sent to ${event.receiverName} successfully....');

      try {
//        Message message = Message(
//            senderId: event.senderId,
//            receiverId: event.receiverId,
//            content: event.content,
//            timestamp: event.timestamp,
//            receiverImage: event.receiverImage,
//            type: event.type,
//            senderName: AuthenticationService.userFullName,
//            receiverName: event.receiverName);
//        List<Message> _message = await _messageService.sendMessage(message);
        await Future.delayed(const Duration(seconds: 1));
        yield MessageState.success();
      }

      on PlatformException catch (e) {
        print("BLOC: Message failed.");
        print(e.message);
        yield MessageState.failure(e.message);
      }
    }
  }
}
