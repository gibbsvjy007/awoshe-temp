import 'dart:io';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/api/product_api.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/services/storage.service.dart';
import 'package:flutter/foundation.dart';

/// This service class provide us operations to:
///
/// CREATE a new product.
/// READ a product by id.
/// UPDATE an existent product.
/// DELETE a specific product.
///
class UploadServiceV2 {

  /// Creates the new product on database.
  Future<Product> create(Product product, String userId) async {
    var images = product.images;
    print('user creating $userId');
    product.images = null;
    try {
      var response = await ProductApi.create(productData: product?.toJson(), userId: userId);
      product.id = response.content['id'];

      // has images, upload them
      if (images != null && images.isNotEmpty){
        print('Uploading images..');
        var urls = await StorageService.uploadDesignImages(
            images.map( (img) => File(img)  ).toList(), userId
        );

        // after image upload, update the product with image urls
        if (urls !=null && urls.isNotEmpty) {
          product.images = urls;
          print('Update product (${product.id}) images $urls');
          // updating the product with the images URL's
          ProductApi.update(
              productId: product.id,
              productData: {'images': urls},
              userId: userId);
        }
      }

      return product;
    }
    catch (ex){
      throw ex;
    }
  }

  /// Updates the product on database
  Future<void> update(Product product, String userId) async {
    try {
      var urls = await StorageService.uploadDesignImages(
          product.images.map( (img) => File(img)  ).toList(), userId
      );
      product.images = urls;
      return await ProductApi.update(productId: product.id, productData: product?.toJson(), userId: userId);
    }
    catch (ex){
      throw ex;
    }
  }

  /// Remove the product from database.
  Future<void> delete(String productId, String userId) async {
    try {
      return ProductApi.delete(productId: productId, userId: userId);
    }
    catch (ex){
      throw ex;
    }
  }

  /// Read a product from database.
  Future<Product> read(String productId, String userId) async {
    try {
      var response = await ProductApi.read(productId: productId, userId: userId);
      return Product.fromJson(response.content);
    }
    catch (ex){
      throw ex;
    }
  }


  /// This methods reads user products by product type.
  /// [userId] The current user id
  /// [type] The product type.
  Future<List<Product>> getProductsByType({@required String userId,
    @required ProductType type, int page = 0, int limit = 10}) async {
    try {
      var response = await ProductApi
          .getProductsByType(userId: userId,
          type: type.index, page: page, limit: limit);

      return List.from(response.content).map<Product>(
              (json) => Product.fromJson(json)).toList();
    }

    on Exception catch (ex) {
      print('UploadServiceV2::getProductsByType $ex');
      throw(ex);
    }
  }
}