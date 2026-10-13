import 'package:flutter/material.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => StreamBuilder(
            stream: FireBaseInitial.auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                return Scaffold(body: Center(child: Text('home')));
              }
              return Scaffold(body: Center(child: Text('login / sign up')));
            },
          ),
        );

      case Routes.onboarding:
      // return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.login:
      // return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.signUp:
      // return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case Routes.roleSelection:
      // return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case Routes.adminHomeScreen:
      // return MaterialPageRoute(builder: (_) => const AdminHomeScreen());

      case Routes.userHomeScreen:
      // return MaterialPageRoute(builder: (_) => const CustomerHomeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
