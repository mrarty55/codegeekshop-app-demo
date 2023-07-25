import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'src/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const CodeGeekShopApp());
}

class CodeGeekShopApp extends StatelessWidget {
  const CodeGeekShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "CodeGeekShop",
      routerConfig: appRouter,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
    );
  }
}
