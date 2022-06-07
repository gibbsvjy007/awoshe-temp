import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/services/validations.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:flutter/rendering.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/models/user_profile.dart';
import 'package:provider/provider.dart';

class AddressDialog extends StatefulWidget {

  final int type;
  AddressDialog({this.type});

  @override
  _AddressDialogState createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  GlobalKey<FormState> profileAddressFormKey = GlobalKey<FormState>();
  TextEditingController adr1FullName = TextEditingController();
  TextEditingController adr1Street = TextEditingController();
  TextEditingController adr1City = TextEditingController();
  TextEditingController adr1State = TextEditingController();
  TextEditingController adr1Country = TextEditingController();
  TextEditingController adr1ZipCode = TextEditingController();
  Addresses address = Addresses();
  bool isEditAddress = false;
  bool autovalidate = false;
  UserStore _userStore;
  final validators = Validators();

  @override
  void didChangeDependencies() {

    if (_userStore == null){
      _userStore = Provider.of<UserStore>(context);
      var addr = _userStore.details.address1;
      if (widget.type == 1)
        addr = _userStore.details.address2;

      adr1FullName.text = addr?.fullName;
      adr1Street.text = addr?.street;
      adr1City.text = addr?.city;
      adr1Country.text = addr?.country;
      adr1State.text = addr?.state;
      adr1ZipCode.text = addr?.zipCode;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    adr1Street.dispose();
    adr1City.dispose();
    adr1State.dispose();
    adr1Country.dispose();
    adr1ZipCode.dispose();
    super.dispose();
  }

  void _handleProfileAddressSubmit() async {
    final FormState form = profileAddressFormKey.currentState;

    if (!form.validate())
        autovalidate = true; // Start validating on every change.

    else {
        form.save();
        var addr = Address(
          fullName: adr1FullName.text,
          type: widget.type,
          city: adr1City.text,
            country: adr1Country.text,
          state: adr1State.text,
          street: adr1Street.text,
            zipCode: adr1ZipCode.text
        );

        // shipping address
        if (widget.type == 0)
          _userStore.updateShippingAddress(addr).then((_) => print(addr));

        else
          _userStore.updateBillingAddress(addr).then((_) => print(addr));

        Navigator.pop(context);
    }

  }

  Widget addressFormWidget() => Form(
        key: profileAddressFormKey,
        autovalidate: autovalidate,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15.0, bottom: 10.0)),
            InputField(
                hintText: Localization.of(context).name,
                obscureText: false,
                hintStyle: TextStyle(color: awLightColor),
                textInputType: TextInputType.text,
                textStyle: textStyle,
                controller: adr1FullName,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                validateFunction: validators.nameValidation,
                onSaved: (String name) {
                  print(name);
                  this.address.fullName = name;
                }),
            InputField(
                hintText: Localization.of(context).street,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                controller: adr1Street,
                isBorder: true,
                validateFunction: validators.noEmptyValidation,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                textStyle: textStyle,
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                onSaved: (String street) {
                  this.address.street = street;
                }),
            InputField(
                hintText: Localization.of(context).city,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                validateFunction: validators.noEmptyValidation,
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                controller: adr1City,
                onSaved: (String city) {
                  this.address.city = city;
                }),
            InputField(
                hintText: Localization.of(context).state,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                controller: adr1State,
                validateFunction: validators.noEmptyValidation,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                onSaved: (String state) {
                  this.address.state = state;
                }),
            InputField(
                hintText: Localization.of(context).zipCode,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.number,
                textStyle: textStyle,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                validateFunction: validators.zipCodeValidation,
                bottomMargin: 20.0,
                controller: adr1ZipCode,
                onSaved: (String zipCode) {
                  this.address.zipCode = zipCode;
                }),

            InputField(
                hintText: Localization.of(context).country,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                controller: adr1Country,
                validateFunction: validators.noEmptyValidation,
                onSaved: (String country) {
                  this.address.country = country;
                }),


            AwosheButton(
              childWidget: Text(Localization
                  .of(context)
                  .save, style: buttonTextStyle,),
              onTap: _handleProfileAddressSubmit,
              width: double.infinity,
              height: 50.0,
              buttonColor: primaryColor,
            ),

            const Padding(padding: EdgeInsets.only(top: 20.0)),

          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address"),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: addressFormWidget(),
        ),
      ),
    );
  }
}
