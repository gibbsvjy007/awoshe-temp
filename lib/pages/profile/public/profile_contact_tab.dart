import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFields/textArea.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileContactTab extends StatelessWidget {
  final String currentUserId;
  final String designerId;
  final ProfileStore profileStore;
  ProfileContactTab({this.currentUserId, this.designerId, this.profileStore});

  final TextEditingController contactMessage = TextEditingController();

  void sendMessage(BuildContext context) async {
    print(contactMessage.text);
    if (contactMessage.text == "" || contactMessage.text == null) {
      Utils.showAlertMessage(context, title: "Oops!", message: "It seems you did not enter any message. Please enter some message :-)");
      return;
    }

    await profileStore.contactDesigner(currentUserId: currentUserId, designerId: designerId, oData: {'message': contactMessage.text});
    contactMessage.clear();
    Utils.showAlertMessage(context, title: "Success", message: "Thanks for contacting. The Deisgner ${ profileStore.userDetails.name } will contact you soon.");
  }

  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextAreaInput(
                    hintText: Localization.of(context).typeMessage,
                    hintStyle: TextStyle(color: awLightColor),
                    obscureText: false,
                    // floatingLabel: Localization.of(context).typeMessage,
                    textInputType: TextInputType.text,
                    textStyle: textStyle,
                    textFieldColor: textFieldColor,
                    controller: contactMessage,
                    bottomMargin: 25.0,
                    maxLines: 10,
                    borderColor: awLightColor,
                    borderRadius: 7.0,
                ),
              ),
              RoundedButton(
                  buttonName: Localization.of(context).save,
                  onTap: () {
                    sendMessage(context);
                  },
                  textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                  height: 45.0,
                  width: double.infinity,
                  buttonColor: primaryColor),
            ],
          ),
    );
  }
}
