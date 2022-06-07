import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FabricContent extends StatefulWidget {
  final ValueChanged<bool> nextCallback;

  const FabricContent({
    Key key,
    this.nextCallback,
  }) : super(key: key);

  @override
  _FabricContentState createState() => _FabricContentState();
}

class _FabricContentState extends State<FabricContent> {
  UploadStore store;
  UserStore userStore;

  //final FabricStore fabricStore = FabricStore();
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    userStore = Provider.of<UserStore>(context, listen: false);
    //fabricStore.fetchFabrics(userStore.details.id);
  }

  @override
  void didChangeDependencies() {
    store ??= Provider.of<UploadStore>(context);
    _controller ??= TextEditingController(text: store.fabricTags);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final body = Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'If you have uploaded some fabrics'
                        ' you made your design with, please add'
                        ' the item numbers here separeted by comma.',
                        maxLines: 4,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle2.copyWith(color: awBlack),
                      ),
                    ),
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
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
                  ),
                ],
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: _productCareField(store),
        ),

        // GRID APPROACH
//        Observer
//          (builder: (context) {
//            return (fabricStore.isLoading)
//              ? AwosheLoadingV2()
//              : _fabricsWidget();
//        }),

        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
      ],
    );

    return Scaffold(
      body: body,
      floatingActionButton: FloatNextButton(
        title: Localization.of(context).next,
        onPressed: () {
          if (widget.nextCallback != null) {
//            store.isFabricValid()
            widget.nextCallback(true);
            //widget.nextCallback(store.fabricsId.isNotEmpty);
          }
        },
      ),
    );
  }

  // TODO: will be used soon.

//  Widget _fabricsWidget() =>
//      (fabricStore.fabrics.isEmpty)
//          ?
//      NoDataAvailable(message: 'No Fabrics Available',)
//          :
//      Container(
//        margin: EdgeInsets.only(left: 24.0),
//        child: Observer(
//          builder: (context) {
//            return GridView.builder(
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 3,
//              ),
//              itemCount: fabricStore.fabrics.length,
//              shrinkWrap: true,
//              itemBuilder: (context, index) {
//
//                return Observer(
//                  builder: (_) =>
//                      CircleSelectableImageView(
//                        imageUrl: fabricStore.fabrics[index].imageUrl,
//                        isChecked: (store.fabricsId.contains(
//                            fabricStore.fabrics[index].id)),
//                        onChanged: (isSelected) {
//                          if (isSelected)
//                            store.addFabric(fabricStore.fabrics[index].id);
//                          else
//                            store.removeFabric(fabricStore.fabrics[index].id);
//                        },
//                      ),
//                );
//              },
//            );
//          },
//        ),
//      );

  Widget _productCareField(UploadStore store) => Observer(
        builder: (_) => InputFieldV2(
          hintText: 'Available fabric tags separated by comma',
          obscureText: false,
          focusNode: AlwaysDisabledFocusNode(),
          onTap: () {
            Navigator.push(
              context,
              TextFieldPageRoute(
                page: TextFieldPage(
                  title: 'Fabric',
                  initialText: store.fabricTags ?? '',
                  hint:'Available fabric tags separated by comma',
                  maxLines: 2,
                  inputType: TextInputType.text,
                  onDone: (data) {
                    _controller.text = data;
                    store.setFabricTags(_controller.text);
                    Navigator.pop(context);
                  },
                  fieldDecoration: FieldDecoration.ROUNDED,
                ),
              ),
            );
          },
          hintStyle: TextStyle(color: awLightColor),
          textInputType: TextInputType.text,
          errorText: store.fabricErrorMsg,
          textStyle: textStyle,
          controller: _controller,
          radius: APP_INPUT_RADIUS,
          maxLines: 1,
          textFieldColor: textFieldColor,
          textAlign: TextAlign.left,
          bottomMargin: 15.0,
          leftPadding: 20.0,
        ),
      );
}
