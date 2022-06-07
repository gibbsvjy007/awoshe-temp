import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/measurement/measurement.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/utils/awoshe.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileMeasurement extends StatefulWidget {
  final ProfileStore profileStore;
  final UserStore userStore;
  ProfileMeasurement({this.profileStore, this.userStore});

  @override
  _ProfileMeasurement createState() => new _ProfileMeasurement();
}

class _ProfileMeasurement extends State<ProfileMeasurement> {
  GlobalKey<FormState> profileMeasurementKey = new GlobalKey<FormState>();
  bool autovalidate = false;
  TextEditingController mHeight = new TextEditingController();
  TextEditingController mHip = new TextEditingController();
  TextEditingController mBurst = new TextEditingController();
  TextEditingController mWaist = new TextEditingController();
  TextEditingController mChest = new TextEditingController();
  TextEditingController mArms = new TextEditingController();
  Measurement measurements = new Measurement();
  UserDetails userDetails;
  @override
  void initState() {
    super.initState();
    userDetails = widget.userStore.details;
    if (userDetails.measurements != null) {
      measurements = userDetails.measurements;
      mHeight.text = measurements.height?.toString();
      mHip.text = measurements.hip?.toString();
      mBurst.text = measurements.burst?.toString();
      mWaist.text = measurements.waist?.toString();
      mChest.text = measurements.chest?.toString();
      mArms.text = measurements.arms?.toString();
    }
    print(measurements.toJson());
    print('INIT MEASUREMENTS');

  }

  @override
  void dispose() {
    mHeight?.dispose();
    mHip?.dispose();
    mBurst?.dispose();
    mWaist?.dispose();
    mChest?.dispose();
    mArms?.dispose();
    super.dispose();
  }

  void _handleMeasurementSubmit(data) async {
    final FormState form = profileMeasurementKey.currentState;
    try {
      if (!form.validate()) {
        autovalidate = true; // Start validating on every change.
        Awoshe.showToast(
            'Please fix the errors in red before submitting.', this.context);
      } else {
//        showProgress(context);
        widget.userStore.setLoading(true);
        form.save();
        var body = measurements.toJson();
        print(data);
        print(body);
        Map<String, dynamic> oData = Map();
        UserDetails updatedDetails = userDetails.copyWith(measurements: measurements);
        oData['measurements'] = updatedDetails.measurements.toJson();
        widget.profileStore.setUserDetails(updatedDetails);
        widget.userStore.setUserDetails(updatedDetails);
        widget.userStore.updateProfile(oData);
        Awoshe.showToast('Measurements updated successfully', context);
        await Future.delayed(Duration(seconds: 1));
        widget.userStore.setLoading(false);
      }
    } catch (e) {
      print(e);
//      hideProgress(this.context);
      widget.userStore.setLoading(false);
      Awoshe.showToast(e.toString(), this.context);
    }
  }

  Widget profileFormWidget(data) => Form(
        key: profileMeasurementKey,
        autovalidate: autovalidate,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15.0, bottom: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: InputField(
                      hintText: Localization.of(context).height,
                      obscureText: false,
                      hintStyle: TextStyle(color: secondaryColor),
                      textInputType: TextInputType.text,
                      floatingLabel: Localization.of(context).height,
                      textStyle: textStyle,
                      controller: mHeight,
                      isBorder: true,
                      leftPadding: 15.0,
                      radius: APP_INPUT_RADIUS,
                      textFieldColor: textFieldColor,
                      bottomMargin: 20.0,
                      onSaved: (String height) {
                        this.measurements.height = double.parse(height);
                      }),
                ),
                Padding(padding: EdgeInsets.only(right: 15.0)),
                Flexible(
                  child: InputField(
                      hintText: Localization.of(context).hip,
                      obscureText: false,
                      hintStyle: TextStyle(color: secondaryColor),
                      textInputType: TextInputType.text,
                      textStyle: textStyle,
                      controller: mHip,
                      isBorder: true,
                      leftPadding: 15.0,
                      radius: APP_INPUT_RADIUS,
                      floatingLabel: Localization.of(context).hip,
                      textFieldColor: textFieldColor,
                      bottomMargin: 20.0,
                      onSaved: (String hip) {
                        this.measurements.hip = double.parse(hip);
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: InputField(
                      hintText: Localization.of(context).chest,
                      obscureText: false,
                      hintStyle: TextStyle(color: secondaryColor),
                      textInputType: TextInputType.text,
                      textStyle: textStyle,
                      controller: mChest,
                      isBorder: true,
                      leftPadding: 15.0,
                      radius: APP_INPUT_RADIUS,
                      floatingLabel: Localization.of(context).chest,
                      textFieldColor: textFieldColor,
                      bottomMargin: 20.0,
                      onSaved: (String chest) {
                        this.measurements.chest = double.parse(chest);
                      }),
                ),
                Padding(padding: EdgeInsets.only(right: 15.0)),
                Flexible(
                  child: InputField(
                      hintText: Localization.of(context).burst,
                      obscureText: false,
                      hintStyle: TextStyle(color: secondaryColor),
                      textInputType: TextInputType.text,
                      textStyle: textStyle,
                      floatingLabel: Localization.of(context).burst,
                      controller: mBurst,
                      isBorder: true,
                      leftPadding: 15.0,
                      radius: APP_INPUT_RADIUS,
                      textFieldColor: textFieldColor,
                      bottomMargin: 20.0,
                      onSaved: (String burst) {
                        this.measurements.burst = double.parse(burst);
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: InputField(
                      hintText: Localization.of(context).arms,
                      obscureText: false,
                      hintStyle: TextStyle(color: secondaryColor),
                      textInputType: TextInputType.text,
                      textStyle: textStyle,
                      controller: mArms,
                      isBorder: true,
                      leftPadding: 15.0,
                      radius: APP_INPUT_RADIUS,
                      floatingLabel: Localization.of(context).arms,
                      textFieldColor: textFieldColor,
                      bottomMargin: 20.0,
                      onSaved: (String arms) {
                        this.measurements.arms = double.parse(arms);
                      }),
                ),
                Padding(padding: EdgeInsets.only(right: 15.0)),
                Flexible(
                  child: InputField(
                      hintText: Localization.of(context).waist,
                      obscureText: false,
                      hintStyle: TextStyle(color: secondaryColor),
                      textInputType: TextInputType.text,
                      floatingLabel: Localization.of(context).waist,
                      textStyle: textStyle,
                      controller: mWaist,
                      isBorder: true,
                      leftPadding: 15.0,
                      radius: APP_INPUT_RADIUS,
                      textFieldColor: textFieldColor,
                      bottomMargin: 20.0,
                      onSaved: (String waist) {
                        this.measurements.waist = double.parse(waist);
                      }),
                ),
              ],
            ),
            Observer(
              builder: (context) {
                final bool loading = widget.userStore.loading;
                print(loading);
                print("Measurement builder called");
                return Button(
                    child: Text(Localization.of(context).save),
                    onPressed: () {
                      _handleMeasurementSubmit(data);
                    },
                    loading: loading,
                    textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                    height: 50.0,
                    width: double.infinity,
                    backgroundColor: primaryColor);
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0))
          ],
        ),
      );

  Widget profileMeasurementForm() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ExpansionTile(
          title: const Text('Measurements', style: textStyle1),
          backgroundColor: Colors.white,
          children: <Widget>[
            profileFormWidget(''),
          ]));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: profileMeasurementForm(),
    );
  }
}
