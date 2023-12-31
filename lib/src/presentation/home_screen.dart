import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../repository/firestore_repository.dart';
import '../routing/app_router.dart';
import '../utils/number_format_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirestoreRepository firestoreRepository;

  @override
  void initState() {
    firestoreRepository = FirestoreRepository(FirebaseFirestore.instance);
    super.initState();
  }

  void onTapProductCard(BuildContext context, {required String productId}) {
    context.pushNamed(AppRoute.product.name, pathParameters: {"id": productId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeGeekShop'),
      ),
      body: FirestoreQueryBuilder(
        query: firestoreRepository.getProducts(),
        builder: (context, snapshot, child) {
          if (snapshot.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Could not load data haiyaa'),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              final product = snapshot.docs[index].data();

              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                snapshot.fetchMore();
              }

              final imageProvider = (product?.imageUrl as String).isNotEmpty
                  ? NetworkImage(product?.imageUrl ?? "")
                  : const AssetImage("assets/icons/codegeek.png")
                      as ImageProvider;

              return Card(
                margin: EdgeInsets.zero,
                child: InkWell(
                  onTap: () {
                    onTapProductCard(context, productId: product?.id ?? "");
                  },
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product?.name ?? "",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              Text(
                                  "${product?.currencyUnit} ${product?.price.toKipString()}"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
