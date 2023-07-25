import 'package:go_router/go_router.dart';

import '../presentation/home_screen.dart';
import '../presentation/product_screen.dart';

enum AppRoute {
  home,
  product,
}

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: AppRoute.home.name,
      builder: (_, __) => const HomeScreen(),
      routes: [
        GoRoute(
          path: "products/:id",
          builder: (_, state) =>
              ProductScreen(productId: state.pathParameters['id']),
          name: AppRoute.product.name,
        )
      ],
    ),
  ],
);
