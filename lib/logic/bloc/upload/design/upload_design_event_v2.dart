import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum UploadDesignBlocEventType { UPLOAD, UPDATE, READ, DELETE, INIT}

abstract class UploadDesignBlocEventV2 extends Equatable {
  final UploadDesignBlocEventType eventType;
  
  final String title;
  final String description;
  final String price;
  final String owner;
  final String status;
  final String imageUrl;
  final String productCare;
  final List<String> images;
  final ProductType productType;
  final String category;
  final List<String> occassions;
  final String orderType;
  final List<String> availableColors;
  final List<String> fabricTags;
  final List<String> sizes;
  final List<String> customMeasurements;
  final String otherInfos;
  final String orientation;
  final String currency;
  final int currentSizeIndex;
  final String mainCategory, subCategory;
  final String collectionName;
  final FeedType feedType;
  final String firstImageOrientation;
  final SizeSelectionInfo sizesInfo;

  UploadDesignBlocEventV2(this.eventType, {this.title, this.description, 
    this.price, this.owner, this.status, this.productCare, this.productType, 
    this.category, this.occassions, this.sizesInfo, this.orderType, this.availableColors,
    this.fabricTags, this.sizes, this.customMeasurements, this.otherInfos, 
    this.currency, this.currentSizeIndex, this.mainCategory, this.subCategory, 
    this.collectionName, this.feedType, this.firstImageOrientation, this.imageUrl, 
    this.images, this.orientation});
}

//abstract class UploadDesignBlocEventProductUpload extends UploadDesignBlocEventV2{
//  UploadDesignBlocEventProductUpload(UploadDesignBlocEventType eventType) : super(eventType);
//}

//class UploadDesignBlocEventValidateCollection extends UploadDesignBlocEventV2{
//  UploadDesignBlocEventValidateCollection()
//      : super(UploadDesignBlocEventType.VALIDATION);
//}

//class UploadDesignBlocEventValidateProduct extends UploadDesignBlocEventV2{
//  UploadDesignBlocEventValidateProduct() : super(UploadDesignBlocEventType.VALIDATION);
//}

class UploadDesignBlocEventUpload extends UploadDesignBlocEventV2 {
  final String userId;
  UploadDesignBlocEventUpload({@required this.userId, String title,
      String description, String price, String owner, String status, 
      String productCare, ProductType productType,SizeSelectionInfo sizesInfo,
      String category, List<String> occassions, String orderType, 
      List<String> availableColors, List<String> fabricTags, List<String> sizes, 
      List<String> customMeasurements, String otherInfos, String currency, 
      int currentSizeIndex, String mainCategory, String subCategory, 
      String collectionName, FeedType feedType, String firstImageOrientation,
      String imageUrl, List<String> images, String orientation}) :
        
        super(UploadDesignBlocEventType.UPLOAD, title: title, description : description,
          price: price ,owner:owner, status:status, productCare: productCare, 
          productType:productType, category:category, occassions : occassions, 
          orderType:orderType, availableColors:availableColors, fabricTags:fabricTags, 
          sizes:sizes, customMeasurements:customMeasurements, otherInfos:orderType,
          currency:currency, currentSizeIndex: currentSizeIndex, mainCategory:mainCategory,
          subCategory:subCategory, collectionName:collectionName, feedType:feedType, 
          firstImageOrientation: firstImageOrientation, sizesInfo: sizesInfo,
          imageUrl: imageUrl, images:images, orientation: orientation);
}

class UploadDesignBlocEventUpdate extends UploadDesignBlocEventV2{
  final String id;
  final String userId;
  String itemId;

  UploadDesignBlocEventUpdate({@required this.id, @required this.userId, this.itemId, String title,
      String description, String price, String owner, String status,
      String productCare, ProductType productType, String category,
    List<String> occassions, String orderType, List<String> availableColors, 
    List<String> fabricTags, List<String> sizes, List<String> customMeasurements, 
    String otherInfos, String currency, int currentSizeIndex, String mainCategory, 
    String subCategory, String collectionName, FeedType feedType, SizeSelectionInfo sizesInfo,
    String firstImageOrientation, String imageUrl, List<String> images, String orientation} ) :
      
        super(UploadDesignBlocEventType.UPDATE, title: title, description : description,
          price: price ,owner:owner, status:status, productCare: productCare,
          productType:productType, category:category, occassions : occassions,
          orderType:orderType, availableColors:availableColors, fabricTags:fabricTags,
          sizes:sizes, customMeasurements:customMeasurements, otherInfos:orderType,
          currency:currency, currentSizeIndex: currentSizeIndex, mainCategory:mainCategory,
          subCategory:subCategory, collectionName:collectionName, feedType:feedType,
          firstImageOrientation: firstImageOrientation, sizesInfo: sizesInfo,
          imageUrl: imageUrl, images:images, orientation: orientation);
}

class UploadDesignBlocEventRemove extends UploadDesignBlocEventV2{
  final String productId;
  final String userId;
  UploadDesignBlocEventRemove({@required this.productId, this.userId} )
      : super(UploadDesignBlocEventType.DELETE);
}

class UploadDesignBlocEventProductRead extends UploadDesignBlocEventV2{
  final String productId;
  final String userId;

  UploadDesignBlocEventProductRead({@required this.productId, @required this.userId} )
      : super(UploadDesignBlocEventType.READ);
}

class UploadDesignBlocEventCollectionRead extends UploadDesignBlocEventV2{
  final String userId;

  UploadDesignBlocEventCollectionRead({@required this.userId} )
      : super(UploadDesignBlocEventType.READ);
}

class UploadDesignBlocEventUploadCollection extends UploadDesignBlocEventV2{
  final String userId;
  final String description;
  final String title;
  final FeedType displayType;
  final String orientation;
  final int ratioX, ratioY;

  UploadDesignBlocEventUploadCollection(UploadDesignBlocEventType eventType,
    {this.userId, this.description, this.title, this.displayType,
      this.orientation, this.ratioX, this.ratioY}) : super(eventType);
}
