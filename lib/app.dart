import 'package:flutter/material.dart';
import 'package:sort_simulator/core/routes/app_routes.dart';

class SortApp extends StatelessWidget {
  const SortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
    );
  }
}
