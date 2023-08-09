import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/product.dart';

class FirestoreRepository {
  FirestoreRepository(this.firestore);

  final FirebaseFirestore firestore;

  Query<Product?> getProducts() {
    return firestore.collection("products").limit(10).withConverter(
      fromFirestore: (snapshot, options) {
        if (snapshot.exists) {
          return Product.fromFirestore(snapshot.id, snapshot.data()!);
        }

        return null;
      },
      toFirestore: (value, options) {
        if (value != null) {
          return value.toFirestore();
        }

        return {};
      },
    );
  }

  Future<DocumentSnapshot<Product?>> getProduct(String id) {
    return firestore.collection("products").doc(id).withConverter<Product?>(
      fromFirestore: (snapshot, options) {
        if (snapshot.exists) {
          return Product.fromFirestore(snapshot.id, snapshot.data()!);
        }

        return null;
      },
      toFirestore: (value, options) {
        if (value != null) {
          return value.toFirestore();
        }

        return {};
      },
    ).get();
  }
}
