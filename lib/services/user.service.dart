import 'package:Awoshe/models/user.dart';

//import 'package:cloud_functions/cloud_functions.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  String userId;
  static Firestore firestore = Firestore.instance;
  DocumentReference userRef;

  UserService({this.userId}) {
    if (this.userId != null) {
      userRef = firestore.document("users/${this.userId}");
//      FirebaseDatabase.instance
//          .reference()
//          .child('/users/$userId/')
//          .onDisconnect()
//          .set({'online': false});
    }
    else {
      FirebaseAuth.instance.currentUser().then((user) {
        if (user != null) {
          this.userId = user?.uid;
          userRef = firestore.document("users/${user.uid}");
        }
      });
    }
  }

  Future<void> verificationCallable() async {
//    try {
//      final dynamic callable = CloudFunctions.instance.getHttpsCallable(functionName: 'actions-auth-emailVerified');
//      dynamic resp = await callable.call();
//
//      print(resp.toString());
//    } on CloudFunctionsException catch (e) {
//      print('caught firebase functions exception');
//      print(e.code);
//      print(e.message);
//      print(e.details);
//    } catch (e) {
//      print('caught generic exception');
//      print(e);
//    }
  }

  Future<User> getUser() async {
    if (this.userRef != null) {
      DocumentSnapshot userData = await this.userRef.get();
      User user = new User.fromDocument(userData);
      return user;
    }
    return null;
  }

  void setUserOffline() async {

  }
}
