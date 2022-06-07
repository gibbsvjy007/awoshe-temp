import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/checkbox/checkbox.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_state_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_details_form_bloc.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_event_v2.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/upload.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../utils/assets.dart';

class CreateFeedType extends StatefulWidget {
  final UploadDesignDetailsFormBloc uploadDesignDetailsFormBloc;
  final Function collNameCallBack;

  CreateFeedType(
      { this.uploadDesignDetailsFormBloc,
        this.collNameCallBack});

  @override
  _CreateFeedTypeState createState() => _CreateFeedTypeState();
}

class _CreateFeedTypeState extends State<CreateFeedType> {
  TextEditingController _nameController, _descController;
  SelectableItem _feedTypeTH = SelectableItem(title: null, isSelected: true);
  SelectableItem _feedTypeSW = SelectableItem(title: null, isSelected: false);
  SelectableItem _portraitOption = SelectableItem(title: null, isSelected: true);
  SelectableItem _landscapeOption = SelectableItem(title: null, isSelected: false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FeedType selectedFeedType = FeedType.TH;
  String _imageOrientation = 'PT'; // PT = Portrait, LD = Landscape
  int ratioX = 3, ratioY = 4;
  UploadDesignBlocV2 _blocV2;

  UploadStore store;
  @override
  void didChangeDependencies() {
    _blocV2 ??= Provider.of<UploadDesignBlocV2>(context);
    store ??= Provider.of<UploadStore>(context);
    
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController?.dispose();
    _descController?.dispose();
  }

  void onFeedSelectTH() {
    setState(() {
      if (_feedTypeTH.isSelected) {
        _feedTypeTH.isSelected = false;
        _feedTypeSW.isSelected = true;
        selectedFeedType = FeedType.SW;

      } else {
        _feedTypeTH.isSelected = true;
        _feedTypeSW.isSelected = false;
        selectedFeedType = FeedType.TH;
        _imageOrientation = null;
      }

    });
  }

  void onFeedSelectSW() {
    setState(() {
      if (_feedTypeSW.isSelected) {
        _feedTypeSW.isSelected = false;
        _feedTypeTH.isSelected = true;
        selectedFeedType = FeedType.TH;
      } else {
        _feedTypeSW.isSelected = true;
        _feedTypeTH.isSelected = false;
        selectedFeedType = FeedType.SW;
      }

    });
  }

  void _onPortraitSelected() {
    setState(() {
      if (_portraitOption.isSelected){
        _portraitOption.isSelected = false;
        _landscapeOption.isSelected = true;
      } else {
        _portraitOption.isSelected = true;
        _landscapeOption.isSelected = false;
      }
    });

  }

  void _onLandscapeSelected(){
    setState(() {
      if (_landscapeOption.isSelected){
        _landscapeOption.isSelected = false;
        _portraitOption.isSelected = true;
        _imageOrientation = 'PT';

      } 
      else {
        _landscapeOption.isSelected = true;
        _portraitOption.isSelected = false;
        _imageOrientation = 'LD';
      }
    });
  }

  Widget buildNameFields() => StreamBuilder<String>(
      stream: widget.uploadDesignDetailsFormBloc.collectionName,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).collectionName,
            obscureText: false,
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            controller: _nameController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            radius: APP_INPUT_RADIUS,
            leftPadding: 20.0,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: widget.uploadDesignDetailsFormBloc.changeCollectionName);
      });

  Widget buildCollectionDescription() => StreamBuilder<String>(
      stream: widget.uploadDesignDetailsFormBloc.collectionDesc,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).desc,
            obscureText: false,
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            controller: _descController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            radius: APP_INPUT_RADIUS,
            leftPadding: 20.0,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: widget.uploadDesignDetailsFormBloc.changeCollectionDesc);
      });

  Widget buildSaveButton() =>
      BlocBuilder<UploadDesignBlocV2, UploadDesignBlocStateV2>(
        condition: (previous, current){
          if (current.eventType == UploadDesignBlocEventType.UPLOAD) {
            if (current is UploadDesignBlocUploadCollectionSuccess)
              return true;
            if (current is UploadDesignBlocUploadCollectionBusy)
              return true;

            if (current is UploadDesignBlocUploadCollectionFail)
              return true;
          }
          return false;
        },
        builder: (context, state) =>
            AwosheButton( // create a new state for busy when read product and collection
              onTap: (state is UploadDesignBlocUploadCollectionBusy) ? null : _saveCollection,
              childWidget: (state is UploadDesignBlocUploadCollectionBusy) ? DotSpinner() :
              Text(Localization.of(context).save,
                  style: buttonTextStyle), buttonColor: primaryColor,
            )
      );

  @override
  Widget build(BuildContext context) {
    print('Current feed type selected: $selectedFeedType');
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Creating a collection"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  buildNameFields(),
                  SizedBox(height: 20.0),
                  buildCollectionDescription(),
                  SizedBox(height: 20.0),
                  Text(Localization.of(context).displayType, style: textStyle),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Flexible(
                        fit: FlexFit.loose,
                        child: _createDisplayTypeOption(Localization.of(context).thumbnail,
                            _feedTypeTH, Assets.thumbnails,onFeedSelectTH,),
                      ),

                      Flexible(
                        fit: FlexFit.loose,
                        child: _createDisplayTypeOption(Localization.of(context).carousel,
                            _feedTypeSW, Assets.carousel, onFeedSelectSW),
                      ),
                    ],
                  ),

                  (_feedTypeSW.isSelected) ? AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: 1200),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 15.0),
                                color: awLightColor,
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                            ),

                            Text('Carousel Image Orientation', style: textStyle, textAlign: TextAlign.center,),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[

                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: _createDisplayTypeOption(Localization.of(context).portrait,
                                          _portraitOption, Assets.portrait, _onPortraitSelected),
                                  ),

                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: _createDisplayTypeOption(Localization.of(context).landscape,
                                        _landscapeOption, Assets.landscape, _onLandscapeSelected),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                  ) : AnimatedOpacity(
                    opacity: .0,
                    duration: Duration(milliseconds: 1200),
                    child: Container(height: 30,),
                  ),

                  Container(
                      width: width/2,
                      child: buildSaveButton()
                  ),

                  BlocListener<UploadDesignBlocV2, UploadDesignBlocStateV2>(
                    bloc: _blocV2,
                    condition: (previous, current){
                      if (current is UploadDesignBlocUploadCollectionSuccess ||
                          current is UploadDesignBlocUploadCollectionFail)
                        return true;

                      return false;
                    },
                    listener: (context, state){
                      if (state is UploadDesignBlocUploadCollectionSuccess) {
                        store.addCollection(_blocV2.collections[1]);
                        ShowFlushToast(context, ToastType.SUCCESS,
                            "Collection Created Successfully");
                      }
                      if (state is UploadDesignBlocUploadCollectionFail)
                        ShowFlushToast(context, ToastType.ERROR, "${state.message}");
                    },
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createDisplayTypeOption(final String title, final SelectableItem item,
      final String iconData, final void Function() onTap ){
    return GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            AwosheCheckBox(
                item: item,
                selectedColor: primaryColor,
                unSelectedColor: awLightColor,
                padding: 4.0,
                stretchSpace: 10.0,
                textStyle: textStyle14sec,
                callback: onTap
            ),
            SvgIcon(
              iconData,
              size: 22.0,
              color: awLightColor,
            ),
            Text(
              title,
              style: hintStyle,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
    );
  }

  void _saveCollection() {

    if (_feedTypeSW.isSelected){
      selectedFeedType = FeedType.SW;
      if(_portraitOption.isSelected){
        _imageOrientation = 'PT';
        ratioX = 3;
        ratioY = 4;
      }

      else {
        _imageOrientation = 'LD';
        ratioX = 4;
        ratioY = 3;
      }
    }
    // just for sure
    else {
      selectedFeedType = FeedType.TH;
      _imageOrientation = ratioX = ratioY = null;
    }

    _blocV2.dispatch(
          UploadDesignBlocEventUploadCollection(
              UploadDesignBlocEventType.UPLOAD,
              userId: Provider
                  .of<UserStore>(context)
                  .details
                  .id,
              title: _nameController.text,
              description: _descController.text,
              ratioX: ratioX,
              ratioY: ratioY,
              orientation: _imageOrientation,
              displayType: selectedFeedType
          )
      );

    //widget.collNameCallBack(selectedFeedType, _nameController.text);
  }
}
