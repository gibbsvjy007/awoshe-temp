import 'dart:io';

import 'package:Awoshe/logic/api/blog_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/blog/blog.dart';
import 'package:Awoshe/services/storage.service.dart';
import 'package:flutter/foundation.dart';

class BlogServiceV2 {


  /// This method creates and upload a new blog.
  ///
  /// [userId] The current userId
  /// [blog] The blog model object to be uploaded.
  Future<Blog> create({@required String userId, @required Blog blog}) async {
    try {
      var localImages = blog.images;
      blog.images = null;

      RestServiceResponse resp = await BlogApi.create(
          userId: userId, data: blog.toJson()
      );

      blog.id = resp.content['id'];

      if (localImages != null || localImages.isNotEmpty){
        StorageService.uploadDesignImages(localImages.map<File>( (i) =>File(i) ).toList(), userId)
            .then( (networkImages){
          blog.images = networkImages;
          print('__ UPDATING BLOG IMAGES __');
          BlogApi.update(userId: userId, blogId: blog.id, data: {
            'id': blog.id,
            'images': networkImages,
            'imageUrl': networkImages[0],

          });
        } );
      }
      return blog;
    }
    catch(ex){
      throw ex;
    }
  }

  /// This method gets a specific blog using the blog id as reference.
  ///
  /// [userId] The current user id.
  /// [blogId] The blog resource reference.
  Future<Blog> getBlogById({@required String userId, @required String blogId}) async {
    try {
      RestServiceResponse resp = await BlogApi.read(userId: userId, blogId: blogId);
      return Blog.fromJson( resp.content );
    }
    catch(ex){
      throw ex;
    }
  }

/// TODO need handling the images changes
  Future<void> update({@required String userId, @required Blog blog}) async {
    try {

      var urls = await StorageService.uploadDesignImages(
          blog.images.map( (img) => File(img)  ).toList(), userId
      );

      blog.images = urls;

      await BlogApi.update(userId: userId,
            blogId: blog.id, data: blog.toJson());
      return;
    }
    catch(ex){
      throw ex;
    }
  }

  /// This method delete a blog on database;
  ///
  /// [userId] The current user id.
  /// [blogId] The resource id to be deleted.
  Future<void> delete({@required String userId, @required String blogId}) async {
    try {
      await BlogApi.delete(userId: userId, blogId: blogId);
    }
    catch(ex){
      throw ex;
    }
  }

  /// This method fetches all blog posts available.
  ///
  /// [userId] The current user id.
  Future<List<Blog>> getAll({@required String userId}) async {
    try {
      RestServiceResponse resp = await BlogApi.readAll(userId: userId);
      List<dynamic> dataList = List.from(resp.content);
      return dataList.map<Blog>( (json) => Blog.fromJson(json) ).toList();
    }
    catch(ex){
      throw ex;
    }
  }
}

