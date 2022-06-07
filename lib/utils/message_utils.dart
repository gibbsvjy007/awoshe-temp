import 'package:Awoshe/logic/bloc_helpers/bloc_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageUtils {
  static int unreadCount = 0;
  static const String _IS_CHAT_WINDOW_OPEN = "ChatWindow";

  static updateUnreadCount(
      String userId, String conversationId, String content) {
    unreadCount++;
    updateUnreadCountToFirebase(userId, conversationId, content);
    globalBloc.unreadMessageCount(MessageUtils.unreadCount);
  }

  static getUnreadCount() => unreadCount;

  static resetUnreadCount(String userId, String conversationId) {
    unreadCount = 0;
    updateUnreadCountToFirebase(userId, conversationId, null);
    globalBloc.unreadMessageCount(MessageUtils.unreadCount);
  }

  static setChatWindowOpen(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_IS_CHAT_WINDOW_OPEN, val);
  }

  static isChatWindowOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_IS_CHAT_WINDOW_OPEN);
  }

  static updateUnreadCountToFirebase(
      String userId, String conversationId, String content) {
    print(unreadCount);
    if (conversationId != null) {
      DocumentReference documentReference = Firestore.instance
          .document("profiles/$userId/conversations/$conversationId");
      Map<String, dynamic> oData = Map();
      oData['unReadCount'] = unreadCount;

      if (content != null && content != "")
        oData['message'] = content.toString();

      documentReference.updateData(oData);
    }
  }
}
