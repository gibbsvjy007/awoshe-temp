
import 'package:Awoshe/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum BlogBlocEvents {INIT, UPLOAD, UPDATE, READ, READ_ALL, DELETE }

abstract class BlogBlocEvent extends Equatable {
  final BlogBlocEvents eventType;
  BlogBlocEvent(this.eventType);
}

class BlogBlocUpload extends BlogBlocEvent {
  final String userId;
  final String title;
  final String description;
  final String url;
  final List<String> images;
  final String category;
  final FeedType feedType;
  final String status;
  final String handle;
  final String name;
  final String thumbnailUrl;

  BlogBlocUpload({@required this.userId, this.title, this.description, this.url, this.images,
      this.category, this.name, this.handle, this.thumbnailUrl, this.feedType, this.status}) : super(BlogBlocEvents.UPLOAD);
}

class BlogBlocUpdate extends BlogBlocEvent {
  final String userId;
  String id;
  String title;
  String description;
  String url;
  List<String> images;
  String category;
  String owner;
  final FeedType feedType;
  String status;
  final String handle;
  final String name;
  final String thumbnailUrl;
  //Creator creator;
  //int createdOn;

  BlogBlocUpdate({@required this.userId, this.id, this.title, this.description,
    this.url, this.images, this.category, this.name,this.handle,
    this.thumbnailUrl ,this.feedType, this.owner, this.status}) : super(BlogBlocEvents.UPDATE);
}

class BlogBlocDelete extends BlogBlocEvent {
  final String id;
  final String userId;
  BlogBlocDelete({@required this.userId, @required this.id}) : super(BlogBlocEvents.DELETE);
}

class BlogBlocRead extends BlogBlocEvent {
  final String id;
  final String userId;
  BlogBlocRead({ @required this.userId, @required this.id}) : super(BlogBlocEvents.READ);
}

class BlogBlocReadAll extends BlogBlocEvent {
  final String userId;
  BlogBlocReadAll({@required this.userId}) : super(BlogBlocEvents.READ_ALL);
}
