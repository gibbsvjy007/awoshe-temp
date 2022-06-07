import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/awoshe.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:flutter/rendering.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';

class ProfileAddress extends StatefulWidget {
  final ProfileStore profileStore;
  final UserStore userStore;
  ProfileAddress({this.profileStore, this.userStore});

  @override
  _ProfileAddress createState() => _ProfileAddress();
}

class _ProfileAddress extends State<ProfileAddress> {
  GlobalKey<FormState> profileAddress1FormKey = GlobalKey<FormState>();
  GlobalKey<FormState> profileAddress2FormKey = GlobalKey<FormState>();
  TextEditingController adr1FullName = TextEditingController();
  TextEditingController adr1Street = TextEditingController();
  TextEditingController adr1City = TextEditingController();
  TextEditingController adr1State = TextEditingController();
  TextEditingController adr1Country = TextEditingController();
  TextEditingController adr1ZipCode = TextEditingController();
  TextEditingController adr2FullName = TextEditingController();
  TextEditingController adr2Street = TextEditingController();
  TextEditingController adr2City = TextEditingController();
  TextEditingController adr2State = TextEditingController();
  TextEditingController adr2Country = TextEditingController();
  TextEditingController adr2ZipCode = TextEditingController();
  Address address1 = Address();
  Address address2 = Address();
  bool isEditAddress1 = false;
  bool isEditAddress2 = false;
  bool autovalidate = false;
  UserDetails userDetails;

  @override
  void initState() {
    userDetails = widget.userStore.details;
    print("Address1: " + userDetails?.address1.toString());

    print(address1);
    print(address2);
    if (userDetails?.address1 != null) {
      address1 = userDetails?.address1;
      this.adr1FullName.text = address1.fullName;
      this.adr1Street.text = address1.street;
      this.adr1City.text = address1.city;
      this.adr1State.text = address1.state;
      this.adr1ZipCode.text = address1.zipCode;
      this.adr1Country.text = address1.country;
    }

    if (userDetails?.address2 != null) {
      address2 = userDetails?.address2;
      this.adr2FullName.text = address2.fullName;
      this.adr2Street.text = address2.street;
      this.adr2City.text = address2.city;
      this.adr2State.text = address2.state;
      this.adr2ZipCode.text = address2.zipCode;
      this.adr2Country.text = address2.country;
    }
    super.initState();
  }

  @override
  void dispose() {
    adr1Street?.dispose();
    adr1City?.dispose();
    adr1State?.dispose();
    adr1Country?.dispose();
    adr1ZipCode?.dispose();
    adr2FullName?.dispose();
    adr2Street?.dispose();
    adr2City?.dispose();
    adr2State?.dispose();
    adr2Country?.dispose();
    adr2ZipCode?.dispose();
    super.dispose();
  }

  void _handleProfileAddressSubmit(type) async {
    final FormState form = type == "ADDRESS1"
        ? profileAddress1FormKey.currentState
        : profileAddress2FormKey.currentState;
    try {
      if (!form.validate()) {
        autovalidate = true; // Start validating on every change.
        Awoshe.showToast(
            'Please fix the errors in red before submitting.', context);
      } else {
        form.save();
        Address address = type == "ADDRESS1" ? address1 : address2;
        print(address.toJson());
        UserDetails updatedDetails;
        Map<String, dynamic> oData = Map();

        if (type == "ADDRESS1") {
          updatedDetails = userDetails.copyWith(address1: address);
          oData['address1'] = updatedDetails.address1.toJson();
        } else {
          updatedDetails = userDetails.copyWith(address2: address);
          oData['address2'] = updatedDetails.address2.toJson();
        }
        widget.profileStore.setUserDetails(updatedDetails);
        widget.userStore.setUserDetails(updatedDetails);

        widget.userStore.updateProfile(oData);
        Awoshe.showToast('Address updated successfully', context);
        setState(() {
          if (type == "ADDRESS1") {
            userDetails?.address1 = address;
            isEditAddress1 = false;
          } else {
            isEditAddress2 = false;
            userDetails?.address2 = address;
          }
        });
      }
    } catch (e) {
      print(e);
      Awoshe.showToast(e.toString(), this.context);
    }
  }

  void updateAddress(String type) {
    UserDetails updatedDetails;
    Map<String, dynamic> oData = Map();

    if (type == "ADDRESS1") {
      updatedDetails = userDetails.copyWith(address1: null);
      oData['address1'] = null;
    } else {
      updatedDetails = userDetails.copyWith(address2: null);
      oData['address2'] = null;
    }
    widget.profileStore.setUserDetails(updatedDetails);
    widget.userStore.setUserDetails(updatedDetails);

    widget.userStore.updateProfile(oData);

    setState(() {
      if (type == "ADDRESS1") {
        userDetails?.address1 = null;
        isEditAddress1 = false;
        this.adr1FullName.clear();
        this.adr1Street.clear();
        this.adr1City.clear();
        this.adr1State.clear();
        this.adr1ZipCode.clear();
        this.adr1Country.clear();
      } else {
        isEditAddress2 = false;
        userDetails?.address2 = null;
        this.adr2FullName.clear();
        this.adr2Street.clear();
        this.adr2City.clear();
        this.adr2State.clear();
        this.adr2ZipCode.clear();
        this.adr2Country.clear();
      }
    });
  }

  void _deleteAddress(String type) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Delete Address"),
            content: Text("Are you sure you want to delete this address ?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("DISCARD"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("DELETE"),
                textColor: primaryColor,
                onPressed: () async {
                  print("call delete api");
                  updateAddress(type);
                  Navigator.pop(context);
                  /// on delete we will update address to blank
                  Awoshe.showToast('Address deleted successfully', context);
                },
              ),
            ],
          );
        });
  }

  Widget address1ListWidget() => Container(
        margin: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Name: " + address1.fullName,
                      style: TextStyle(color: awLightColor)),
                  Text("Address: " + address1.street,
                      style: TextStyle(color: awLightColor)),
                  Text("City: " + address1.city,
                      style: TextStyle(color: awLightColor)),
                  Text("State: " + address1.state,
                      style: TextStyle(color: awLightColor)),
                  Text("Country: " + address1.country,
                      style: TextStyle(color: awLightColor)),
                  Text("Postal code: " + address1.zipCode,
                      style: TextStyle(color: awLightColor)),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('edit address');
                      this.setState(() {
                        isEditAddress1 = !isEditAddress1;
                      });
                    },
                    child: Icon(Icons.edit, color: secondaryColor),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0, left: 5.0)),
                  GestureDetector(
                    onTap: () {
                      print('delete address');
                      _deleteAddress("ADDRESS1");
                    },
                    child: Icon(Icons.delete, color: secondaryColor),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget address1FormWidget() => Form(
        key: profileAddress1FormKey,
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
                onSaved: (String name) {
                  print(name);
                  address1.fullName = name;
                }),
            InputField(
                hintText: Localization.of(context).street,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                controller: adr1Street,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                textStyle: textStyle,
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                onSaved: (String street) {
                  this.address1.street = street;
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
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                controller: adr1City,
                onSaved: (String city) {
                  this.address1.city = city;
                }),
            InputField(
                hintText: Localization.of(context).state,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                controller: adr1State,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                borderColor: awLightColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                onSaved: (String state) {
                  this.address1.state = state;
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
                bottomMargin: 20.0,
                controller: adr1ZipCode,
                onSaved: (String zipCode) {
                  this.address1.zipCode = zipCode;
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
                onSaved: (String country) {
                  this.address1.country = country;
                }),
            RoundedButton(
                buttonName: Localization.of(context).save,
                onTap: () {
                  _handleProfileAddressSubmit("ADDRESS1");
                },
                width: double.infinity,
                height: 50.0,
                buttonColor: primaryColor),
            const Padding(padding: EdgeInsets.only(top: 20.0))
          ],
        ),
      );

  /// Address 1
  Widget profileAddress1Form() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ExpansionTile(
          title: const Text('Address1', style: textStyle1),
          backgroundColor: Colors.white,
          children: <Widget>[
            if (userDetails?.address1 != null && !isEditAddress1)
              address1ListWidget(),
            if (userDetails?.address1 == null || isEditAddress1)
              address1FormWidget()
          ]));

  Widget address2ListWidget() => Container(
        margin: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Name: " + address2?.fullName,
                      style: TextStyle(color: awLightColor)),
                  Text("Address: " + address2?.street,
                      style: TextStyle(color: awLightColor)),
                  Text("City: " + address2?.city,
                      style: TextStyle(color: awLightColor)),
                  Text("State: " + address2?.state,
                      style: TextStyle(color: awLightColor)),
                  Text("Country: " + address2?.country,
                      style: TextStyle(color: awLightColor)),
                  Text("Postal code: " + address2?.zipCode,
                      style: TextStyle(color: awLightColor)),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('edit address');
                      this.setState(() {
                        isEditAddress2 = !isEditAddress2;
                      });
                    },
                    child: Icon(Icons.edit, color: secondaryColor),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0, left: 5.0)),
                  GestureDetector(
                    onTap: () {
                      print('delete address');
                      _deleteAddress("ADDRESS2");
                    },
                    child: Icon(Icons.delete, color: secondaryColor),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget address2FormWidget() => Form(
        key: profileAddress2FormKey,
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
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                controller: adr2FullName,
                borderColor: secondaryColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                onSaved: (String name) {
                  print(name);
                  this.address2.fullName = name;
                }),
            InputField(
                hintText: Localization.of(context).street,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                controller: adr2Street,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                textStyle: textStyle,
                borderColor: secondaryColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                onSaved: (String street) {
                  this.address2.street = street;
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
                borderColor: secondaryColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                controller: adr2City,
                onSaved: (String city) {
                  this.address2.city = city;
                }),
            InputField(
                hintText: Localization.of(context).state,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                controller: adr2State,
                borderColor: secondaryColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                onSaved: (String state) {
                  this.address2.state = state;
                }),
            InputField(
                hintText: Localization.of(context).zipCode,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                borderColor: secondaryColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                controller: adr2ZipCode,
                onSaved: (String zipCode) {
                  this.address2.zipCode = zipCode;
                }),
            InputField(
                hintText: Localization.of(context).country,
                hintStyle: TextStyle(color: awLightColor),
                obscureText: false,
                textInputType: TextInputType.number,
                isBorder: true,
                leftPadding: 15.0,
                radius: APP_INPUT_RADIUS,
                textStyle: textStyle,
                borderColor: secondaryColor,
                textFieldColor: textFieldColor,
                bottomMargin: 20.0,
                controller: adr2Country,
                onSaved: (String country) {
                  this.address2.country = country;
                }),
            RoundedButton(
                buttonName: Localization.of(context).save,
                onTap: () {
                  _handleProfileAddressSubmit("ADDRESS2");
                },
                width: double.infinity,
                height: 50.0,
                buttonColor: primaryColor),
            const Padding(padding: EdgeInsets.only(top: 20.0))
          ],
        ),
      );

  /// Address 2
  Widget profileAddress2Form() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ExpansionTile(
          title: const Text('Address2', style: textStyle1),
          backgroundColor: Colors.white,
          children: <Widget>[
            if (userDetails?.address2 != null && !isEditAddress2)
              address2ListWidget(),
            if (userDetails?.address2 == null || isEditAddress2)
              address2FormWidget()
          ]));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[profileAddress1Form(), profileAddress2Form()],
    );
  }
}
