import 'dart:io';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/awsliverappbar.dart';
import 'package:Awoshe/components/dropdown/awoshe_dropdown.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_details_form_bloc.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/collection/collection.dart';
import 'package:Awoshe/pages/upload/create_feed_type.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/upload_asset_view.dart';
import 'package:flutter/services.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_bloc.dart';
import 'package:Awoshe/logic/bloc/upload/SelectSizeBloc.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_state_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_event_v2.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:Awoshe/pages/upload/selectcat.dart';
import 'package:Awoshe/pages/upload/selectsize.dart';
import 'package:Awoshe/router.dart';
import 'package:Awoshe/utils/ImageUtils.dart';
import 'package:Awoshe/utils/awoshe.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadForm extends StatefulWidget {
  UploadForm({Key key, @required this.productType, this.uploadMode})
      : super(key: key);

  final ProductType productType;
  final UploadMode uploadMode;

  @override
  _UploadFormState createState() => new _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {

  List<File> resultList;
  UploadType uploadType = UploadType.DESIGN;
  Future<File> imageFile;
  List<Widget> previewImages = <Widget>[];
  TextEditingController _titleController;
  TextEditingController _descController;
  TextEditingController _priceController;
  List<String> currencyList = List<String>();
  Map<String, Collection> _displayTypesOptions = {};
  Collection _selectedDisplayTypeOption = Collection.DEFAULT_TYPE;
  String _selectedCurrency;
  String mainCategoryTitle;
  String subCategoryTitle;
  SizeSelectionInfo _sizesSelected;
  //String mainCategoryId;
  //String subCategoryId;
  String collectionId;
  bool isCropping = false;
  UploadDesignBlocV2 _blocV2;
  UploadDesignDetailsFormBloc _uploadDesignDetailsFormBloc =
      UploadDesignDetailsFormBloc();
  AuthenticationBloc authBloc;
  String userId;

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    userId ??= Provider.of<UserStore>(context, listen: false).details.id;
    print('Using user ID  $userId');
    if (_blocV2 == null){

      _blocV2 = Provider.of<UploadDesignBlocV2>(context);
      _blocV2.dispatch(
          UploadDesignBlocEventCollectionRead(userId: userId)
      );
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    resultList = List<File>();
    _titleController = TextEditingController();
    _descController = TextEditingController();
    _priceController = TextEditingController();

    currencyList = ["USD"].toList();
    //displayTypesOptions.add(Promotion.DEFAULT_TYPE);

    /// in future it should be listed from the server or move to config file
    _selectedCurrency = currencyList[0];
    //_selectedDisplayType = DISPLAY_TYPE[0];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _uploadDesignDetailsFormBloc.dispose();
    resultList.clear();
    _titleController?.dispose();
    currencyList.clear();
    _descController?.dispose();
    _priceController?.dispose();
  }

  void clearData() {
    resultList.clear();
    _uploadDesignDetailsFormBloc.changeImage(null);
    _titleController.clear();
    _priceController.clear();
    _descController.clear();
    _sizesSelected = null;
  }

  void _listenStateChanges(
      BuildContext context, UploadDesignBlocStateV2 state) {
    switch (state.eventType) {
      case UploadDesignBlocEventType.UPLOAD:
        if ( state is UploadDesignBlocStateSuccess) {
          Awoshe.showSimpleDialog(context,
              content: widget.productType == ProductType.DESIGN
                  ? Localization.of(context).productUploadSuccess
                  : Localization.of(context).fabricUploadSuccess,
              onTap: uploadOk);
        } else if (state is UploadDesignBlocStateFail)
          ShowFlushToast(context, ToastType.ERROR, state.message);
        break;
      // isn't apply
      case UploadDesignBlocEventType.UPDATE:
        break;
      // isn't apply
      case UploadDesignBlocEventType.READ:
        break;
      // isn't apply
      case UploadDesignBlocEventType.DELETE:
        break;
      case UploadDesignBlocEventType.INIT:
        break;
    }
  }

  void categoryCallback(String mainCategory, String subCategory) async {
    if (subCategory.isNotEmpty) {
      if ((mainCategory != mainCategoryTitle) &&
          (subCategory != subCategoryTitle)) _sizesSelected = null;

      mainCategoryTitle = mainCategory;
      subCategoryTitle = subCategory;
      setState(() {} );
      await _openSizesSelectionPage(mainCategory, subCategory);
    }

    Navigator.pop(context);
  }

  Future _openSizesSelectionPage(
      String mainCategory, String subcategory) async {
    return Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        builder: (BuildContext context) => Provider<SelectSizeBloc>(
          builder: (context) {
            var bloc = SelectSizeBloc();

            // before pass the sizesSelected to bloc we've to make sure if
            // the current category & subcategory selected is matching the sizes selected
            bloc.init(context, mainCategory, subcategory);
            return bloc;
          },
          dispose: (context, bloc) {
            print('SelectSizeBloc dispose()');
            bloc.dispose();
          },

          child: SelectSizePage(
            mainCategoryTitle?.toLowerCase(),
            subCategoryTitle?.toLowerCase(),
            callback: (SizeSelectionInfo sizeSelectionData) {
              print('Size Selected $sizeSelectionData');
              _sizesSelected = sizeSelectionData;
            },
          ),
        ),
      ),
    );
  }

  void _openSelectCat() async {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        fullscreenDialog: true,
        builder: (BuildContext context) => SelectCat(
            mainCategoryTitle?.toLowerCase(), subCategoryTitle?.toLowerCase(),
            callback: categoryCallback),
      ),
    );
  }

  void uploadOk() {
    AppRouter.router.navigateTo(context, Routes.home);
  }

  _onUploadPressed() {
    _blocV2.dispatch(
      UploadDesignBlocEventUpload(
        userId: userId,
        productType: widget.productType,
        images: resultList.map<String>((file) => file.path).toList(),
        title: _titleController.text,
        description: _descController.text,
        mainCategory: mainCategoryTitle,
        subCategory: subCategoryTitle,
        currency: _selectedCurrency,
        sizesInfo: _sizesSelected,
        collectionName: collectionId,
        price: _priceController.text,
        feedType: _selectedDisplayTypeOption.displayType,
        owner: userId,
      ),
    );
  }

  void _onSelectCurrency(value) async {
    setState(
      () {
        /// have to setState. no need to use bloc pattern for the simple stuff
        /// can be change to bloc pattern in future.
        _selectedCurrency = value;
      },
    );
  }

  void _onSelectDisplayType(String value) {
    print('selected $value');
    setState(() {
      if (resultList.isNotEmpty) resultList.clear();
      _selectedDisplayTypeOption = _displayTypesOptions[value];
      collectionId = _selectedDisplayTypeOption.id;
      print('SELECTED OPTION: ${_selectedDisplayTypeOption.title}');
    });
  }

  Future<void> loadAssets(ImageSource source) async {
    String _error;
    ImageOrientation orientation;
    try {
      imageFile = ImagePicker.pickImage(source: source);
      if (imageFile != null) {
        await Future.delayed(Duration(milliseconds: 500));
        _showLoading(true);
        var originalImageFile = await imageFile;

        if (originalImageFile != null) {
          // now we have the image
          // needs to know if image orientation is compatible
          // with carousel choice
          if (_selectedDisplayTypeOption.displayType == FeedType.SW) {
            // verify if image is in landscape mode
            var decodedImage =
                await decodeImageFromList(originalImageFile.readAsBytesSync());
            orientation = ImageUtils.resolveImageOrientation(decodedImage);

            if ((_selectedDisplayTypeOption.orientation == 'LD') &&
                orientation != ImageOrientation.LANDSCAPE) {
              _showLoading(false);
              print('incompatible LANDSCAPE MODE image'
                  'debug Image Width: ${decodedImage.width} X '
                  'Image Heigth ${decodedImage.height}');
              ShowFlushToast(context, ToastType.WARNING,
                  "Selected image isn't lanscape mode!");
              return;
            }

            if ((_selectedDisplayTypeOption.orientation == 'PT') &&
                orientation != ImageOrientation.PORTRAIT) {
              _showLoading(false);
              print('incompatible PORTRAIT MODE image'
                  'debug Image Width: ${decodedImage.width} X '
                  'Image Heigth ${decodedImage.height}');
              ShowFlushToast(context, ToastType.WARNING,
                  "Selected image isn't portrait mode!");
              return;
            }

            if (orientation == ImageOrientation.UNDEFINED) {
              _showLoading(false);
              ShowFlushToast(
                  context, ToastType.ERROR, 'Error with selected image');
              return;
            }
          }

          originalImageFile = await ImageUtils.cropImage(originalImageFile,
              ratioX: _selectedDisplayTypeOption.ratioX,
              ratioY: _selectedDisplayTypeOption.ratioY);

          if (originalImageFile != null) {
            resultList.add(originalImageFile);
            _uploadDesignDetailsFormBloc.changeImage(resultList);
          }
        }
      }
    } on PlatformException catch (e) {
      _error = e.message;
      print(_error);
    }

    _showLoading(!isCropping);
  }

  Widget titleField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.title,
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
            leftPadding: 20.0,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: _uploadDesignDetailsFormBloc.changeTitle);
      });

  Widget descField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.desc,
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
            onChanged: _uploadDesignDetailsFormBloc.changeDesc);
      });

  Widget priceField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.price,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: InputFieldV2(
                  hintText: Localization.of(context).price,
                  obscureText: false,
                  hintStyle: TextStyle(color: awLightColor),
                  textInputType: TextInputType.number,
                  textStyle: textStyle,
                  controller: _priceController,
                  radius: APP_INPUT_RADIUS,
                  textFieldColor: textFieldColor,
                  textAlign: TextAlign.left,
                  leftPadding: 20.0,
                  errorText: snapshot.error,
                  onChanged: _uploadDesignDetailsFormBloc.changePrice),
            ),
            SizedBox(width: 30.0),
            Expanded(
              flex: 1,
              child: selectCurrency(),
            )
          ],
        );
      });

  Widget selectCurrency() => AwosheDropdown(
        color: awLightColor,
        options: currencyList,
        radius: APP_INPUT_RADIUS,
        hintStyle: hintStyle,
        selectedValue: _selectedCurrency,
        onChange: _onSelectCurrency,
      );

  void _fillDisplayTypeOptions(List<Collection> collections) {
    //displayTypesOptions.clear();
    collections.forEach((collection) {
      _displayTypesOptions.putIfAbsent(collection.title, () => collection);
    });
  }

  Widget displayField() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: BlocBuilder<UploadDesignBlocV2, UploadDesignBlocStateV2>(
                bloc: _blocV2,
                condition: (previous, current){
                  if (current is UploadDesignBlocUploadCollectionSuccess)
                    return true;
                  if (current is UploadDesignBlocReadCollectionSuccess)
                    return true;
                  return false;
                },
                builder: (context, state) {
                  print('building comboBox');
                  _displayTypesOptions.clear();
                  _fillDisplayTypeOptions(_blocV2.collections);
                  return AwosheDropdown(
                      color: awLightColor,
                      options: _blocV2.collections.map( (c) => c.title ).toList(),
                      radius: APP_INPUT_RADIUS,
                      hintStyle: hintStyle,
                      selectedValue: _selectedDisplayTypeOption.title,
                      onChange: _onSelectDisplayType,
                    );
                  },
            ),
          ),

          Flexible(
            fit: FlexFit.loose,
            child: FlatButton.icon(
              onPressed: ()  {

                bool fullScreenDialog = true;
                if (fullScreenDialog) {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute<bool>(
                      fullscreenDialog: true,
                      builder: (BuildContext context) =>
                          Provider<UploadDesignBlocV2>(
                            builder: (_) => _blocV2,
                            child: CreateFeedType(
                                uploadDesignDetailsFormBloc:
                                _uploadDesignDetailsFormBloc,
                                //collNameCallBack: _onCollectionCreated
                            ),
                          ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return Center(
                        // Aligns the container to center
                        child: Container(
                          height: 300.0,
                          margin: EdgeInsets.all(15.0),
                          child: Provider<UploadDesignBlocV2>(
                            builder: (_) => _blocV2,
                            child: CreateFeedType(
                                uploadDesignDetailsFormBloc:
                                _uploadDesignDetailsFormBloc,
                                //collNameCallBack: _onCollectionCreated
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }


              },
              icon: Icon(
                Icons.add,
                color: primaryColor,
              ),
              label: Text(
                "New",
                style: TextStyle(color: primaryColor),
              ),
              padding: EdgeInsets.all(.0),
            ),
          )
        ],
      );

  /// Change to bloc listener
  Widget uploadButton(UploadDesignBlocStateV2 state) {
    return AwosheButton(
      onTap: (state is UploadDesignBlocStateBusy) ? null : _onUploadPressed,
      childWidget: (state is UploadDesignBlocStateBusy)
          ? DotSpinner()
          : Text(Localization.of(context).upload, style: buttonTextStyle),
      buttonColor: primaryColor,
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

  onImageDelete(File _iFile, int index) {
    print(_iFile);
    print(index);
    print(resultList.toString());
    resultList.removeAt(index);
    previewImages.clear();
    print(resultList.toString());
    _uploadDesignDetailsFormBloc.changeImage(resultList);
  }

  /// Preview clicked images in the grid list
  Widget _previewImage() => StreamBuilder(
        stream: _uploadDesignDetailsFormBloc.images,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            previewImages.clear();
            print(snapshot.data.toString());
            for (int i = 0; i < snapshot.data.length; i++) {
              previewImages.add(AssetView(
                asset: snapshot.data[i],
                onDelete: onImageDelete,
                index: i,
                height: 110.0,
                width: 110.0,
                margin: EdgeInsets.only(right: 10.0),
              ));
            }
            previewImages.add(selectImageCamera());
            return Container(
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

  Widget categoryTagsField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.desc,
      builder: (context, snapshot) {
        String categoryText = Localization.of(context).category;
        Color color = awLightColor;
        if (mainCategoryTitle != null && subCategoryTitle != null) {
          categoryText = mainCategoryTitle + " -> " + subCategoryTitle;
          color = secondaryColor;
        }
        return Material(
          color: Colors.white,
          child: InkWell(
            onTap: () { _openSelectCat(); },
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
                    categoryText,
                    style: TextStyle(color: color, fontWeight: FontWeight.w600),
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
        );
      });

  void _showLoading(bool status) => setState(() => isCropping = status);

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];
    var widgetBody = SafeArea(
      child: CustomScrollView(slivers: <Widget>[
        AwosheSliverAppBar(
          title: "Upload",
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 6.0),
                  child: displayField(),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        color: awLightColor,
                        size: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          "The default type is a single product upload. Collections can be created as thumbnails or  carousel. Carousel uploads images are either landscape or portrait. Cannot be mixed",
                          style: hintStyle,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(16.0), child: _previewImage()),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 6.0),
                  child: titleField(),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 6.0),
                  child: descField(),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 6.0),
                  child: categoryTagsField(),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 6.0),
                  child: priceField(),
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 10.0),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),

                    child: BlocListener<UploadDesignBlocV2,
                        UploadDesignBlocStateV2>(
                      bloc: _blocV2,
                      listener: _listenStateChanges,
                      condition: (previous, current){
                        return true;
                      },
                      child: BlocBuilder<UploadDesignBlocV2,
                              UploadDesignBlocStateV2>(
                          builder: (context, state) => uploadButton(state)),
                    )),
                SizedBox(height: 20.0)
              ],
            )
          ]),
        )
      ]),
    );

    widgets.add(widgetBody);
    if (isCropping) widgets.add(ModalAwosheLoading());

    return Stack(
      children: widgets,
    );
  }
}
