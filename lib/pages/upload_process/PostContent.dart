import 'dart:io';
import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/components/dropdown/awoshe_dropdown.dart';
import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/components/image_view/ImageView.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_details_form_bloc.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/pages/upload/create_feed_type.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/ImageUtils.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PostContent extends StatefulWidget {
  final UploadType uploadType;
  final ValueChanged<bool> onDoneCallback;

  const PostContent({
    Key key,
    this.onDoneCallback,
    this.uploadType = UploadType.DESIGN,
  }) : super(key: key);

  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  final defaultStyle = textStyle.copyWith(
      fontFamily: 'Muli', fontSize: 20.0, fontWeight: FontWeight.w600);
  final basicMargins = EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0);
  var text;

  TextEditingController _priceController;
  UploadStore store;

  @override
  void didChangeDependencies() {
    store ??= Provider.of<UploadStore>(context);
    _priceController ??= MoneyMaskedTextController(
        initialValue: PriceUtils.formatPriceToDouble(store.price ?? '0'),
        decimalSeparator: '.',
        thousandSeparator: ',');

    text ??= (store.productType == ProductType.DESIGN) ? 'design' : 'fabric';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print('Height: ${screenSize.height}');

    final layout = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: basicMargins,
              child: _collectionTextLabel(),
            ),
            // collection selection options
            _collectionSelectionOptions(),

            _productAvailableSection(),

            // SEPARATOR
            Container(
              width: screenSize.width,
              margin: EdgeInsets.only(bottom: 16.0),
              height: 1.5,
              color: awLightColor,
            ),

            // second column picture COLUMN SECTION
            _pictureSection(),

            //PRICING SECTION
            _pricingSection(screenSize),
          ],
        ),
      ],
    );

    return Observer(
      builder: (context) {
        return Stack(
          children: <Widget>[
            Scaffold(
              body: SingleChildScrollView(
                child: layout,
              ),
              floatingActionButton: FloatNextButton(
                title: 'Done',
                onPressed: () {
                  if (widget.onDoneCallback != null) {
                    widget.onDoneCallback(
                        store.uploadValidation(context)
                    );
                  }
                },
              ),
            ),
            (store.openImage)
                ? ModalAwosheLoading()
                : Container(
              width: .0,
              height: .0,
            )
          ],
        );
      },
    );
  }


  Widget _productAvailableSection() {
    return  Observer(
        builder: (_) =>
            Container(
              margin: basicMargins,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text('Product status', style: defaultStyle,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,

                    children: <Widget>[
                      Flexible(
                        child: RadioListTile(
                          title: Text('Available'),
                          value: true,
                          groupValue: store.isAvailable,
                          onChanged: (status) => store.setAvailable(status),

                        ),
                      ),

                      Flexible(
                        child: RadioListTile(
                          title: Text('Sold out'),
                          value: false,
                          groupValue: store.isAvailable,
                          onChanged: (status) => store.setAvailable(status),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _collectionTextLabel() =>
      Padding(
        padding: const EdgeInsets.only(bottom:20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: RichText(
                maxLines: 6,
                //textAlign: TextAlign.justify,
                text: TextSpan(
                    style: textStyle2.copyWith(color: awBlack),
                    text: 'Is this $text part of a collection or single design? ',
                    children: <TextSpan>[
                      TextSpan(
                        style: textStyle2.copyWith(color: awLightColor,),
                        text: 'e.g Summer \'19',
                      ),
                      TextSpan(
                        text: ' Tap New to create new collections',
                        style: textStyle2.copyWith(color: awBlack),
                      )
                    ]),
              ),
            ),
          ],
        ),
      );

  Widget _collectionSelectionOptions() =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Observer(
                builder: (context) {
                  return AwosheDropdown(
                    color: awLightColor,
                    options:
                    store.collections.map<String>((c) => c.title).toList(),
                    radius: APP_INPUT_RADIUS,
                    hintStyle: hintStyle,
                    selectedValue: store.selectedCollection.title,
                    onChange: (selected) {
                      if (selected != store.selectedCollection.title) {
                        store.setCollection(selected);
                      }
                    },
                  );
                },
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Tooltip(
                message: 'Create a new collection',
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          style: BorderStyle.solid,
                          color: primaryColor,
                          width: 1.0),
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute<bool>(
                        fullscreenDialog: true,
                        builder: (BuildContext context) =>
                            Provider<UploadDesignBlocV2>(
                              builder: (_) => UploadDesignBlocV2(),
                              child: CreateFeedType(
                                uploadDesignDetailsFormBloc:
                                UploadDesignDetailsFormBloc(),
                              ),
                            ),
                      ),
                    );
                  },
                  child: Text(
                    'New',
                    style: textStyle.copyWith(color: primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _pictureSection() =>
      Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Add photos of your $text',
                    style: textStyle2.copyWith(color: awBlack),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Photos help customer imagine the look of '
                        'the design. You can start with one and '
                        'add 2 more after you publish.',
                    style: textStyle.copyWith(color: awLightColor),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // picture selector
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
            child: Observer(
              builder: (context) {
                //print('Buiding ${store.images.length}');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    3,
                        (index) =>
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: ImageView(
                              imageUrl: (store.images[index].isEmpty)
                                  ? null
                                  : store.images[index],
                              onDelete: () {
                                store.addImage(index, '');
                              },
                              onTap: () async {
                                await loadAssets(index, ImageSource.gallery);
                              },
                            ),
                          ),
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      );

  Widget _pricingSection(Size screenSize) {
    var localText = (store.productType == ProductType.DESIGN)
        ? 'Price your design'
        : 'Price your fabric / yard or meter.';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8.0,
              ),
              child: Text(
                localText,
                style: textStyle2.copyWith(color: awBlack),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        (store.productType == ProductType.DESIGN)
            ? Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                width: screenSize.width / 2,
                child: _priceTextField(screenSize)),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                width: screenSize.width / 2,
                child: _currencyDropButton(screenSize)),
          ],
        )
            : Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Container(
                        width: screenSize.width / 3,
                        child: _priceTextField(screenSize)),
                  ),
                  Flexible(
                    child: Container(
                        width: screenSize.width / 3,
                        child: _currencyDropButton(screenSize)),
                  ),
                ],
              ),
              Container(
                  width: screenSize.width / 2,
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  child: _unitChoiceField()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _priceTextField(Size screenSize) =>
      InputFieldV2(
        hintText: '0.00',
        obscureText: false,
        focusNode: AlwaysDisabledFocusNode(),
        onTap: (){
          Navigator.push(context,
            TextFieldPageRoute(

              page: TextFieldPage(
                title: 'Price',
                initialText: store.price ?? '',
                hint: '0.00',
                maxLines: 4,
                inputType: TextInputType.text,
                onDone: (data) {
                  _priceController.text = data;
                  store.setPrice(_priceController.text);

                  Navigator.pop(context);
                },
                fieldDecoration: FieldDecoration.ROUNDED,
              ),
            ),
          );
        },

        hintStyle: TextStyle(color: awLightColor),
        textStyle: textStyle2.copyWith(fontSize: 22),
        controller: _priceController,
        radius: APP_INPUT_RADIUS,
        errorText: store.titleErrorMsg,
        maxLines: 1,
        textFieldColor: textFieldColor,
        textAlign: TextAlign.center,
        bottomMargin: 15.0,
        leftPadding: 20.0,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.numberWithOptions(decimal: true,),
      );

  Widget _currencyDropButton(Size screenSize) =>
      Observer(
        builder: (_) =>
            AwosheDropdown(
              color: awLightColor,
              options: CURRENCIES,
              radius: APP_INPUT_RADIUS,
              hintStyle: hintStyle,
              selectedValue: store.selectedCurrency,
              onChange: store.setCurrency,
        ),
      );

  Widget _unitChoiceField() =>
      Observer(
        builder: (_) =>
            AwosheDropdown(
              color: awLightColor,
              options: DISTANCE_UNITS,
              radius: APP_INPUT_RADIUS,
              hintStyle: hintStyle,
              selectedValue: store.selectedDistanceUnit,
              onChange: store.setDistanceUnit,
            ),
      );

  // TODO this method MUST leave this class.
  Future<void> loadAssets(int index, ImageSource source) async {
    String _error;
    ImageOrientation orientation;
    Future<File> imageFile;

    try {
      imageFile = ImagePicker.pickImage(source: source);
      if (imageFile != null) {
        await Future.delayed(Duration(milliseconds: 500));
        store.setOpenImage(true);
        var originalImageFile = await imageFile;

        if (originalImageFile != null) {
          var decodedImage =
            await decodeImageFromList(originalImageFile.readAsBytesSync());
            orientation = ImageUtils.resolveImageOrientation(decodedImage);

          // now we have the image
          // needs to know if image orientation is compatible
          // with carousel choice. 
          if (store.selectedCollection.displayType == FeedType.SW) {

            // verify if image is in landscape mode
            if ((store.selectedCollection.orientation == 'LD') &&
                orientation != ImageOrientation.LANDSCAPE) {
              store.setOpenImage(false);
              print('incompatible LANDSCAPE MODE image'
                  'debug Image Width: ${decodedImage.width} X '
                  'Image Heigth ${decodedImage.height}');
              ShowFlushToast(context, ToastType.WARNING,
                  "Selected image isn't lanscape mode!");
              return;
            }

            if ((store.selectedCollection.orientation == 'PT') &&
                orientation != ImageOrientation.PORTRAIT) {
              store.setOpenImage(false);

              print('incompatible PORTRAIT MODE image'
                  'debug Image Width: ${decodedImage.width} X '
                  'Image Heigth ${decodedImage.height}');
              ShowFlushToast(context, ToastType.WARNING,
                  "Selected image isn't portrait mode!");
              return;
            }

            if (orientation == ImageOrientation.UNDEFINED) {
              store.setOpenImage(false);
              ShowFlushToast(
                  context, ToastType.ERROR, 'Error with selected image');
              return;
            }
          } 
         
          else if (store.selectedCollection.displayType == FeedType.SINGLE){
            if (store.firstImageOrientation == null)
              store.firstImageOrientation = orientation;
            
            else if (store.firstImageOrientation != orientation){
              store.setOpenImage(false);
              ShowFlushToast(
                  context, ToastType.ERROR, 'The images must have the same orientation.');
              return;
            }
            print('Print the type is single...');
          }

          originalImageFile = await ImageUtils.cropImage(originalImageFile,
              ratioX: store.selectedCollection.ratioX,
              ratioY: store.selectedCollection.ratioY);

          if (originalImageFile != null) {
            store.addImage(index, originalImageFile.path);
          }
        }
      }
    } 
    
    on PlatformException catch (e) {
      _error = e.message;
      print(_error);
    }
    store.setOpenImage(false);
    //_showLoading(!isCropping);
  }
}
