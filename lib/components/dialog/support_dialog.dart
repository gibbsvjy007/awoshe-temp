import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/api/message_api.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AwosheSupportDialog extends StatelessWidget {

  final VoidCallback onPress;
  final TextEditingController _controller = TextEditingController();

  AwosheSupportDialog({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Contacting Awoshe Support', style: TextStyle(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)
      ),

      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),

            Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 24.0, bottom: 8.0),
              child: commentsSection(context),
            ),

            Button(
              child: Text('Send'),
              onPressed: () async {
                _sendMessage(context);
              },
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),

              // width: 120.0,
              width: 130.0,
              borderRadius: 24.0,
              height: 35.0,
              backgroundColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          // Can we replace this with the USER avatar so we get the online status aka presence?
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15.0,
            backgroundImage: AssetImage(Assets.awosheLogo),
          ),
        ),

        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(
                  'How may we be of help? ',
                maxLines: 4,
                textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            )
        ),
      ],
    );
  }

  Widget commentsSection(BuildContext context) => InputFieldV2(
    hintText: 'Tell us about it...',
    obscureText: false,
    focusNode: AlwaysDisabledFocusNode(),
    onTap: (){
      Navigator.push(context,
        TextFieldPageRoute(
          page: TextFieldPage(
            title: 'Awoshe Support',
            initialText: _controller.text,
            hint: 'Tell your issues',
            maxLines: 4,
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
    leftPadding: 20.0,
    maxLines: 4,
    textFieldColor: textFieldColor,
    textAlign: TextAlign.left,
    bottomMargin: 15.0,

  );

  void _sendMessage(BuildContext context) async {

    try {
      var userStore = Provider.of<UserStore>(context);
      if (_controller.text.isEmpty){
        ShowFlushToast(context, ToastType.WARNING, 'The message can\'t be empty.');
        return;
      }

      var supportUser = await userStore.getSupportUser();
      String chatId = Utils.getGroupChatId(userStore.details.id, supportUser.id);

      MessageApi.sendMessage(
          message: _controller.text.trim(),
          type: MessageType.TEXT,
          chatId: chatId,
          receiver: supportUser,
          userId: userStore.details.id
      ).then( (_) => ShowFlushToast(context, ToastType.SUCCESS,
          'Your message has been sent.',
          callback: () => Navigator.pop(context))
      ).catchError( (err) => ShowFlushToast(context, ToastType.ERROR,
          'Was not possible sent your message to support.'));


    }

    catch (ex){
      ShowFlushToast(context, ToastType.ERROR,
          'Was not possible sent your message to support.');
      print(ex);

    }
  }
}
