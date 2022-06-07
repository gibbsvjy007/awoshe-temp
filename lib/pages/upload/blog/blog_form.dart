import 'dart:io';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/appbar/UploadAppBar.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/blog/blog_bloc_event_v2.dart';
import 'package:Awoshe/logic/bloc/blog/blog_bloc_state_v2.dart';
import 'package:Awoshe/logic/bloc/blog/blog_bloc_v2.dart';
import 'package:Awoshe/logic/bloc/upload/blog/upload_blog_form.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/upload/selectcat.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:Awoshe/widgets/upload_asset_view.dart';
import 'package:Awoshe/widgets/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../constants.dart';
import '../../../router.dart';

class UploadBlog extends StatefulWidget {
  @override
  _UploadBlogState createState() => _UploadBlogState();
}

class _UploadBlogState extends State<UploadBlog> {
  TextEditingController _titleController;
  TextEditingController _descController;
  TextEditingController _urlController;
  BlogBlocV2 _blogBlocV2;
  UploadBlogFormBloc _uploadBlogFormBloc;
  List<File> resultList;
  Future<File> imageFile;
  String categorySelected;
  List<Widget> previewImages = <Widget>[];
  UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _uploadBlogFormBloc = UploadBlogFormBloc();
    _blogBlocV2 = BlogBlocV2();
    _titleController = TextEditingController();
    _descController = TextEditingController();
    _urlController = TextEditingController();
    resultList = List<File>();
  }

  @override
  void didChangeDependencies() {
    //_blogBlocV2 // ??= Provider.of<BlogBlocV2>(context);
    _userStore ??= Provider.of<UserStore>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController?.dispose();
    _descController?.dispose();
    _urlController?.dispose();
    _uploadBlogFormBloc.dispose();
    _blogBlocV2.dispose();
    resultList.clear();
  }

  void _listenStateChanges(previous, current ) {
    print('on listener ${current.eventType}');
    if (current.eventType  == BlogBlocEvents.UPLOAD && current is BlogBlocStateSuccess)
      clearData();


    Utils.showAlertMessage(context,
      title: 'Blog Uploaded',
      message: "Great! You uploaded a Blog successfully. "
          "Don’t forget to check under your Profile -> Blogs, "
          "to add more information.",
      onConfirm: uploadOk,
    );

//    Awoshe.showSimpleDialog(context,
//        content: "Great! You uploaded a Blog successfully. "
//            "Don’t forget to check under your Profile -> Blogs, "
//            "to add more information.",
//        onTap: uploadOk);
  }

  void clearData() {
    resultList.clear();
    _uploadBlogFormBloc.changeImage(null);
    _titleController.clear();
    _urlController.clear();
    _descController.clear();
  }

  void uploadOk() {
    AppRouter.router.navigateTo(context, Routes.home);
  }

  Future<void> loadAssets(ImageSource source) async {
    String _error;

    try {
      imageFile = ImagePicker.pickImage(source: source);

      if (imageFile != null) {
        await Future.delayed(Duration(milliseconds: 500));
        //_showLoading(true);
        var image = await imageFile;
        image = await _cropImage(image);
        if (image != null) {
          resultList.add(image);
          _uploadBlogFormBloc.changeImage(resultList);
        }
      }

    }
    on Exception catch (e) {
      _error = e.toString();
      print(_error);
    }
    //_showLoading(!isCropping);
  }

  Future<File> _cropImage(File currentImage) async {
    if (currentImage == null)
      return currentImage;

    var decodedImage = await decodeImageFromList(currentImage.readAsBytesSync());
    var ratioX, ratioY;

    if (decodedImage != null) {
      if (decodedImage.width == decodedImage.height) {
        print('Square defining 1:1');
        ratioX = ratioY = 1.0;
      }
      // is landscape
      else if (decodedImage.width > decodedImage.height) {
        print('landscape image defining 4:3');
        ratioX = 4.0;
        ratioY = 3.0;
      }

      else {
        print('portrait defining 3:4');
        ratioX = 3.0;
        ratioY = 4.0;
      }
      return ImageCropper.cropImage(
        sourcePath: currentImage.path,
          aspectRatio: CropAspectRatio(ratioX: ratioX.toDouble(),
              ratioY: ratioY.toDouble())
      );
    }
    return null;
  }

  _selectedPhotoOption(PhotoSourceType type) {
    switch (type) {
      case PhotoSourceType.GALLERY:
        loadAssets(ImageSource.gallery);
        break;
      case PhotoSourceType.CAMERA:
        loadAssets(ImageSource.camera);
        break;
      default:
    }
  }

  _onUploadPressed() {
    String uid = Provider.of<UserStore>(context).details.id;

    _blogBlocV2.dispatch(
      BlogBlocUpload(
        userId: uid,
        url: _urlController.text,
        title: _titleController.text,
        images: resultList.map<String> ((f) => f.path).toList(),
        description: _descController.text,
        feedType: FeedType.BLOG,
        category: categorySelected,
        handle: _userStore.details.handle,
        thumbnailUrl: _userStore.details.thumbnailUrl,
        name: _userStore.details.name,
        status: 'active'
      )
    );
  }

  Widget selectImageCamera() => Row(children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            if (resultList.length >= 3) {
              ShowFlushToast(context, ToastType.INFO,
                  "Limit exceeded. Maximum 3 images are allowed.");
              return;
            }
            _selectedPhotoOption(PhotoSourceType.GALLERY);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: awLightColor300,
            ),
            height: 110.0,
            width: 110.0,
            child: Center(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: SvgPicture.asset(Assets.camera),
              ),
            ),
          ),
        ),
      ]);

  Widget buildPreview() => StreamBuilder(
        stream: _uploadBlogFormBloc.images,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            previewImages.clear();
            for (int i = 0; i < snapshot.data.length; i++) {
              previewImages.add(AssetView(
                asset: snapshot.data[i],
                height: 110.0,
                width: 110.0,
                margin: EdgeInsets.only(right: 10.0),
              ));
            }
            previewImages.add(selectImageCamera());
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              height: 110.0,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: previewImages.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return previewImages[index];
                  }),
            );
          }

          return selectImageCamera();
        },
      );

  Widget buildTitleField() => StreamBuilder<String>(
      stream: _uploadBlogFormBloc.title,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).title,
            obscureText: false,
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            controller: _titleController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            radius: APP_INPUT_RADIUS,
            floatingLabel: Localization.of(context).title,
            leftPadding: 20.0,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: _uploadBlogFormBloc.changeTitle);
      });

  Widget buildDescField() => StreamBuilder<String>(
      stream: _uploadBlogFormBloc.desc,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).desc,
            obscureText: false,
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            controller: _descController,
            radius: APP_INPUT_RADIUS,
            leftPadding: 20.0,
            maxLines: 4,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: _uploadBlogFormBloc.changeDesc);
      });

  Widget buildUrlField() => StreamBuilder<String>(
      stream: _uploadBlogFormBloc.url,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).blogUrl,
            obscureText: false,
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            controller: _urlController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            radius: APP_INPUT_RADIUS,
            floatingLabel: Localization.of(context).blogUrl,
            leftPadding: 20.0,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: _uploadBlogFormBloc.changeUrl);
      });

  Widget buildCategoryField() =>
      StreamBuilder<String>(
        stream: _uploadBlogFormBloc.category,
        builder: (context, snapshot){
          var color;

          if (snapshot.data == null || snapshot.data.isEmpty){
            categorySelected = 'Select the category...';
            color = awLightColor;
          }
          else {
            color = secondaryColor;
            categorySelected = snapshot.data;
          }

          return Container(
            margin: EdgeInsets.only(bottom: 15.0),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          SelectCat(
                            null,null,
                            displaySubCategoriesMenu: false,
                            callback: (cat,sub){
                              print('Selected category $cat');
                              this.categorySelected = cat;
                              _uploadBlogFormBloc.changeCategory(cat);
                              Navigator.pop(context);
                            },
                          ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: awLightColor),
                      borderRadius: BorderRadius.circular(APP_INPUT_RADIUS)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Utils.capitalize(categorySelected),
                        style: textStyle.copyWith(color: color),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.0,
                        color: awLightColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

  Widget uploadButton(BlogBlocState state) => AwosheButton(
            onTap: (state is BlogBlocStateBusy) ? null : _onUploadPressed,
            childWidget: (state is BlogBlocStateBusy)
                ? DotSpinner()
                : Text(Localization.of(context).upload, style: buttonTextStyle),
            buttonColor: primaryColor,
      );

  Widget buildBlogForm(BlogBlocState state) => Column(
        children: <Widget>[
          VerticalSpace(20.0),
          buildPreview(),
          VerticalSpace(20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: <Widget>[
                buildTitleField(),
                buildUrlField(),
                buildCategoryField(),
                buildDescField(),
                VerticalSpace(30.0),
                uploadButton(state)
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: UploadAppBar(
        title: "Upload Blog",
        onBackPressed: () => Navigator.pop(context),
      ),
      //appBar: AwosheAppBar(title: "Upload Blog", hideActions: true, center: true,),
      body: BlocListener<BlogBlocV2, BlogBlocState>(
        bloc: _blogBlocV2,
        listener: _listenStateChanges,
        child: BlocBuilder<BlogBlocV2, BlogBlocState>(
          bloc: _blogBlocV2,
          builder: (context, state){
            return buildBlogForm(state);
          },
        ),
      ),
    );
  }
}