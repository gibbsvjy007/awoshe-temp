import 'package:cloud_firestore/cloud_firestore.dart';

class UserNotification {

  String _id;

  static const String _ACTIVITY = "activity";
  static const String _ACTOR = "actor";
  static const String _CONTENT = "content";
  static const String _CREATED_AT = "createdAt";

  String content;
  String activity;
  String actor;
  Timestamp createdAt;

  String get id => _id;

  UserNotification(this.content, this.activity, this.actor,
      this.createdAt);

  UserNotification.fromDocument(final DocumentSnapshot document) :
      _id = document.documentID,
      content = document.data[_CONTENT],
      activity = document.data[_ACTIVITY],
      actor = document.data[_ACTOR],
      createdAt = document.data[_CREATED_AT];

  Map<String, dynamic> toJson() => {
    _ACTIVITY : activity,
    _ACTOR : actor,
    _CREATED_AT : createdAt,
    content : content,
  };

}