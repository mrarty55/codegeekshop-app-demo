import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeGeekShop'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home screen'),
            ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRoute.product.name,
                      pathParameters: {"id": "test"});
                },
                child: const Text('To product screen')),
          ],
        ),
      ),
    );
  }
}
