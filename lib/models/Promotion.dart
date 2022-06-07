import 'package:cloud_firestore/cloud_firestore.dart';

class Promotion {

  static final Promotion DEFAULT_TYPE = Promotion(
      {
        COLLECTION_NAME : 'SINGLE',
        ID : 'SINGLE',
        FEED_TYPE : 'SINGLE'
      });

  final Map<String,dynamic> _data;
  static const DESCRIPTION = 'description';
  static const FEED_TYPE = 'feedType';
  static const COLLECTION_NAME = 'collectionName';
  static const DESIGNER_ID = 'designer';
  static const FEEDS = 'feeds';
  static const ORIENTATION = 'orientation';
  static const RATIOX = 'ratioX';
  static const RATIOY = 'ratioY';
  static const ID = 'id';

  Promotion(final Map<String, dynamic> data) : _data = data;
  
  Promotion.fromDocument(DocumentSnapshot document) : _data = {
    ID : document.documentID,
    DESCRIPTION : document.data[DESCRIPTION],
    COLLECTION_NAME : document.data[COLLECTION_NAME],
    FEED_TYPE : document.data[FEED_TYPE],
    DESIGNER_ID : document.data[DESIGNER_ID],
    FEEDS : document.data[FEEDS] ?? [],
    RATIOX : document.data[RATIOX],
    RATIOY : document.data[RATIOY],
    ORIENTATION : document.data[ORIENTATION],
  };

  String get description => _data[DESCRIPTION];
  String get collectionName => _data[COLLECTION_NAME];
  String get feedType => _data[FEED_TYPE];
  List<String> get feeds => _data[FEEDS];
  String get designer => _data[DESIGNER_ID];
  String get orientation => _data[ORIENTATION];
  int get ratioX => _data[RATIOX];
  int get ratioY => _data[RATIOY];
  String get id => _data[ID];

  @override
  String toString() {
    return '$ID : $id\n'
        '$DESCRIPTION : $description\n'
        '$FEED_TYPE : $feedType\n'
        '$COLLECTION_NAME : $collectionName\n'
        '$ORIENTATION : $orientation\n'
        '$RATIOX : $ratioX\n'
        '$RATIOY : $ratioY\n'
        '$DESIGNER_ID : $designer';
  }
}