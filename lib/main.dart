import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/core/di/di_container.dart';
import 'package:insys_books/modules/book/presentation/screens/home_screen.dart';

void main() {
  DiContainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const BookHome(),
    ),
  ],
);
