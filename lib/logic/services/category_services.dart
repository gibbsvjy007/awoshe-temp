import 'package:Awoshe/constants.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class CategoryService implements Categories {
  CategoryService();

  final Firestore _firestore = Firestore.instance;

  @override
  Future<List<DocumentSnapshot>> getCategories({
    @required int limit,
    @required String orderBy,
    @required String mainCategory,
    @required String subCategory,
    DocumentSnapshot startAfter,
  }) async {
    Query query;
    print(Utils.capitalize(mainCategory) + " => " + subCategory.toString());
    
    if (subCategory == null || subCategory == "ALL" || subCategory == "All") {
      query = _firestore
          .collection('feeds')
          .orderBy('createdAt', descending: true)
          .where('mainCategory', isEqualTo: mainCategory);
    } else {
      query = _firestore
          .collection('feeds')
          .orderBy('createdAt', descending: true)
          .where('mainCategory', isEqualTo: mainCategory)
          .where('subCategory', isEqualTo: subCategory);
    }

    if (startAfter != null) {
      query = query.startAfter([startAfter['createdAt']]);
    }
    final List<DocumentSnapshot> documents =
        (await query.limit(limit).getDocuments()).documents;
    print(documents.length);

    return documents;
  }

  @override
  Stream<List<DocumentSnapshot>> getAllFeeds() {
    String userId = AuthenticationService.appUserId;
    print("getAllFeeds:: " + userId);
    return _firestore
        .collection('profiles/$userId/feeds')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((QuerySnapshot snap) => snap.documents);
  }

  @override
  Stream<List<DocumentSnapshot>> getCategoriesByType(
      mainCategory, subCategory) {
    String userId = AuthenticationService.appUserId;
    print("getAllFeeds:: " + userId);
    if (subCategory == null || subCategory == "ALL") {
      return _firestore
          .collection('profiles/$userId/feeds')
          .orderBy('createdAt', descending: true)
          .where('mainCategory', isEqualTo: mainCategory)
          .snapshots()
          .asyncMap((QuerySnapshot snap) => snap.documents);
    }
    return _firestore
        .collection('profiles/$userId/feeds')
        .orderBy('createdAt', descending: true)
        .where('mainCategory', isEqualTo: mainCategory)
        .where('subCategory', isEqualTo: subCategory)
        .snapshots()
        .asyncMap((QuerySnapshot snap) => snap.documents);
  }

  @override
  Stream<List<DocumentSnapshot>> getAllFavourites() {
    String userId = AuthenticationService.appUserId;
    print("getAllFavourites:: " + userId);
    return _firestore
        .collection('profiles/$userId/favourites')
        .snapshots()
        .asyncMap((QuerySnapshot snap) => snap.documents);
  }

  @override
  Future<bool> updateFavourite(productId) async {
    String userId = AuthenticationService.appUserId;
    DocumentReference favoritesReference = _firestore
        .collection("profiles/$userId/favourites")
        .document(productId);

    return Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(favoritesReference);
      if (postSnapshot.exists) {
        /// if the document exists then remove this document from the favourite collection
        await tx.delete(favoritesReference);
      } else {
        /// if document does not exists then simply remove this from favourite items
        await tx.set(favoritesReference, {'productId': productId});
      }
    }).then((result) {
      return true;
    }).catchError((error) {
      print('Error: $error');
      return false;
    });
  }

  Future<List<String>> getSubCategoriesFromGlobals(mainCategory) async {
    String userId = AuthenticationService.appUserId;
    List<String> availableCategories = List();

    DocumentSnapshot oData = await _firestore
        .document(
            'profiles/$userId/globals/categories/$mainCategory/subCategories')
        .get();
    if (oData.exists && oData.data != null) {
      availableCategories = List<String>.from(oData.data['subCategories']);
    }
    print("_______getSubCategoriesFromGlobals______");
    print(availableCategories);
    return availableCategories;
  }

  Future<List<String>> getAllSubCategoryNames(mainCategory) async {
    String userId = AuthenticationService.appUserId;
    print("getAllSubCategoryNames:: " + userId + " " + mainCategory);
    List<String> availableCategories = List();
    for (int i = 0; i < SUB_CATEGORIES.length; i++) {
      print(SUB_CATEGORIES[i]);
      QuerySnapshot snap = await _firestore
          .collection('profiles/$userId/feeds')
          .where('mainCategory', isEqualTo: mainCategory)
          .where("subCategory", isEqualTo: SUB_CATEGORIES[i])
          .limit(1)
          .getDocuments();
      if (snap.documents != null && snap.documents.length > 0) {
        availableCategories.add(SUB_CATEGORIES[i]);
      }
    }
    print("getAllSubCategoryNames:::______");
    print(availableCategories);
    return availableCategories;
  }

  Future<List<String>> getAllSubCategories(mainCategory) async {
    String userId = AuthenticationService.appUserId;
    print("getAllSubCategoryNames:: " + userId + " " + mainCategory);
    List<String> availableCategories = List();
    QuerySnapshot snap = await _firestore
        .collection('categories')
        .where('parentCategory',
            isEqualTo: mainCategory.toString().toLowerCase())
        .getDocuments();
    if (snap.documents != null && snap.documents.length > 0) {
      snap.documents.forEach((DocumentSnapshot dc) {
        availableCategories.add(dc.data['identifier']);
      });
      print("getAllSubCategoryNames from global:::______");
    }
    return availableCategories;
  }
}

abstract class Categories {
  Future<List<DocumentSnapshot>> getCategories({
    @required int limit,
    @required String orderBy,
    @required String mainCategory,
    @required String subCategory,
    DocumentSnapshot startAfter,
  });
  Stream<List<DocumentSnapshot>> getAllFeeds();
  Stream<List<DocumentSnapshot>> getCategoriesByType(
      String mainCategory, String subCategory);
  Stream<List<DocumentSnapshot>> getAllFavourites();
  Future<bool> updateFavourite(String productId);
}
