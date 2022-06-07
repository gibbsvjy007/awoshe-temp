import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/components/dropdown/awoshe_dropdown.dart';
import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/components/image_view/ImageView.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomMeasurementCreationPage extends StatefulWidget {
  @override
  _CustomMeasurementCreationPageState createState() => _CustomMeasurementCreationPageState();
}

class _CustomMeasurementCreationPageState extends State<CustomMeasurementCreationPage> {

  TextEditingController _controller;
  UploadStore uploadStore;
  UserStore userStore;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
    uploadStore = Provider.of<UploadStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    var locale = Localization.of(context);
    var size = MediaQuery.of(context).size;

    final spacerBox = SizedBox(
      height: 16.0,
    );

    final units = <String>[
      'cm',
      'mm',
      'inch',
    ];

    final lengthUnitSection = Column(
      children: <Widget>[
        unitTextWidget(),
        spacerBox,
        Container(
          width: size.width / 2,
          child: AwosheDropdown(
          color: awLightColor,
          selectedValue: units[0],
          options: units,
          onChange: (unit){},
        ),
      ),

      ],
    );

    final measurementNameInput = Column(
      children: <Widget>[
        measurementNameTextWidget(),
        spacerBox,
        measurementNameField(),
      ],
    );

    final imageWidget = Column(
      children: <Widget>[
        photoTextWidget(),
        spacerBox,
        imageSelection()
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Measurement'),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.5,
        brightness: Brightness.light,
      ),

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            spacerBox,
            lengthUnitSection,
            Spacer(),
            measurementNameInput,
            Spacer(),
            imageWidget,
            Spacer(),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatNextButton(
        title: locale.confirm,
        onPressed: (){},
      ),
    );
  }

  Widget measurementNameField() => Container(
    child: InputFieldV2(
      hintText: 'Measurement name',
      obscureText: false,
      focusNode: AlwaysDisabledFocusNode(),
      onTap: () {
        Navigator.push(
          context,
          TextFieldPageRoute(
            page: TextFieldPage(
              title: 'Measurement name',
              initialText: _controller.text,
              hint: 'Measurement name',
              maxLines: 2,
              inputType: TextInputType.text,
              onDone: (data) {
                _controller.text = data;

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

  Widget imageSelection() {
    return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageView(
              onTap: (){},
              onDelete: (){},
            ),
          ],
    );
  }


  Widget unitTextWidget () => RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'Select a default ',
      style: textStyle2.copyWith(color: awBlack),
      children: [
        TextSpan(
          text: 'length unit ',
          style: textStyle2.copyWith(color: primaryColor),
        ),

        TextSpan(
          text:'to be used in your customized measurement.',
          style: textStyle2.copyWith(color: awBlack),
        ),
      ]
    ),
  );

  Widget measurementNameTextWidget() => RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'Define the measurement name.',
      style: textStyle2.copyWith(color: awBlack),
    ),
  );

  Widget photoTextWidget() => RichText(
    textAlign: TextAlign.center,
      text: TextSpan(
        text: "You can choose a picture showing how the ",
        style: textStyle2.copyWith(color: awBlack),
        children: [
          TextSpan(
            text: "measurements ",
            style: textStyle2.copyWith(color: primaryColor),
          ),

          TextSpan(
            text: "is done.",
            style: textStyle2.copyWith(color: awBlack),
          ),
        ]
      ),
  );
}
