import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  static const _SIZE_TYPE_NAMES = "sizeTypeNames";
  static const _SIZE_INDEXES_SELECTED = "sizeIndexesSelected";
  static const _SIZE_LOCATION = "sizeLocation";
  static const _SIZE_TEXT = "sizeText";

  /// This is firestore document unique ID
  String id;
  /// This is awoshe item Id generated
  String itemId;
  String title;
  String description;
  String price;
  String owner;
  String status;
  String imageUrl;
  String productCare;
  List<String> images;
  ProductType productType;
  String category;
  List<String> occassions;
  String orderType;
  List<String> availableColors;
  List<String> fabricTags;
  List<String> sizes;
  List<String> customMeasurements;
  String otherInfos;
  String currency;
  int currentSizeIndex;
  String mainCategory, subCategory;
  String collectionName;
  FeedType feedType;
  String firstImageOrientation;
  SizeSelectionInfo availableSizes;


  Product(
      {this.id,
      this.title,
      this.description,
      this.productCare,
      this.productType,
      this.price,
      this.owner,
      this.category,
      this.currency,
      this.imageUrl,
      this.itemId,
      this.occassions,
      this.orderType,
      this.availableColors,
      this.sizes,
      this.fabricTags,
      this.images,
      this.currentSizeIndex,
      this.otherInfos,
      this.customMeasurements,
      this.mainCategory,
      this.collectionName,
      this.subCategory,
      this.feedType,
      this.availableSizes,
      this.status});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  Product.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        description = json['description'],
        price = json['price'],
        status = json['status'] ?? 'active',
        imageUrl = json['imageUrl'],
        itemId = json['itemId'] ?? '',
        productCare = json['productCare'],
        productType = json['productType'],
        category = json['category'],
        occassions = json['occassions'] != null
            ? json['occassions'].cast<String>().toList()
            : [],
        orderType = json['orderType'],
        currentSizeIndex = json['currentSizeIndex'],
        availableColors = json['availableColors'] != null
            ? json['availableColors'].cast<String>().toList()
            : [],
        images= json['images'] != null ? json['images'].cast<String>().toList() : [],
        currency = json['currency'],
        collectionName = json['collectionName'],
        feedType = json['feedType'],
        sizes =
            json['sizes'] != null ? json['sizes'].cast<String>().toList() : [],
        fabricTags = json['fabricTags'] != null
            ? json['fabricTags'].cast<String>().toList()
            : [],
        otherInfos = json['otherInfos'],
        customMeasurements = json['customMeasurements'] != null
            ? json['customMeasurements'].cast<String>().toList()
            : [],
        owner = json['owner'],
        mainCategory = json['mainCategory'],
        firstImageOrientation = json['firstImageorientation'],
        subCategory = json['subCategory'] {

        if (json["sizeTypeNames"] != null) {
          availableSizes = SizeSelectionInfo();
          availableSizes.sizesText = json[_SIZE_TEXT];
          List<String>.from( json[_SIZE_TYPE_NAMES] );

          if ( json[_SIZE_INDEXES_SELECTED] != null )
            availableSizes.addSelectionFromJson(
                Map<String,dynamic>.from(json[_SIZE_INDEXES_SELECTED])
            );
        }
  }


  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'price': price,
        'status': status,
        'currency': currency,
        'mainCategory': mainCategory,
        'subCategory': subCategory,
        'category': category,
        'images' : images,
        'productCare': productCare,
        'productType': productType,
        'occassions': occassions,
        'currentSizeIndex': currentSizeIndex,
        'orderType': orderType,
        'availableColors': availableColors,
        'sizes': sizes,
        'fabricTags': fabricTags,
        'otherInfos': otherInfos,
        'collectionName': collectionName,
        'customMeasurements': customMeasurements,
        'owner': owner,
        'feedType': feedType,
        'firstImageorientation' : firstImageOrientation,
        //_SIZE_LOCATION : availableSizes?.location,
        _SIZE_TYPE_NAMES : availableSizes?.typeNames,
        _SIZE_TEXT : availableSizes?.sizesText,
        _SIZE_INDEXES_SELECTED : availableSizes?.transformSelectionToJson(),
      };

  static List<String> fetchProductImages(String id) {
    List<String> pImages = [];
    if (id != null) {
      Firestore.instance
          .collection("products/$id/images")
          .getDocuments()
          .then((QuerySnapshot _imagesRef) {
        for (int i = 0; i < _imagesRef.documents.length; i++) {
          pImages.add(_imagesRef.documents[i].data['imageUrl']);
        }
      });
    }
    return pImages;
  }
}

class ProductColor {
  final String name;
  final Color code;

  const ProductColor(this.name, this.code);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductColor &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

class Owner {
  String userId;
  String username;
  String photoUrl;

  Owner({this.userId, this.username, this.photoUrl});
  Owner.fromJson(Map<dynamic, dynamic> json)
      : userId = json != null ? json['userId'] : "",
        username = json != null ? json['username'] : "",
        photoUrl = json != null ? json['photoUrl'] : "";
}

class Design {
  String productId;
  String title;
  String imageUrl;
  UploadType uploadType;
  List<String> designImages;

  Design({this.productId, this.title, this.imageUrl});
  Design.fromJson(Map<dynamic, dynamic> json)
      : productId = json != null ? json['productId'] : "",
        title = json != null ? json['title'] : "",
        designImages =
        json['images'] != null && json['images'].length > 0  != null ? json['images'].cast<String>() : <String>[],
        uploadType = json != null
            ? (json['uploadType'] == "DESIGN"
                ? UploadType.DESIGN
                : UploadType.FABRIC)
            : UploadType.DESIGN,
        imageUrl = json['images'] != null && json['images'].length > 0 ? json['images'][0] : "";
}

class Category {
  String id;
  String parent;
  String title;
  String identity;
  String status;

  Category({this.title, this.identity, this.status, this.parent, this.id});
  Category.fromJson(Map<dynamic, dynamic> json)
      : parent = json != null ? json['parent'] : null,
        id = json != null ? json['id'] : "",
        title = json != null ? json['title'] : "",
        identity = json != null ? json['identity'] : "",
        status = json != null ? json['status'] : "";
}