import 'dart:io';
import 'dart:ui';
import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/AwosheOverlayPageRoute.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/checkbox/checkbox.dart';
import 'package:Awoshe/components/dropdown/awoshe_dropdown.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/upload/SelectSizeBloc.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_state_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_details_form_bloc.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_event_v2.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:Awoshe/models/upload.dart';
import 'package:Awoshe/pages/product/product_carousel.dart';
import 'package:Awoshe/pages/upload/selectcat.dart';
import 'package:Awoshe/pages/upload/selectsize.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/ImageUtils.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:Awoshe/widgets/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// TODO we need implement a better state management in this widget
// using BLoC pattern and remove all setState calls and data model object
// from this class

class DetailsTab extends StatefulWidget {
  DetailsTab(
      {Key key,
      this.designImages,
      this.productData,
      this.uploadType,

      })
      : super(key: key);

  final List<File> designImages;
  final ProductType uploadType;
  final Product productData;

  @override
  _DetailsTabState createState() => new _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> {
  TextEditingController _titleController;
  TextEditingController _descController;
  TextEditingController _productCareInfoController;
  TextEditingController _priceController;
  List<SelectableItem> occasionList = List<SelectableItem>();
  List<String> selectedOccassions = <String>[];

  UploadDesignDetailsFormBloc _uploadDesignDetailsFormBloc = UploadDesignDetailsFormBloc();
  UploadDesignBlocV2 _blocV2;
  List<String> currencyList = List<String>();
  String _selectedCurrency;
  String mainCategoryTitle;
  String subCategoryTitle;
  bool imageChanging = false;
  List<File> imagesToAdd = [];
  List<File> _imagesToDisplayInCarousel;
  Product productState;
  SizeSelectionInfo _sizeSelectionInfo;

  @override
  void didChangeDependencies() {
    _blocV2 ??= Provider.of<UploadDesignBlocV2>(context);
    productState = _blocV2.product;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    productState = widget.productData;
    super.initState();

    if (productState != null){
      _imagesToDisplayInCarousel = List.from(
          productState.images.map( (url) => File(url))
              .toList() );

      _titleController = TextEditingController(text: productState.title);
      _descController = TextEditingController(text: productState.description);
      _productCareInfoController = TextEditingController(text: productState.productCare);
      _priceController =
          TextEditingController(text: productState.price.toString() ?? '0');
    }
    else {
      _titleController = TextEditingController();
      _descController = TextEditingController();
      _productCareInfoController = TextEditingController();
      _priceController = TextEditingController();
    }

    occasionList = AppData.occasions();
    currencyList = ["USD", "INR"].toList();

    /// in future it should be listed from the server or move to config file
    _selectedCurrency = currencyList[0];

    //_uploadDesignDetailsFormBloc = widget.uploadDesignFormBloc;
    _uploadDesignDetailsFormBloc.changeTitle(_titleController.text);
    _uploadDesignDetailsFormBloc.changePrice(_priceController.text);

    _titleController.addListener( _titleListener );
    _descController.addListener(  _descListener );
    _productCareInfoController.addListener( _productCareInfoListener );
    _priceController.addListener( _priceListener );
  }

  // controller listener function
  void _titleListener() {
    _uploadDesignDetailsFormBloc.changeTitle(_titleController.text);
    _blocV2.product.title = _titleController.text;
  }

  // controller listener function
  void _descListener() {
    _uploadDesignDetailsFormBloc.changeDesc(_descController.text);
    _blocV2.product.description = _descController.text;
  }

  // controller listener function
  void _productCareInfoListener() {
    _uploadDesignDetailsFormBloc.changeProductCareInfo(
        _productCareInfoController.text);
    _blocV2.product.productCare = _productCareInfoController.text;
  }

  // controller listener function
  void _priceListener() {
    _uploadDesignDetailsFormBloc.changePrice(_priceController.text);
    _blocV2.product.price = _priceController.text;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController?.removeListener(_titleListener);
    _titleController?.dispose();
    _descController?.removeListener(_descListener);
    _descController?.dispose();
    _priceController?.removeListener( _priceListener );
    _priceController?.dispose();
    _productCareInfoController?.removeListener( _productCareInfoListener );
    _productCareInfoController?.dispose();
    selectedOccassions.clear();
    currencyList.clear();
  }

  void clearData() {
    selectedOccassions.clear();
    _titleController?.clear();
    _descController?.clear();
    _priceController?.clear();
    _productCareInfoController?.clear();
    _uploadDesignDetailsFormBloc.changeTitle('');

    /// keeping this setstate as whole view needs to be reset. we can remove this as well but better we keep it
    /// this is not going to be that costly as view is very small.
    setState(() {});
  }


  _onNextPressed() async {
    print('uploading... ID: ${productState.id}');
    print('PRODUCT TYPE ${_blocV2.product.productType}');
    _blocV2.dispatch( UploadDesignBlocEventUpdate(
        id: _blocV2.product.id,
        userId: Provider.of<UserStore>(context).details.id,
        title: _titleController.text,
        description: _descController.text,
        mainCategory: _blocV2.product.mainCategory,
        subCategory: _blocV2.product.subCategory,
        productCare: _blocV2.product.productCare,
      price: _blocV2.product.price.toString(),
        sizesInfo: _sizeSelectionInfo ?? _blocV2.product.sizesInfo,
        currency: _selectedCurrency,
        images: (imageChanging) ?
        _imagesToDisplayInCarousel.map<String>( (f) => f.path ).toList() :
          _blocV2.product.images,
    ));
    imageChanging = false;
    imagesToAdd.clear();
  }

  void _onSelectCurrency(value) {
    setState(
      () {
        /// have to setState. no need to use bloc pattern for the simple stuff
        /// can be change to bloc pattern in future.
        _selectedCurrency = value;
      },
    );
  }

  void _openSelectCat() {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        fullscreenDialog: true,
        builder: (BuildContext context) => SelectCat(
            productState.mainCategory.toLowerCase(),
            productState.subCategory.toLowerCase(),
            callback: _categorySelectionCallback),
      ),
    );
  }

  void _categorySelectionCallback(String mainCategory, String subcategory) async {
    if (subcategory.isNotEmpty )
      await _openSizesSelection(mainCategory, subcategory);
    Navigator.pop(context);
  }

  Future _openSizesSelection(String mainCategory, String subcategory){
    return Navigator.of(context).push(
      CupertinoPageRoute<bool>(
        fullscreenDialog: true,
        builder: (BuildContext context) => Provider<SelectSizeBloc>(
          builder: (context) => SelectSizeBloc()..init(context, mainCategory, subcategory,
            availableSizes: (subcategory.compareTo(_blocV2.product.subCategory) == 0 ) ?
              _blocV2.product.sizesInfo : null
          ),

          dispose: (context, bloc) => bloc.dispose(),

          child: SelectSizePage(mainCategory, subcategory,
            callback: (sizeSelectionInfo) {

            if (sizeSelectionInfo != null || sizeSelectionInfo.sizesText.isNotEmpty){
              print('Size SELECTED DETAILS TAB-> ${sizeSelectionInfo.sizesText} ${sizeSelectionInfo.sizeIndexesSelected}');
              _uploadDesignDetailsFormBloc.changeCategory( "$mainCategory -> $subcategory" );
              _sizeSelectionInfo = sizeSelectionInfo;

              _blocV2.product.mainCategory = mainCategory;
              _blocV2.product.subCategory = subcategory;
              _blocV2.product.sizesInfo = _sizeSelectionInfo;
//              _uploadDesignBloc.changeCategoryAndSizes(mainCategory,
//                  subcategory, _sizeSelectionInfo
//              );
            }

            },
          ),
        ),
      ),
    );
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
            autofocus: false,
            controller: _titleController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            radius: APP_INPUT_RADIUS,
            floatingLabel: Localization.of(context).title,
            leftPadding: 20.0,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            //onChanged: _uploadDesignDetailsFormBloc.changeTitle
        );
      });

  Widget descField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.desc,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).desc,
            floatingLabel: Localization.of(context).desc,
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
            //onChanged: _uploadDesignDetailsFormBloc.changeDesc
        );
      });

  Widget categoryTagsField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.category,
      initialData: "${productState.mainCategory} -> ${productState.subCategory}",
      builder: (context, snapshot) {
        Color color = secondaryColor;

        return Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              _openSelectCat();
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: awLightColor),
                  borderRadius: BorderRadius.circular(APP_INPUT_RADIUS)),
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    snapshot.data,
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

  Widget productCareField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.productCareInfo,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).productCare,
            floatingLabel: Localization.of(context).productCare,
            obscureText: false,
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.text,
            radius: APP_INPUT_RADIUS,
            textStyle: textStyle,
            leftPadding: 20.0,
            controller: _productCareInfoController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            bottomMargin: 15.0,
            errorText: snapshot.error,
//            onChanged: _uploadDesignDetailsFormBloc.changeProductCareInfo
        );
      });

  Widget priceField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.price,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: InputFieldV2(
                  hintText: Localization.of(context).price,
                  floatingLabel: Localization.of(context).price,
                  obscureText: false,
                  hintStyle: TextStyle(color: awLightColor),
                  textInputType: TextInputType.number,
                  textStyle: textStyle,
                  radius: APP_INPUT_RADIUS,
                  controller: _priceController,
                  textFieldColor: textFieldColor,
                  textAlign: TextAlign.left,
                  leftPadding: 20.0,
                  errorText: snapshot.error,
//                  onChanged: _uploadDesignDetailsFormBloc.changePrice
              ),
            ),
            SizedBox(width: 30.0),
            Flexible(flex: 1, child: selectCurrency()),
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

  // we're nothing using this.
  Widget buildSelectOccassion() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          VerticalSpace(30.0),
          Text(
            Localization.of(context).selectOccasion,
            style: textStyle,
            textAlign: TextAlign.left,
          ),
          VerticalSpace(20.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children:
                      occasionList.sublist(0, occasionList.length ~/ 2).map(
                    (item) {
                      return AwosheCheckBox(
                        item: item,
                        selectedColor: primaryColor,
                        unSelectedColor: awLightColor,
                        padding: 5.0,
                        stretchSpace: 10.0,
                        textStyle: textStyle14sec,
                        callback: () {
                          setState(() {
                            if (item.isSelected) {
                              item.isSelected = false;
                              this.selectedOccassions.remove(item.title);
                            } else {
                              item.isSelected = true;
                              this.selectedOccassions.add(item.title);
                            }
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: occasionList
                      .sublist(occasionList.length ~/ 2, occasionList.length)
                      .map(
                    (item) {
                      return AwosheCheckBox(
                        item: item,
                        selectedColor: primaryColor,
                        unSelectedColor: awLightColor,
                        padding: 5.0,
                        stretchSpace: 10.0,
                        textStyle: textStyle14sec,
                        callback: () {
                          setState(() {
                            if (item.isSelected) {
                              item.isSelected = false;
                              this.selectedOccassions.remove(item.title);
                            } else {
                              item.isSelected = true;
                              this.selectedOccassions.add(item.title);
                            }
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          VerticalSpace(30.0),
        ],
      );


  Widget nextButton() =>
      BlocBuilder<UploadDesignBlocV2, UploadDesignBlocStateV2>(
        bloc: _blocV2,
        condition: (_, current) =>
          current.eventType == UploadDesignBlocEventType.UPDATE,
        builder: (context, state){
          return AwosheButton(
            onTap: (state is  UploadDesignBlocStateBusy ) ? null : _onNextPressed,
            childWidget: (state is UploadDesignBlocStateBusy)
                ? DotSpinner()
                : Text(Localization.of(context).upload, style: buttonTextStyle),
            buttonColor: primaryColor,
          );
        },
      );

  Widget categoryButton() =>
    Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: _openSelectCat,

          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: awLightColor),
                borderRadius: BorderRadius.circular(APP_INPUT_RADIUS)),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Flexible(
                  child: Text(
                    '${productState.mainCategory} -> ${productState.subCategory}',
                    style: TextStyle(color: awLightColor, fontWeight: FontWeight.w600),
                  ),
                ),

                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20.0,
                  color: awLightColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  _addImageFromSource(ImageSource source) async {
    Navigator.pop(context);
    if ( _imagesToDisplayInCarousel.length == 3  ){
      ShowFlushToast(context, ToastType.ERROR,
          'A product can have only 3 images');
    }
    
    else {
      File newImage = await loadNewImage( source );
      if (newImage != null){
        _imagesToDisplayInCarousel.add(newImage);
        imageChanging = true;
        imagesToAdd.add( newImage );
        setState(() {});
      }
    }
  }

  _editImageFromSource(ImageSource source, int index) async {
    Navigator.pop(context);
    File newImage = await loadNewImage( source );
    if (newImage != null){
      _imagesToDisplayInCarousel[index] = newImage;
      setState(() {});
      imageChanging = true;
      imagesToAdd.add(newImage);
    }
  }

  _buildDesignTab(BuildContext context) => Container(
        color: Colors.white,
        child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ProductCarousel(
                      firstImageOrientation: productState.orientation,
                      imageList: _imagesToDisplayInCarousel,
                      onTap: (index){
                        print('index clicked $index');

                        Navigator.push(context, AwosheOverlayPageRoute(
                            child: Center(
                              child: DetailsTabModalEditMenu(
                                onAddFromGallery: () => _addImageFromSource(ImageSource.gallery),
                                onAddFromCamera: () => _addImageFromSource(ImageSource.camera),
                                onEditFromGallery: () => _editImageFromSource(ImageSource.gallery, index),
                                onEditFromCamera: () => _editImageFromSource(ImageSource.camera, index),
                              ),
                            )
                        ));
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        VerticalSpace(20.0),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right:8.0, bottom: 8.0),
                              child: Container(child: Text("Item No.: ${_blocV2.product.itemId} "),),
                            ),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: <Widget>[
                              titleField(),
                              descField(),

                              categoryButton(),

                              productCareField(),
//                              (widget.uploadType == UploadType.DESIGN)
//                                  ? categoryTagsField()
//                                  : Container(),
//
                              VerticalSpace(20.0),
                              priceField(),
                              (widget.uploadType == UploadType.FABRIC)
                                  ? buildSelectOccassion()
                                  : Container(),
                              VerticalSpace(20.0),
                              nextButton(),

                            ],
                          ),
                        ),
                        VerticalSpace(30.0),
                      ],
                    ),
                  ],
        ),
  );

  //TODO  This method must GO to BLoC file
  Future<File> loadNewImage(ImageSource source) async {
    String _error;
    ImageOrientation orientation;
    Future<File> imageFile;
    File originalImageFile;

    try {
      imageFile = ImagePicker.pickImage(source: source);
      if (imageFile != null) {
        await Future.delayed(Duration(milliseconds: 500));
//        _showLoading(true);
         originalImageFile = await imageFile;

        if (originalImageFile != null){
          // now we have the image
          // needs to know if image orientation is compatible
          // with carousel choice
          //if (widget.productData.feedType == 'SW'){
            // verify if image is in landscape mode
            var decodedImage = await decodeImageFromList(
                originalImageFile.readAsBytesSync());

            orientation = ImageUtils.resolveImageOrientation(decodedImage);


            if ( (productState.orientation == 'l') &&
                orientation != ImageOrientation.LANDSCAPE) {
//              _showLoading(false);
              print('incompatible LANDSCAPE MODE image'
                  'debug Image Width: ${decodedImage.width} X '
                  'Image Heigth ${decodedImage.height}');
              ShowFlushToast(context, ToastType.WARNING,
                  "Image for collection ${productState.feedType } must be landscape");
              return null;
            }

            if ( (productState.orientation == 'p') &&
                orientation != ImageOrientation.PORTRAIT) {
//              _showLoading(false);
              print('incompatible PORTRAIT MODE image'
                  'debug Image Width: ${decodedImage.width} X '
                  'Image Heigth ${decodedImage.height}');
              ShowFlushToast(context, ToastType.WARNING,
                  "Image for collection ${productState.feedType } must be portrait");
              return null;
            }

            if (orientation == ImageOrientation.UNDEFINED){
//              _showLoading(false);
              ShowFlushToast(context, ToastType.ERROR,
                  'Error with selected image');
              return null;
            }
        //  }
            
            if (orientation == ImageOrientation.PORTRAIT){
              originalImageFile = await ImageUtils.cropImage(originalImageFile,
                  ratioX: 3, ratioY: 4);
            }
            else {
              originalImageFile = await ImageUtils.cropImage(originalImageFile,
                  ratioX: 4, ratioY: 3);
            }
        }
      }
    }

    on PlatformException catch (e) {
      _error = e.message;
      print(_error);
    }
//    _showLoading(!isCropping);
    return originalImageFile;
  }

  @override
  Widget build(BuildContext context) => _buildDesignTab(context);

}


/// modal menu class
class DetailsTabModalEditMenu extends StatelessWidget {
  final VoidCallback onAddFromGallery;
  final VoidCallback onAddFromCamera;
  final VoidCallback onEditFromCamera;
  final VoidCallback onEditFromGallery;

  const DetailsTabModalEditMenu({Key key, this.onAddFromGallery,
    this.onEditFromCamera, this.onEditFromGallery, this.onAddFromCamera}) : super(key: key);

//  Widget _blurEffect(
//      {final double width,
//        final double,
//        height,
//        final double sigmaX = 10,
//        final double sigmaY = 15}) =>
//
//      BackdropFilter(
//        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
//        child: Container(
//          width: width,
//          height: height,
//          decoration: BoxDecoration(color: Colors.transparent),
//        ),
//      );

  @override
  Widget build(BuildContext context) {

    return Stack(
      overflow: Overflow.visible,
        children: <Widget>[
//          _blurEffect(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    /// add from camera
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FloatingActionButton(
                          backgroundColor: primaryColor,
                          child: Icon(Icons.add_a_photo, color: Colors.white,),
                          onPressed: onAddFromCamera,
                        ),
                        Center(
                          child: Text('Add From Camera', textAlign: TextAlign.center,
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                              style: textStyle.merge(TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),

                    /// add from galery
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FloatingActionButton(
                          backgroundColor: primaryColor,
                          child: Icon(Icons.add_photo_alternate, color: Colors.white,),
                          onPressed: onAddFromGallery,
                        ),
                        Center(
                          child: Text('Add From Gallery', textAlign: TextAlign.center,
                              style: textStyle.merge(TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      /// edit from camera
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: primaryColor,
                            child: Icon(Icons.camera, color: Colors.white,),
                            onPressed: onEditFromCamera,
                          ),
                          Text('Edit from Camera', textAlign: TextAlign.center, style: textStyle.merge(
                              TextStyle(color: Colors.white)),),
                        ],
                      ),

                      /// edit from gallery
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: primaryColor,
                            child: Icon(Icons.image, color: Colors.white,),
                            onPressed: onEditFromGallery,
                          ),
                          Text('Edit from Gallery', textAlign: TextAlign.center, style: textStyle.merge(
                              TextStyle(color: Colors.white)),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
