import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TitleDescriptionPage extends StatefulWidget {
  final UploadType uploadType;

  final ValueChanged<bool> nextCallback;


  const TitleDescriptionPage({Key key, this.nextCallback,
    this.uploadType = UploadType.DESIGN,}) : super(key: key);

  @override
  _TitleDescriptionPageState createState() =>
      _TitleDescriptionPageState();
}

class _TitleDescriptionPageState extends State<TitleDescriptionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  UploadStore store;
  TextEditingController _titleController, _descController;

  @override
  void didChangeDependencies() {
    store ??= Provider.of<UploadStore>(context);
    _titleController ??= TextEditingController(text: store.title);
    _descController ??= TextEditingController(text: store.description);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO add to localization file!
    final text = (store.productType == ProductType.DESIGN)
        ? 'design'
        : 'fabric';

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
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
                                'Give your $text an '
                                    'awesome title and description.',
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: textStyle2.copyWith(color: awBlack),
                              ),
                            ),
                          ),
                        ],
                        mainAxisSize: MainAxisSize.max,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: _titleField(),
                      ),
                    ],
                  ),
                ),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: _descriptionFiled()),

                Container(
                  //child: _nextButton(),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ],
            ),
          ),
      ),

      floatingActionButton: FloatNextButton(
        title: Localization
            .of(context)
            .next,
        onPressed: () {
          var data = store.isTitleDescriptionValid();
          print('Data is valid: $data');
          if (data)
            widget.nextCallback(data);
        },
      ),

    );
  }

  Widget _titleField() =>
      Observer(
        builder: (context) =>
            InputFieldV2(
              hintText: Localization.of(context).title,
              obscureText: false,
              focusNode: AlwaysDisabledFocusNode(),
              onTap: (){
                Navigator.push(context,
                  TextFieldPageRoute(
                    page: TextFieldPage(
                      title: 'Comments',
                      initialText: store.title ?? '',
                      hint: Localization.of(context).title,

                      maxLines: 4,
                      inputType: TextInputType.text,
                      onDone: (data) {
                        _titleController.text = data;
                        store.setTitle(_titleController.text);

                        Navigator.pop(context);
                      },
                      fieldDecoration: FieldDecoration.ROUNDED,
                    ),
                  ),
                );
              },
              hintStyle: TextStyle(color: awLightColor),
              textInputType: TextInputType.text,
              textStyle: textStyle,
              controller: _titleController,
              radius: APP_INPUT_RADIUS,
              errorText: store.titleErrorMsg,
              maxLines: 1,
              textFieldColor: textFieldColor,
              textAlign: TextAlign.left,
              bottomMargin: 15.0,
              leftPadding: 20.0,
            ),
//            InputFieldV2(
//              hintText: Localization
//                  .of(context)
//                  .title,
//              obscureText: false,
//              hintStyle: TextStyle(color: awLightColor),
//              textInputType: TextInputType.text,
//              textStyle: textStyle,
//              controller: _titleController,
//              textFieldColor: textFieldColor,
//              textAlign: TextAlign.left,
//              radius: APP_INPUT_RADIUS,
//              leftPadding: 20.0,
//              bottomMargin: 15.0,
//              errorText: store.titleErrorMsg,
//              onChanged: (data) => store.setTitle(_titleController.text),
//            ),
      );

  Widget _descriptionFiled() =>
      Observer(
        builder: (context) =>
            InputFieldV2(
              hintText: Localization
                  .of(context)
                  .desc,
              obscureText: false,
              focusNode: AlwaysDisabledFocusNode(),
              onTap: (){
                Navigator.push(context,
                  TextFieldPageRoute(
                    page: TextFieldPage(
                      title: Localization.of(context).desc,
                      initialText: store.description ?? '',
                      hint: Localization.of(context).title,
                      maxLines: 4,
                      inputType: TextInputType.text,
                      onDone: (data) {
                        _descController.text = data;
                        store.setDescription(_descController.text);
                        Navigator.pop(context);
                      },
                      fieldDecoration: FieldDecoration.ROUNDED,
                    ),
                  ),
                );
              },
              hintStyle: TextStyle(color: awLightColor),
              textInputType: TextInputType.text,
              textStyle: textStyle,
              controller: _descController,
              radius: APP_INPUT_RADIUS,
              errorText: store.descriptionErrorMsg,
              maxLines: 4,
              textFieldColor: textFieldColor,
              textAlign: TextAlign.left,
              bottomMargin: 15.0,
              leftPadding: 20.0,
            ),
//            InputFieldV2(
//              hintText: Localization
//                  .of(context)
//                  .desc,
//              obscureText: false,
//              hintStyle: TextStyle(color: awLightColor),
//              textInputType: TextInputType.text,
//              textStyle: textStyle,
//              controller: _descController,
//              radius: APP_INPUT_RADIUS,
//              leftPadding: 20.0,
//              maxLines: 4,
//              textFieldColor: textFieldColor,
//              textAlign: TextAlign.left,
//              bottomMargin: 15.0,
//              onChanged: (data) => store.setDescription(_descController.text),
//              errorText: store.descriptionErrorMsg,
//            ),
      );

}
