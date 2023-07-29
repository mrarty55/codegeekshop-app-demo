import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  FirestoreRepository(this.firestore);

  final FirebaseFirestore firestore;

  Query<Map<String, dynamic>> getProducts() {
    return firestore.collection("products").limit(10);
  }
}
