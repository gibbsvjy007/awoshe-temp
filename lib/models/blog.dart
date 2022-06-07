import 'package:Awoshe/constants.dart';

class Blog {
  String id;
  String title;
  String description;
  String url;
  List<String> images;
  FeedType feedType;
  String owner;
  String status;

  Blog(
      {this.id,
      this.title,
      this.description,
      this.url,
      this.images,
      this.feedType,
      this.status,
      this.owner});
  Blog.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        description = json['description'],
        url = json['url'],
        status = json['status'],
        owner = json['owner'],
        images = json['images'] != null
            ? json['images'].cast<String>().toList()
            : [],
        feedType = json['feedType'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'url': url,
        'owner': owner,
        'status': status,
        'feedType': feedType,
        'images': images
      };
}
