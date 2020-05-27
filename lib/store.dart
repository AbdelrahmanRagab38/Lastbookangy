
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'Pages/book_model.dart';
import 'Users.dart';
import 'constants.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addProduct(Book product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.bookTitle,
      kProductDescription: product.description,
      kProducturl: product.imageUrl,
      kProductCategory: product.authorName,
      kProductNpages: product.numPages,
      kProductprice:product.price,
      kProductstars: product.stars,
    });
  }

  addUsers(Users  users) {
    _firestore.collection("users").document(users.Uid).setData({
      kUserEmail: users.Email,
      kUserName: users.UserName,
      kUserPassword: users.password,
      kUserId:users.Uid


    });
  }


  Stream<QuerySnapshot> loadUsers() {
    return _firestore.collection("users").snapshots();
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductsCollection).document(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(kProductsCollection)
        .document(documentId)
        .updateData(data);
  }
}
