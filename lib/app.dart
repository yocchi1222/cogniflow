import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/routes.dart';
import 'data/repositories/daily_repository.dart';

class CogniflowApp extends StatelessWidget {
  const CogniflowApp({super.key, required this.repository});

  final DailyRepository repository;

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(repository);

    return MaterialApp.router(
      title: 'Cogniflow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
