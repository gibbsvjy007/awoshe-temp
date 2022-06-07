import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';


enum ImageOrientation {UNDEFINED,PORTRAIT, LANDSCAPE, SQUARE }

class ImageUtils {

  static ImageOrientation resolveImageOrientation(decodedImage){
    if (decodedImage == null)
      return ImageOrientation.UNDEFINED;

    if (decodedImage.width == decodedImage.height) {
      return ImageOrientation.SQUARE;
    }
    // is landscape
    else if (decodedImage.width > decodedImage.height) {
      return ImageOrientation.LANDSCAPE;
    }
    //portrait
    else {
      //print('portrait defining 3:4');
      return ImageOrientation.PORTRAIT;
    }

  }

  static Future<File> cropImage(File currentImage, {int ratioX, int ratioY}) async {
    var decodedImage;
    if (currentImage == null) return currentImage;


    if (ratioX != null && ratioY != null){
      return ImageCropper.cropImage(
        sourcePath: currentImage.path,
          aspectRatio: CropAspectRatio(ratioX: ratioX.toDouble(),
              ratioY: ratioY.toDouble())
      );
    }

    decodedImage =
    await decodeImageFromList(currentImage.readAsBytesSync());

    if (decodedImage != null) {
      if (decodedImage.width == decodedImage.height) {
        print('Square defining 1:1');
        ratioX = ratioY = 1;
      }
      // is landscape
      else if (decodedImage.width > decodedImage.height) {
        print('landscape image defining 4:3');
        ratioX = 4;
        ratioY = 3;
      } else {
        print('portrait defining 3:4');
        ratioX = 3;
        ratioY = 4;
      }
      return ImageCropper.cropImage(
        sourcePath: currentImage.path,
        aspectRatio: CropAspectRatio(ratioX: ratioX.toDouble(),
            ratioY: ratioY.toDouble()),
      );
    }
    return null;
  }
}