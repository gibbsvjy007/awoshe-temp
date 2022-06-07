import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Awoshe/models/product.dart';

class ProductService {
  final CollectionReference productRef;
  static Firestore firestore = Firestore.instance;
  DocumentReference designRef;
  ProductService() : productRef = firestore.collection("products");

  Future<List<Product>> getAllProducts() async {
    List<Product> _products = <Product>[];
    await productRef.getDocuments().then((querySnapshot) {
      if (querySnapshot.documents.length > 0) {
        querySnapshot.documents.forEach((doc) {
          doc.data['id'] = doc.documentID;
          _products.add(Product.fromJson(doc.data));
        });
      }
    });
    return _products;
  }
  
  Future<Product> getProductById(String productId) async {
    DocumentSnapshot productRef =
        await firestore.collection("products").document(productId).get();
    productRef.data['id'] = productRef.documentID;
    Product productData = Product.fromJson(productRef.data);
    return productData;
  }

  Future<DocumentReference> createProduct(Product productData) async {
    DocumentReference ref = await productRef.add(productData.toJson());

    /// create entry under designer profile
    ///
    designRef = firestore
        .document("profiles/${productData.owner}/designs/${ref.documentID}");
    designRef.setData({
      "productId": ref.documentID,
      "title": productData.title,
      "uploadType": productData.productType,
      "images": []
    });

    /// while creating product collection create image collection as well
//    ref.collection('images');
    return ref;
  }

  addProductImages(DocumentReference productRef, List<String> designs) async {
    List<String> _images = [];
    for (String url in designs) {
      _images.add(url);
      productRef.updateData({'images': _images});
    }

    /// update design images under profile
    if (designRef != null) {
      designRef.updateData({"images": designs.toList()});
    }
  }

  static getCategoryTitlesFromId(String id) async {
    DocumentSnapshot catRef =
        await firestore.collection("categories").document(id).get();
    return catRef.data['title'];
  }

  Future<List<Product>> fetchAllFabrics() async {
    QuerySnapshot fabRef = await firestore
        .collection("products")
        .where("productType", isEqualTo: "FABRIC")
        .getDocuments();
    List<Product> fabList = fabRef.documents.map((cat) {
      cat.data..['id'] = cat.documentID;
      return Product.fromJson(cat.data);
    }).toList();
    return fabList;
  }

  Stream<DocumentSnapshot> getProductStreamById(final String productId) => productRef
        .document(productId)
        .snapshots();
  
}
