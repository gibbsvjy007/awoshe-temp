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
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:provider/provider.dart';

class CustomizeColorPage extends StatefulWidget {


  const CustomizeColorPage({Key key,}) : super(key: key);
  @override
  _CustomizeColorPageState createState() => _CustomizeColorPageState();
}

class _CustomizeColorPageState extends State<CustomizeColorPage> {
  final _controller = TextEditingController();
  UploadStore uploadStore;
  UserStore userStore;
  Color selectedColor;

  @override
  void initState() {
    super.initState();
    uploadStore = Provider.of<UploadStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);
    selectedColor = primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        title: Text('Custom Color'),
      ),
      floatingActionButton: FloatNextButton(
          title: Localization.of(context).confirm,
          
          onPressed: () {
            if ( !_isColorNameValid(_controller.text) ){
              ShowFlushToast(context, ToastType.ERROR, 'Color name can\'t be empty');
              return;
            }

            var results = userStore.addCustomColor(_controller.text, selectedColor.value);
            if (!results){
              ShowFlushToast(context, ToastType.ERROR, 'There is a color named ${_controller.text}');
              return;
            }

            uploadStore.addColorName(_controller.text );
            Navigator.pop(context);
            
          }),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            drawColorPicker(),
            colorNameField(),
          ],
        ),
      ),
    );
  }

  Widget drawColorPicker() => Container(
    margin: EdgeInsets.symmetric(
      vertical: 16.0
    ),
    child: CircleColorPicker(
          initialColor: primaryColor,
          onChanged: (color) => selectedColor = color,
        ),
  );

  Widget colorNameField() => Container(
    margin: EdgeInsets.symmetric(
      horizontal: 16.0,
    ),
    child: InputFieldV2(
          hintText: 'Custom color name',
          obscureText: false,
          focusNode: AlwaysDisabledFocusNode(),
          onTap: () {
            Navigator.push(
              context,
              TextFieldPageRoute(
                page: TextFieldPage(
                  title: 'Color name',
                  initialText: _controller.text,
                  hint: 'Custom color name',
                  maxLines: 2,
                  inputType: TextInputType.text,
                  onDone: (data) {
                    _controller.text = data;
                    // store.setFabricTags(_controller.text);
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
          controller: _controller,
          radius: APP_INPUT_RADIUS,
          maxLines: 1,
          textFieldColor: textFieldColor,
          textAlign: TextAlign.left,
          bottomMargin: 15.0,
          leftPadding: 20.0,
        ),
  );


  bool _isColorNameValid(String colorName) => (colorName != null && colorName.isNotEmpty);
}
