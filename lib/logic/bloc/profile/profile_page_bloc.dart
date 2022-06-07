import 'dart:io';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/UserDetailsCacheStore.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/models/user_profile.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:Awoshe/services/storage.service.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

import '../../../router.dart';

class PrivateProfileBloc {
  final BehaviorSubject<bool> _modalStreamController = BehaviorSubject.seeded(false);
  Observable<bool> get modalStream => _modalStreamController.stream;
  Observable<int> designsOrFavourites;
  String profileUserId;
  UserStore userStore;
  ProfileStore profileStore;

  PrivateProfileBloc({this.profileUserId, this.profileStore, this.userStore}): super();

  init() {
//    designsOrFavourites = Observable( (AppData.isDesigner) ?
//    ProfileService.getDesignsByUserId(profileUserId).transform(counterTransformer) :
//    ProfileService.getFavouritesByUserId(profileUserId).transform(counterTransformer) );
  }

  void showModalLoading(final bool flag) {
    if (!_modalStreamController.isClosed)
      _modalStreamController.sink.add(flag);
  }

  void uploadProfileImage(final ImageSource source) async {
    showModalLoading(true);

    try{
      File img = await selectImageToUpload(source, 350, 350);
      if (img != null)
        await uploadImage(img, ProfilePhotoType.PROFILE);
    }
    catch (ex){
      print(ex);
    }

    showModalLoading(false);
  }

  void uploadCoverProfileImage(final ImageSource source) async {
    showModalLoading(true);
    try{
      File img = await selectImageToUpload(source, 450, 650,
          ratioX: 4, ratioY: 16, circleShape: false);
      if (img != null)
        await uploadImage(img, ProfilePhotoType.COVER);
    }
    catch (ex){
      showModalLoading(false);
      print(ex);
    }

    showModalLoading(false);
  }

  Future<File> selectImageToUpload(final ImageSource source,
      int maxWidth, int maxHeight, {int ratioX, int ratioY, bool circleShape = true}) async {
    File selectedImage;
    try {
      selectedImage = await ImagePicker.pickImage(source: source);
      if (selectedImage != null) {
        selectedImage = await ImageCropper.cropImage(
          sourcePath: selectedImage.path,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        );
      }
    }
    catch (ex){
      showModalLoading(false);
      selectedImage = null;
    }
    return selectedImage;
  }

  Future<String> uploadImage(final File imageFile, ProfilePhotoType type) async {
    String url;
    if (imageFile != null) {
      UserDetails updatedDetails;
      Map<String, dynamic> oData = Map();
      if (type == ProfilePhotoType.PROFILE) {
        url = await StorageService.uploadUserProfileImage(imageFile, this.profileUserId);
        updatedDetails = userStore.details.copyWith(pictureUrl: url, thumbnailUrl: url);
        oData['thumbnailUrl'] = url; // TODO - needs to be compressed.
        oData['pictureUrl'] = url;
      } else {
        url = await StorageService.uploadUserCoverProfileImage(imageFile, this.profileUserId);
        updatedDetails = userStore.details.copyWith(coverUrl: url);
        oData['coverUrl'] = url;
      }
      userStore.updateProfile(oData);
      profileStore.setUserDetails(updatedDetails);
      userStore.setUserDetails(updatedDetails);
    }

    return url;
  }

  void logout(BuildContext context) {
    Utils.showAlertMessage(
        context,
        title: Localization
            .of(context)
            .logout,
        warning: false,
        confirmText: Localization
            .of(context)
            .logout,
        onCancel: () => Navigator.pop(context),
        onConfirm: () async {
          await AuthenticationService.instance.signOut();
          UserDetailsCacheStore.instance.clear();
          AppRouter.router.navigateTo(
              context, Routes.welcome, replace: true, clearStack: true);

        },
        message: Localization
            .of(context)
            .logoutConfirmText
    );
  }

  void dispose(){
    _modalStreamController?.close();
  }
}