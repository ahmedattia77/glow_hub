import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:glow_hub/features/authentication/presentation/ui/pages/on_boarding/on_boarding_screen.dart';
import 'package:glow_hub/features/authentication/presentation/ui/pages/sign_in/sign_in_screen.dart';
import 'package:glow_hub/features/authentication/presentation/ui/pages/sign_up/sign_up_screen.dart';
import 'package:glow_hub/features/authentication/presentation/ui/widgest/user_role.dart';
import 'package:glow_hub/features/home/presentation/ui/pages/admin_screens/add_service_screen.dart';
import 'package:glow_hub/features/home/presentation/ui/pages/admin_screens/admin_services_screen.dart';
import 'package:glow_hub/features/home/presentation/ui/pages/main_layout.dart';
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
                final String uid = snapshot.data!.uid;

                return FutureBuilder(
                  future: FireBaseInitial.firestore
                      .collection('users')
                      .doc(uid)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (userSnapshot.hasData && userSnapshot.data!.exists) {
                      final userData = userSnapshot.data!.data();
                      final String role = userData?['role'] ?? 'customer';

                      if (role == 'admin') {
                        return MainLayout(userRole: UserRole.admin);
                      } else {
                        return MainLayout(userRole: UserRole.client);
                      }
                    }

                    return const OnboardingScreen();
                  },
                );
              }

              return const OnboardingScreen();
            },
          ),
        );

      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignInScreen(),
          ),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignUpScreen(),
          ),
        );

      case Routes.adminHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(userRole: UserRole.admin),
        );

      case Routes.adminAddServiceScreen:
        return MaterialPageRoute(
          builder: (_) => const AddServiceScreen(),
        );

      case Routes.adminManageServicesScreen:
        return MaterialPageRoute(
          builder: (_) => const AdminServicesScreen(),
        );

      case Routes.clientHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(userRole: UserRole.client),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
