import 'package:flutter/material.dart';
import 'package:glow_hub/core/routing/app_router.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glow Hub',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.initialRoute,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
    );
  }
}
