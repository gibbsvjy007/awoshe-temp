import 'package:Awoshe/logic/bloc_helpers/bloc_provider.dart';
import 'package:Awoshe/logic/services/message_services.dart';
import 'package:Awoshe/services/validations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class MessageBloc with Validators implements BlocBase {
  MessageBloc(this.currentUserId)
      : _messageService = MessageService(currentUserId: currentUserId);

  final MessageService _messageService;
  final String currentUserId;
  final BehaviorSubject<String> _searchController = BehaviorSubject<String>();

  Stream<DocumentSnapshot> userProfile(final String targetId) {
    return Firestore.instance
        .document("profiles/" + targetId)
        .snapshots();
  }

  Stream<List<DocumentSnapshot>> get followingFollowers =>
      _messageService.getFollowingFollowers();
//
//  Stream<List<Conversation>> get conversations =>
//      _messageService.getConversations();

  /// Search output
  Stream<String> get searchText =>
      _searchController.stream.transform(validateSearch);

  /// Search messages inpput here
  Function(String) get changeSearch => _searchController.sink.add;

  @override
  void dispose() {
    _searchController.close();
  }
}

abstract class MessageBlocAbstract {
  Function(String) get changeSearch;

  Stream<String> get searchText;

  void dispose();
}
