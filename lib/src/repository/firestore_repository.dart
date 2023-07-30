import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  FirestoreRepository(this.firestore);

  final FirebaseFirestore firestore;

  Query<Map<String, dynamic>> getProducts() {
    return firestore.collection("products").limit(10);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProduct(String id) {
    return firestore.collection("products").doc(id).get();
  }
}
