import 'dart:io';
import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/carousel/carousel.dart';
import 'package:Awoshe/components/checkbox/checkbox.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/upload/SelectSizeBloc.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_state_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_details_form_bloc.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_event_v2.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/models/product/product_color.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:Awoshe/models/upload.dart';
import 'package:Awoshe/pages/upload/selectsize.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:Awoshe/widgets/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// TODO this widget needs BLoC component
class CustomizedAndBothTab extends StatefulWidget {
  CustomizedAndBothTab(
      {Key key,
      this.productType,
      this.designImages,
      this.orderType,
      this.productData,
      this.uploadDesignFormBloc})
      : super(key: key);

  final Product productData;
  final List<File> designImages;
  final ProductType productType;
  final OrderType orderType;
  final UploadDesignDetailsFormBloc uploadDesignFormBloc;

  @override
  _CustomizedAndBothTabState createState() => new _CustomizedAndBothTabState();
}

class _CustomizedAndBothTabState extends State<CustomizedAndBothTab> {
  TextEditingController _otherInfosController;
  TextEditingController _productCareInfoController;

  UploadDesignBlocV2 _blocV2;
  UploadDesignDetailsFormBloc _uploadDesignDetailsFormBloc;
  String _selectedSize;

  List<SelectableItem> occasionList = List<SelectableItem>();
  List<SelectableItem> measurementsList = List();
  List<String> selectedProductColors = List<String>();
  List<String> selectedTags = List<String>();
  List<String> selectedOccassions = <String>[];
  List<String> selectedMeasurements = <String>[];

  List<Product> allFabrics = List();
  String sizeMainCategory, currentCategoryTitle;
  int currentSizeIndex = -1;
  SizeSelectionInfo selectedSizesInfo;
  static const SELECT_SIZES = "Select sizes...";
  List<ProductColor> productColors;
  List<ProductColor> allColors = AppData.getProductDefaultColors();

  @override
  void initState() {
    super.initState();
    _otherInfosController = TextEditingController(text: widget.productData.otherInfos);
    _productCareInfoController = TextEditingController();

    _uploadDesignDetailsFormBloc = widget.uploadDesignFormBloc;
    occasionList = AppData.occasions();
    measurementsList = AppData.customMeasurements();

    _selectedSize = (widget.productData.sizesInfo == null)
        ?  SELECT_SIZES : widget.productData.sizesInfo.sizesText;
    selectedSizesInfo = widget.productData.sizesInfo;

    productColors = widget.productData.availableColors.length > 0 ?
    Utils.getListWithProductColor(
        Utils.uniqueList( widget.productData.availableColors ?? [] ) )
        : allColors;

    selectedProductColors = productColors.map<String>( (color) => color.name ).toList();
  }

  @override
  void didChangeDependencies() {
    _blocV2 ??= Provider.of<UploadDesignBlocV2>(context);
    super.didChangeDependencies();
  }


  @override
  void dispose() {
    super.dispose();
    _otherInfosController.dispose();
    _productCareInfoController.dispose();
    selectedTags.clear();
    selectedOccassions.clear();
    selectedProductColors.clear();
    selectedMeasurements.clear();
    allFabrics.clear();
  }

  void _onUploadPressed() {
    _blocV2.dispatch( UploadDesignBlocEventUpdate(
        id: _blocV2.product.id,
        userId: Provider.of<UserStore>(context).details.id,
        otherInfos:  _otherInfosController.text,
        availableColors: selectedProductColors,
        fabricTags: selectedTags,
        sizesInfo: selectedSizesInfo,
        customMeasurements: selectedMeasurements,
        occassions: selectedOccassions,
    ));
//    var product = _uploadDesignBloc.productState;
//    _uploadDesignBloc.dispatch(UploadDesignEventDesignUpload(
//        event: UploadDesignEventType.update_product,
//        orderType: Utils.getOrderType(widget.orderType),
//        otherInfos: _otherInfosController.text ?? null,
//        availableColors: selectedProductColors ?? [],
//        images: product.images.map( (img) => File(img) ).toList(),
//        sizeInfo: product.availableSizes,
//        id: product.id,
//        fabricTags: selectedTags ?? [],
//        fabricOccassion: selectedOccassions ?? [],
//        currentSizeIndex: currentSizeIndex,
//        customMeasurements: selectedMeasurements ?? []));
  }

  void _openSelectSize() {

    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        fullscreenDialog: true,

        builder: (BuildContext context) => Provider<SelectSizeBloc>(
          builder: (context){
            var bloc = SelectSizeBloc();
            bloc.init(context, _blocV2.product.mainCategory,
                _blocV2.product.subCategory,
                availableSizes: _blocV2.product.sizesInfo);
            return bloc;
          },

          dispose: (_, bloc) => bloc.dispose(),

          child: SelectSizePage(
            widget.productData.mainCategory,
            widget.productData.subCategory,
            callback: _updateSelectedSizesText,
          ),
        ),
      ),
    );
  }

  void _updateSelectedSizesText(SizeSelectionInfo info){
    _selectedSize = SELECT_SIZES;
    if (info != null) {
      _blocV2.product.sizeText = info.sizesText;
      selectedSizesInfo = info;
      setState(() {});
    }
  }

  Widget selectSize() => BlocBuilder<UploadDesignBlocV2, UploadDesignBlocStateV2>(

    builder: (context, state) {
      _selectedSize = _blocV2.product.sizeText;

      return Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => _openSelectSize(),
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
                    _selectedSize ?? SELECT_SIZES,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: awLightColor, fontWeight: FontWeight.w600),
                  ),
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
    }
  );

//  Widget colorField() => ChipsInput(
//          initialValue: productColors,
//          decoration: InputDecoration(
//            border: OutlineInputBorder(
//              borderRadius: BorderRadius.all(
//                Radius.circular(APP_INPUT_RADIUS),
//              ),
//            ),
//            fillColor: Colors.white,
//            hintStyle: TextStyle(
//              color: awLightColor,
//            ),
//            hintText: Localization.of(context).availableColor,
//            contentPadding: EdgeInsets.only(bottom: 10.0, top: 8.0, left: 20.0),
//            // filled: true,
//          ),
//          findSuggestions: (String query) {
//            if (query.length != 0) {
//              var lowercaseQuery = query.toLowerCase();
//              return allColors.where((colorItem) {
//                return colorItem.name
//                    .toLowerCase()
//                    .contains(query.toLowerCase());
//              }).toList(growable: false)
//                ..sort((a, b) => a.name
//                    .toLowerCase()
//                    .indexOf(lowercaseQuery)
//                    .compareTo(b.name.toLowerCase().indexOf(lowercaseQuery)));
//            } else {
//              return const <ProductColor>[];
//            }
//          },
//          onChanged: (data) {
//            selectedProductColors = data.map<String>( (colorItem) => colorItem.name ).toList();
//            print('ChipInput on change $selectedProductColors');
//            //data.forEach((color) => selectedColors.add(color.name));
//          },
//          chipBuilder: (context, state, colorItem) {
//            return InputChip(
//              autofocus: false,
//              key: ObjectKey(colorItem),
//              label: Text(colorItem.name),
//              avatar: CircleAvatar(
//                child: DotColor(
//                  color: colorItem.code,
//                ),
//              ),
//              onDeleted: () {
//                state.deleteChip(colorItem);
//              },
//              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//            );
//          },
//          suggestionBuilder: (context, state, colorItem) {
//            print(colorItem.toString());
//            return ListTile(
//              key: ObjectKey(colorItem),
//              leading: DotColor(
//                color: colorItem.code,
//              ),
//              title: Text(colorItem.name),
//              subtitle: Text(colorItem.name),
//              dense: true,
//              onTap: () => state.selectSuggestion(colorItem),
//            );
//          },
//        );

//  Widget fabricField() => ChipsInput(
//        initialValue: [],
//        decoration: InputDecoration(
//          border: OutlineInputBorder(
//            borderRadius: BorderRadius.all(
//              Radius.circular(APP_INPUT_RADIUS),
//            ),
//          ),
//          fillColor: Colors.white,
//          hintStyle: TextStyle(
//            color: awLightColor,
//          ),
//          hintMaxLines: 3,
//
//          hintText: Localization.of(context).availableFabrics,
//          contentPadding: EdgeInsets.only(bottom: 10.0, top: 8.0, left: 20.0),
//          // filled: true,
//        ),
//        findSuggestions: (String query) {
//          if (query.length != 0 && allFabrics.length > 0) {
//            var lowercaseQuery = query.toLowerCase();
//            return allFabrics.where((categoryItem) {
//              return categoryItem.title
//                  .toLowerCase()
//                  .contains(query.toLowerCase());
//            }).toList(growable: false)
//              ..sort((a, b) => a.title
//                  .toLowerCase()
//                  .indexOf(lowercaseQuery)
//                  .compareTo(b.title.toLowerCase().indexOf(lowercaseQuery)));
//          } else {
//            return const <Product>[];
//          }
//        },
//        onChanged: (data) {
//          data.forEach((tag) => selectedTags.add(tag.productId));
//        },
//        chipBuilder: (context, state, fabricItem) {
//          return InputChip(
//            key: ObjectKey(fabricItem),
//            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
//            label: Text(""),
//            backgroundColor: awLightColor300,
//            avatar: fabricItem.images != null ? Image.network(fabricItem.images[0], height: 20.0, width: 40.0,): Container(),
//            onDeleted: () => state.deleteChip(fabricItem),
//            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//          );
//        },
//        suggestionBuilder: (context, state, fabricItem) {
//          print(fabricItem.images);
//          return ListTile(
//            key: ObjectKey(fabricItem),
//            title: Text(fabricItem.headerTitle),
//            leading: fabricItem.images != null ? Container(
//              child: Image.network(fabricItem.images[0], height: 30.0, width: 30.0,),
//            ) : Container(),
//            subtitle: Text(fabricItem.itemId),
//            dense: true,
//            onTap: () => state.selectSuggestion(fabricItem),
//          );
//        },
//      );

  Widget otherInfoField() => StreamBuilder<String>(
      stream: _uploadDesignDetailsFormBloc.otherInfos,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).otherInfo,
            obscureText: false,
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            radius: APP_INPUT_RADIUS,
            leftPadding: 20.0,
            controller: _otherInfosController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: _uploadDesignDetailsFormBloc.changeOtherInfos);
      });

  Widget buildCustomMeasurements() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  measurementsList.sublist(0, measurementsList.length ~/ 2).map(
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
                          this.selectedMeasurements.remove(item.title);
                        } else {
                          item.isSelected = true;
                          this.selectedMeasurements.add(item.title);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: measurementsList
                  .sublist(
                      measurementsList.length ~/ 2, measurementsList.length)
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
                          this.selectedMeasurements.remove(item.title);
                        } else {
                          item.isSelected = true;
                          this.selectedMeasurements.add(item.title);
                        }
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ],
      );

  Widget selectOccasions() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: occasionList.sublist(0, occasionList.length ~/ 2).map(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
      );

  Widget nextButton(UploadDesignBlocStateV2 state) =>
      BlocBuilder<UploadDesignBlocV2, UploadDesignBlocStateV2>(
        bloc: _blocV2,
        condition: (previous, current) => (current.eventType == UploadDesignBlocEventType.UPDATE),
        builder: (context, state) =>
        AwosheButton(
          onTap: (state is UploadDesignBlocStateBusy) ? null : _onUploadPressed,
          childWidget: (state is UploadDesignBlocStateBusy) ? DotSpinner() :
            Text(Localization.of(context).upload, style: buttonTextStyle),
          buttonColor: primaryColor,
        ),
  );

  Widget _buildStandardOrder() => Column(
        children: <Widget>[
          VerticalSpace(15.0),
          selectSize(),
          VerticalSpace(15.0),
//          colorField(),
          VerticalSpace(15.0),
//          fabricField(),
          VerticalSpace(15.0),
          otherInfoField(),
          VerticalSpace(15.0),
        ],
      );

  Widget _buildCustomOrder() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          widget.orderType == OrderType.BOTH
              ? Divider(height: 3.0, color: secondaryColor)
              : Container(),
          VerticalSpace(20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  Localization.of(context).customMeasurementsNeeded,
                  style: textStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 30.0,
                width: 60.0,
                child: AwosheRaisedButton(
                  childWidget: Text(
                    Localization.of(context).help,
                    style: textStyle14sec,
                  ),
                  onTap: () {},
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  buttonColor: awYellowColor,
                ),
              )
            ],
          ),
          VerticalSpace(20.0),
          buildCustomMeasurements(),
          VerticalSpace(30.0),
          Text(
            Localization.of(context).selectOccasion,
            style: textStyle,
            textAlign: TextAlign.left,
          ),
          VerticalSpace(20.0),
          selectOccasions(),
        ],
      );

  _buildCustomizedAndBothTab(BuildContext context, UploadDesignBlocStateV2 state) =>
      Container(
        color: Colors.white,

        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.orderType == OrderType.BOTH
                  ? Container(
                      color: Colors.white,
                      height: 200.0,
                      width: double.infinity,
                      child: Carousel(
                        fromMemory: false,
                        radius: Radius.circular(0.0),
                        boxFit: BoxFit.cover,
                        images: widget.designImages != null
                            ? widget.designImages
                                .map((File _image) => _image.path)
                                .toList()
                            : [PLACEHOLDER_DESIGN_IMAGE],
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotColor: Colors.white,
                        indicatorBgPadding: 5.0,
                        dotBgColor: Colors.transparent,
                        borderRadius: false,
                      ),
                    )
                  : Container(),

              VerticalSpace(10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:8.0, bottom: 8.0),
                    child: Container(child: Text("Item No.: ${widget?.productData?.itemId} "),),
                    ),
                ],
                ),


              Container(
                color: Colors.white,
                padding: widget.orderType == OrderType.BOTH
                    ? EdgeInsets.symmetric(horizontal: 25.0)
                    : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    widget.orderType == OrderType.BOTH
                        ? VerticalSpace(0.0)
                        : Container(),
                    (widget.orderType == OrderType.BOTH ||
                            widget.orderType == OrderType.STANDARD)
                        ? _buildStandardOrder()
                        : Container(),
                    (widget.orderType == OrderType.BOTH ||
                            widget.orderType == OrderType.CUSTOM)
                        ? _buildCustomOrder()
                        : Container(),
                    VerticalSpace(30.0),
                    nextButton(state),
                    VerticalSpace(20.0),
                  ],
                ),
              ),
            ]),
      );

  /// set product data if available while edit mode
  setProductData() async {
    _productCareInfoController.text = widget?.productData?.productCare;
    _otherInfosController.text = widget?.productData?.otherInfos;
    currentSizeIndex = widget?.productData?.currentSizeIndex?.toInt();
  }

  @override
  Widget build(BuildContext context) {
    setProductData();

    return BlocListener<UploadDesignBlocV2, UploadDesignBlocStateV2>(
        bloc: _blocV2,
        listener: (context, state){},
        child: BlocBuilder<UploadDesignBlocV2, UploadDesignBlocStateV2>(
            builder: (BuildContext context, UploadDesignBlocStateV2 state) {
              return _buildCustomizedAndBothTab(context, state);
            }
        ),
    );
  }
}
