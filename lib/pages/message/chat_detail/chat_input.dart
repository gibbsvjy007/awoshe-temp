import 'dart:io';

import 'package:Awoshe/logic/stores/chat/chat_store.dart';
import 'package:Awoshe/logic/stores/message/message_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/services/storage.service.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class ChatInputWidget extends StatefulWidget {
  final double height;
  final ChatStore chatStore;
  ChatInputWidget({this.height, this.chatStore});

  @override
  _ChatInputWidgetState createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _messageTextController = TextEditingController();
  MessageStore messageStore;
  UserStore userStore;
  @override
  void initState() {
    super.initState();
  }

  @override
   void didChangeDependencies() {
      super.didChangeDependencies();
      messageStore =  Provider.of<MessageStore>(context);
      userStore =  Provider.of<UserStore>(context);
  }

  /// type 0: text 1: image and 2: emoji
  _sendMessage(MessageType type, {imageUrl}) async {
    if (type == MessageType.TEXT &&
        (_messageTextController.text == "" ||
            _messageTextController.text == null)) return;

    if (type == MessageType.IMAGE && (imageUrl == null || imageUrl == "")) {
      ShowFlushToast(context, ToastType.INFO, "Ooops!! This file is not an Image.");
      return;
    }
    /// if everything is OK then send message
    String message = (type == MessageType.TEXT) ? _messageTextController.text : imageUrl;
    widget.chatStore.sendMessage(message: message.trim(), type: type, userId: userStore.details.id );

    _messageTextController.clear();
  }

    _sendImage() async {
      File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      String imageUrl = await StorageService.uploadFile(imageFile, userStore.details.id);
      print(imageUrl);
      _sendMessage(MessageType.IMAGE, imageUrl: imageUrl);
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[

          SizedBox(
            width: 15.0,
          ),
          // Edit text
          Flexible(
            child: Container(
              //constraints: BoxConstraints.loose(Size.fromHeight(d)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: primaryColor, fontSize: 15.0),
                  controller: _messageTextController,
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.done,
                  textAlignVertical: TextAlignVertical.top,
                  //expands: true,
                  maxLines: null,
                  onSubmitted: (val) => _sendMessage(MessageType.TEXT),
                  //maxLength: 150,
                  maxLengthEnforced: true,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Write a message...',
                    hintStyle: TextStyle(color: awLightColor),

                  ),
                ),
              ),
            ),
          ),

          /// Button send image
          Material(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: SvgIcon(Assets.picture),
                onPressed: _sendImage,
                color: primaryColor,
              ),
            ),
            color: Colors.transparent,
          ),
          // Button send message
          Material(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                _sendMessage(MessageType.TEXT);
              },
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
              child: Container(
                margin: EdgeInsets.only(bottom: 12.0, right: 5.0),

                //margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: 50.0,
                //height: 90.0,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Text("SEND",
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
        ],
      ),
      width: double.infinity,
      //height: 50.0,
      decoration: BoxDecoration(
          border: Border.all(color: awLightColor),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white),
    );
  }
}
