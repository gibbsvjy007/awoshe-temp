import 'dart:io';
import 'package:Awoshe/constants.dart';
import 'package:equatable/equatable.dart';

abstract class UploadBlogEvent extends Equatable {
  final UploadBlogEventType event;
  final String title;
  final String description;
  final List<File> images;
  final String url;
  final String id;
  final FeedType feedType;
  final String owner;

  UploadBlogEvent(
      {this.event,
      this.title,
      this.description,
      this.id,
      this.owner,
      this.images,
      this.feedType,
      this.url});
}

class UploadBlogEventDesignUpload extends UploadBlogEvent {
  UploadBlogEventDesignUpload(
      {final UploadBlogEventType event,
      final String title,
      final String description,
      final List<File> images,
      final String url,
      final String id,
      final String owner,
      final FeedType feedType})
      : super(
            event: event,
            images: images,
            title: title,
            description: description,
            url: url,
            id: id,
            owner: owner,
            feedType: feedType);
}

enum UploadBlogEventType {
  none,
  upload_blog,
  update_blog
}
