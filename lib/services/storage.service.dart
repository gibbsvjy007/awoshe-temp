import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageService {

  /// This method upload a picture profile for [userId] in firestore.
  /// [image] Image picture file.
  /// [userId] user id.
  static Future<String> uploadUserProfileImage(final File image, final String userId) async {
    String url;

    if (image != null) {
      try {
        var ref = FirebaseStorage.instance
            .ref().child('images/').child('/profileimages')
            .child('/$userId').child('profile_$userId.jpg');

        StorageUploadTask uploadTask = ref.putFile(image);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        url = await storageTaskSnapshot.ref.getDownloadURL();
      }

      on Exception catch (ex) {
        print('StorageService::uploadUserProfileImage $ex');
      }
    }

    return url;
  }

  static Future<String> uploadUserCoverProfileImage(final File image, final String userId) async {
    String url;

    if (image != null) {
      try {
        var ref = FirebaseStorage.instance
            .ref().child('images/').child('/profileimages')
            .child('/$userId').child('cover_$userId.jpg');

        StorageUploadTask uploadTask = ref.putFile(image);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        url = await storageTaskSnapshot.ref.getDownloadURL();
      }

      on Exception catch (ex) {
        print('StorageService::uploadUserCoverProfileImage $ex');
      }
    }

    return url;
  }

  static Future<Null> pickImage(ImageSource source, String photoType, userId,
      BuildContext context, Function callBack) async {
    File _imageFile;
    final basePath =
    photoType == 'COVER' ? 'images/coverimages' : 'images/profileimages';
    try {
      _imageFile = await ImagePicker.pickImage(source: source);
      StorageReference ref = FirebaseStorage.instance
          .ref()
          .child(basePath + '/' + userId  + '.jpg');
      StorageUploadTask uploadTask = ref.putFile(_imageFile);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      final oldDownloadUrl = downloadUrl.toString();
      String newFileName = oldDownloadUrl.substring(
          oldDownloadUrl.lastIndexOf('%2F') + 3,
          oldDownloadUrl.lastIndexOf('?'));

      StorageReference oldReference = FirebaseStorage.instance
          .ref()
          .child(basePath + '/' + Uri.decodeComponent(newFileName));
      await oldReference.delete(); // Delete original image to save space

      String imageType = photoType == 'COVER' ? "cover_" : "profile_";
      StorageReference newReference = FirebaseStorage.instance
          .ref()
          .child(basePath + '/' + imageType + Uri.decodeComponent(newFileName));
      String newDownloadUrl = await getNewImageURL(newReference);
      if (newDownloadUrl.isNotEmpty) {
        callBack(newDownloadUrl);
      }
    } catch (e) {
      print(e.message);
    }
  }

  static Future<dynamic> getNewImageURL(StorageReference newReference) async {
    String newDownloadUrl = "";
    Completer<String> comp = new Completer<String>();

    void poll() async {
      try {
        newDownloadUrl = await newReference.getDownloadURL();
        if (newDownloadUrl.isEmpty) {
          await Future.delayed(
              const Duration(seconds: 30), () => comp.complete(null));
          poll();
        }
        else {
          comp.complete(newDownloadUrl.toString());
        }
      }
      catch (e) {
        print('ERROR in getNewImageURL::${e.message}');
        poll();
      }
    }

    poll();
    return comp.future;
  }

  static String getFileName(fileUri) {
    fileUri = fileUri.toString();
    String fileName = fileUri.substring(fileUri.lastIndexOf('/') + 1);
    fileName = fileName.substring(0, fileName.length - 1);
    // Append the date string to the file name to make each upload unique.
    fileName = appendDateString(fileName);
    return fileName;
  }

  // Append the current date as string to the file name.
  static String appendDateString(String fileName) {
    DateTime now = new DateTime.now();
    final name =
        fileName.substring(0, fileName.lastIndexOf('.')) + '_' + now.toString();
    final extension =
    fileName.substring(fileName.lastIndexOf('.'), fileName.length);
    return name + '' + extension;
  }

  static String getProductFileName(fileUri) {
    fileUri = fileUri.toString();
    String fileName = fileUri.substring(fileUri.lastIndexOf('/') + 1);
    fileName = fileName.substring(0, fileName.length - 1);
    fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
//    fileName = appendDateString(fileName);
    // Append the date string to the file name to make each upload unique.
    return fileName;
  }

  static Future<String> uploadProductVideo(File videoFile, {
    @required String productId, @required String designerId,}) async {
    print('uploadProductVideo');

    String downloadUrl;
    StorageUploadTask uploadTask;

    try {
      var uploadReference = FirebaseStorage.instance.ref()
          .child('products').child('video')
          .child('$designerId').child('$productId');


      uploadTask = uploadReference.putFile(videoFile, );

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    }

    on PlatformException catch(ex){
      uploadTask.cancel();
      print(ex);
    }

    catch(ex) {
      uploadTask.cancel();
      print(ex);
    }

    return downloadUrl;
  }

  static Future<void> removeProductVideo(
      {@required String productId, @required String designerId,}) async {

    try {
      var uploadReference = FirebaseStorage.instance.ref()
          .child('products').child('video')
          .child('$designerId').child('$productId');

      return uploadReference.delete();

    }

    on PlatformException catch(ex){
      print(ex);
    }

    catch(ex) {
      print(ex);
    }

  }

//  static Future<String> uploadProductImage(String userId, File imageFile) async {
//    final basePath = 'products';
//    String downloadUrl;
//
//    if (imageFile.path.contains('https://')){
//      print('Not needed upload ${imageFile.path} IMG');
//    }
//
//    try {
//      String _refPath = basePath + '/' + userId + '_' + DateTime.now().millisecondsSinceEpoch.toString() + '_0' + '.jpg';
//      StorageReference ref = FirebaseStorage.instance.ref().child(_refPath);
//      StorageUploadTask uploadTask = ref.putFile(imageFile);
//      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//      downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
//    }
//
//    on Exception catch (ex) {
//      print('StorageService::uploadProductImage fail! ${ex.toString()}');
//    }
//
//    var flag = true;
//    while (flag) {
//      try {
//        var path = _buildResizedImagePath(downloadUrl);
//        StorageReference newReference = FirebaseStorage.instance.ref().child(
//            basePath + '/' + '1080_' + Uri.decodeComponent(path));
//
//        downloadUrl = await newReference.getDownloadURL();
//        flag = false;
//      }
//      on Exception catch (ex) {
//        // was not possible fetch resized image url
//        //we'll try again in same image after 3 seconds
//        print('get resized image path failed.. trying again in 3 seconds');
//        flag = true;
//        await Future.delayed(Duration(seconds: 3));
//      }
//    }
//    print('Gotchaa!! image uploaded $downloadUrl');
//    return downloadUrl;
//  }

  // It's working. But we can improve this method.
  // Here we firstly upload all images on firestorage and then we try fetch
  // the resized uploaded image if it fails we wait for 3 seconds and try to fetch again.

  static Future<List<String>> uploadDesignImages(final List<File> images, String userId) async {
    List<String> uploadedDesigns = List<String>();
    Map<String, String> uploadedImageMap = {};
    final basePath = 'products';

    if (images != null) {
      final localImages = List.from(images);

      // uploading images loop
      for (int i = 0; i < localImages.length; i++) {
        File image = localImages[i];
        if (image.path.contains('https://')){
          print('Not needed upload ${image.path} IMG');
          uploadedDesigns.add( image.path );
          continue;
        }

        try {
          // var compressedImageFile

          //     var compressedImageFile = await _compressImageFile(image);

          //   print('Normal image size ${await image.length()}');
          // print('Compressed image size ${await compressedImageFile.length()}');

          //String fileName = getProductFileName(image);
          String _refPath = basePath + '/' + userId + '_' +
              DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString() + '_' + i.toString() + '.jpg';
          StorageReference ref = FirebaseStorage.instance.ref().child(_refPath);
          StorageUploadTask uploadTask = ref.putFile(image);
          StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
          String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

          print('___ ORIGINAL IMAGE FIRESTORE URL___ : $downloadUrl');
          if (downloadUrl != null) {
            var newFileName = _buildResizedImagePath(downloadUrl);
            uploadedImageMap.putIfAbsent( downloadUrl , () => newFileName);
          }
        }
        catch (e) {
          print(e.message);
        }
      }

      List<String> resizedImgPaths = uploadedImageMap.values.toList();

      // fetching resized images URL
      for(int i =0; i < resizedImgPaths.length; i++){
        try {
          var path = resizedImgPaths[i];
          StorageReference newReference = FirebaseStorage.instance.ref().child(
              basePath + '/' + '1080_' + Uri.decodeComponent(path));

          String url = await newReference.getDownloadURL();

          if (uploadedImageMap.isNotEmpty) {
            uploadedDesigns.add(url);
          }
        }
        on Exception catch (_){
          // was not possible fetch resized image url
          //we'll try again in same image after 3 seconds
          i--;
          await Future.delayed(Duration(seconds: 3));
          //print('lets go!');
        }
      }
    }// end if
    return uploadedDesigns;
  }

  static String _buildResizedImagePath(final String downloadUrl){
    final oldDownloadUrl = downloadUrl.toString();

    return oldDownloadUrl.substring(
        oldDownloadUrl.lastIndexOf('%2F') + 3,
        oldDownloadUrl.lastIndexOf('?'));
  }

  static Future<String> uploadFile(File imageFile, String userId) async {
    String fileName = getFileName(imageFile);
    String refPath = 'images/messages/${userId}_$fileName';
    StorageReference ref = FirebaseStorage.instance.ref().child(refPath);
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // static Future<File> _compressImageFile(File toCompress,) async {
  //   var tempDir = Directory.systemTemp.path;

  //   File compressedFile = File('$tempDir/${DateTime
  //       .now()
  //       .millisecondsSinceEpoch}.jpeg');

  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     toCompress.absolute.path, compressedFile.absolute.path,
  //     quality: 89,
  //   );

  //   return result;
  // }
}
