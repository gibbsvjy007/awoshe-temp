import 'dart:async';
import 'package:Awoshe/models/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Awoshe/models/product.dart';

class BlogService {
  final CollectionReference blogRef;
  static Firestore firestore = Firestore.instance;
  DocumentReference designRef;
  BlogService() : blogRef = firestore.collection("blogs");
  Future<List<Product>> getAllProducts() async {
    List<Product> _products = <Product>[];
    await blogRef.getDocuments().then((querySnapshot) {
      if (querySnapshot.documents.length > 0) {
        querySnapshot.documents.forEach((doc) {
          doc.data['id'] = doc.documentID;
          _products.add(Product.fromJson(doc.data));
        });
      }
    });
    return _products;
  }

  Future<Product> getProductDetail(String productId) async {
    DocumentSnapshot blogRef =
        await firestore.collection("blogs").document(productId).get();
    blogRef.data['id'] = blogRef.documentID;
    Product productData = Product.fromJson(blogRef.data);
    return productData;
  }

  Future<DocumentReference> createBlog(Blog blogData) async {
    DocumentReference ref = await blogRef.add(blogData.toJson());
    designRef = firestore
        .document("profiles/${blogData.owner}/blogs/${ref.documentID}");
    designRef.setData({
      "blogId": ref.documentID,
      "title": blogData.title,
      "feedType": blogData.feedType,
      "description": blogData.description,
      "url": blogData.url,
      "images": []
    });
    return ref;
  }

  addBlogImages(DocumentReference productRef, List<String> designs) async {
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
}
