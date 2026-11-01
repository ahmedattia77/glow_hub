import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/home/data/model/shared_models/nav_item_model.dart';
import 'package:glow_hub/features/home/presentation/ui/pages/admin_screens/home_admin_screen.dart';
import 'package:glow_hub/features/home/presentation/ui/pages/client_screens/home_client_screen.dart';
import 'package:glow_hub/features/home/presentation/ui/pages/client_screens/client_profile_screen.dart';
import 'package:glow_hub/features/profile/data/repo/client_repo.dart';
import 'package:glow_hub/features/profile/presentation/cubit/edit_profile_cubit.dart';

/// client nav items
final List<NavItemModel> clientNavItems = [
  NavItemModel(
    label: 'Home',
    icon: Icons.home_rounded,
    screen: HomeClientScreen(),
  ),
  NavItemModel(
    label: 'Explore',
    icon: Icons.search_rounded,
    screen: const Scaffold(
      body: Center(
        child: Text('Explore Screen', style: TextStyle(fontSize: 20)),
      ),
    ),
  ),
  NavItemModel(
    label: 'Appointments',
    icon: Icons.calendar_today_rounded,
    screen: const Scaffold(
      body: Center(
        child: Text(
          'Customer Appointments Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
  ),
  NavItemModel(
    label: 'Profile',
    icon: Icons.person_rounded,
    screen: BlocProvider(
      create: (context) =>
          EditProfileCubit(UserRepo())
            ..loadUserData(FireBaseInitial.auth.currentUser!.uid),
      child: const ClientProfileScreen(),
    ),
  ),
];

/// admin nav items
final List<NavItemModel> adminNavItems = [
  NavItemModel(
    label: 'Dashboard',
    icon: Icons.grid_view_rounded,
    screen: const HomeAdminScreen(),
  ),
  NavItemModel(
    label: 'Appointments',
    icon: Icons.calendar_today_outlined,
    screen: const Scaffold(
      body: Center(
        child: Text(
          'Admin Appointments Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
  ),
  NavItemModel(
    label: 'Services',
    icon: Icons.tune_rounded,
    screen: const Scaffold(
      body: Center(
        child: Text('Admin Services Screen', style: TextStyle(fontSize: 20)),
      ),
    ),
  ),
  NavItemModel(
    label: 'Profile',
    icon: Icons.person_outline_rounded,
    screen: const Scaffold(
      body: Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 20)),
      ),
    ),
  ),
];
