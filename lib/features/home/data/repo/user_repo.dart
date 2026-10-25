import 'package:flutter/material.dart';
import 'package:glow_hub/features/home/data/model/nav_item_model.dart';
import 'package:glow_hub/features/home/presentation/ui/pages/client_screens/home_client_screen.dart';

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
    screen: const Scaffold(
      body: Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 20)),
      ),
    ),
  ),
];

/// admin nav items
final List<NavItemModel> adminNavItems = [
  NavItemModel(
    label: 'Dashboard',
    icon: Icons.dashboard_rounded,
    screen: const Scaffold(
      body: Center(
        child: Text('Admin Dashboard Screen', style: TextStyle(fontSize: 20)),
      ),
    ),
  ),
  NavItemModel(
    label: 'Appointments',
    icon: Icons.calendar_month_rounded,
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
    icon: Icons.style_rounded,
    screen: const Scaffold(
      body: Center(
        child: Text('Admin Services Screen', style: TextStyle(fontSize: 20)),
      ),
    ),
  ),
  NavItemModel(
    label: 'Profile',
    icon: Icons.person_rounded,
    screen: const Scaffold(
      body: Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 20)),
      ),
    ),
  ),
];
