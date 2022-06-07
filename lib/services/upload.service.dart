import 'package:Awoshe/models/Promotion.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class UploadFirebaseService {
  static Firestore firestore = Firestore.instance;

 createFeedTypeCollection(String colName, FeedType feedType, String colDesc,
     {int ratioX, ratioY, String orientation}) async {

   String designerId = AuthenticationService.appUserId;
    DocumentReference _ref = firestore
        .collection("profiles/$designerId/promotions")
        .document(colName);
    if (_ref.documentID != null) {
      _ref.setData({
        'feedType': feedType,
        'collectionName': colName,
        'description': colDesc,
        'designer': designerId,
        'feeds': [],
        'ratioX': ratioX,
        'ratioY': ratioY,
        'orientation': orientation,
      }, merge: true);
    }
  }

  Stream<List<Promotion>> getCollections() {
    String designerId = AuthenticationService.appUserId;
    return firestore
        .collection("profiles/$designerId/promotions")
        .snapshots()
        .asyncMap( (QuerySnapshot d) =>
          d.documents.map((DocumentSnapshot dt) {
            return Promotion.fromDocument(dt);
            //return dt.documentID + ' (' +dt.data['feedType'] + ')';
          }).toList());
  }
}
