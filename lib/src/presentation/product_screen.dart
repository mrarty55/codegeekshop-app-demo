import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegeekshop/src/entity/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/firestore_repository.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, this.productId});

  final String? productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late FirestoreRepository firestoreRepository;

  bool isError = false;

  bool isLoading = true;

  Product? product;

  @override
  void initState() {
    firestoreRepository = FirestoreRepository(FirebaseFirestore.instance);
    fetchProduct();
    super.initState();
  }

  void fetchProduct() async {
    final product =
        await firestoreRepository.getProduct(widget.productId ?? "");
    setState(() {
      if (product.exists) {
        this.product = product.data();
      } else {
        isError = true;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(!isError
            ? product != null
                ? product?.name ?? ""
                : ""
            : '404'),
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (isError) {
            return const Center(
              child: Text('No product found haiyaa'),
            );
          }

          return Column(
            children: [
              if (product != null) ...[Image.network(product?.imageUrl ?? "")],
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product != null ? product?.name ?? "" : "N/A",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      product != null
                          ? "${product?.currencyUnit} ${NumberFormat('#,###').format(product?.price)}"
                          : "N/A",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(product != null ? product?.description ?? "" : "N/A"),
                    Row(
                      children: [
                        FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Add to Cart'),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Add to Wishlist'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
