import 'package:flutter/material.dart';
import 'package:glow_hub/features/authentication/presentation/ui/widgest/user_role.dart';
import 'package:glow_hub/features/home/data/repo/user_repo.dart';

class MainLayout extends StatefulWidget {
  final UserRole userRole;

  const MainLayout({super.key, required this.userRole});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final navItems = widget.userRole == UserRole.admin
        ? adminNavItems
        : clientNavItems;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: navItems.map((e) => e.screen).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: navItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}
