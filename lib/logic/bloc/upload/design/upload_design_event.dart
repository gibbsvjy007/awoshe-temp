import 'dart:io';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:equatable/equatable.dart';

import '../../../../constants.dart';

abstract class UploadDesignEvent extends Equatable {
  final UploadDesignEventType event;
  final String title;
  final String description;
  final String productCare;
  final String price;
  final String category;
  final ProductType productType;
  final List<String> fabricOccassion;
  final List<File> images;
  final String orderType;
  final List<String> availableColors;
  final List<String> fabricTags;
  final List<String> sizes;
  final List<String> customMeasurements;
  final String otherInfos;
  final String currency;
  final String id;
  final int currentSizeIndex;
  final String mainCategory;
  final String collectionName;
  final String collectionDescription;
  final String subCategory;
  final FeedType feedType;
  final String orientation;
  final SizeSelectionInfo sizeInfo;
  final int ratioX;
  final int ratioY;

  UploadDesignEvent(
      {this.event,
      this.productType,
      this.fabricOccassion,
      this.title,
      this.description,
      this.productCare,
      this.category,
      this.price,
      this.orderType,
      this.availableColors,
      this.fabricTags,
      this.customMeasurements,
      this.otherInfos,
      this.currentSizeIndex,
      this.sizes,
      this.id,
      this.currency,
      this.mainCategory,
      this.subCategory,
      this.collectionName,
      this.collectionDescription,
      this.images,
      this.feedType,
      this.ratioY,
      this.ratioX,
      this.orientation,
      this.sizeInfo,
      }
      );
}

class UploadDesignEventDesignUpload extends UploadDesignEvent {

  UploadDesignEventDesignUpload(
      {final UploadDesignEventType event,
      final String title,
      final String description,
      final String productCare,
      final String price,
      final String category,
      final List<File> images,
      final String orderType,
      final List<String> availableColors,
      final List<String> fabricOccassion,
      final List<String> fabricTags,
      final List<String> sizes,
      final String otherInfos,
      final String currency,
      final String id,
      final String mainCategory,
      final String subCategory,
      final int currentSizeIndex,
      final String collectionName,
      final String collectionDescription,
      final List<String> customMeasurements,
      final ProductType productType,
      final FeedType feedType,
      final String orientation,
      final int ratioX,
      final int ratioY,
      final SizeSelectionInfo sizeInfo,
      })
      : super(
            event: event,
            images: images,
            productType: productType,
            category: category,
            title: title,
            fabricOccassion: fabricOccassion,
            description: description,
            productCare: productCare,
            mainCategory: mainCategory,
            subCategory: subCategory,
            orderType: orderType,
            otherInfos: otherInfos,
            fabricTags: fabricTags,
            currentSizeIndex: currentSizeIndex,
            customMeasurements: customMeasurements,
            sizes: sizes,
            currency: currency,
            id: id,
            availableColors: availableColors,
            price: price,
            collectionName: collectionName,
            collectionDescription: collectionDescription,
            feedType: feedType,
            ratioY: ratioY,
            ratioX: ratioX,
            orientation: orientation,
            sizeInfo : sizeInfo,
  );
}

enum UploadDesignEventType {
  none,
  upload_design,
  custom_standard_order,
  update_product,
  create_collection
}
