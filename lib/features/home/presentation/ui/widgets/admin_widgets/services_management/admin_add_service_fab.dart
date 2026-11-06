import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class AdminAddServiceFab extends StatelessWidget {
  const AdminAddServiceFab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(
        context,
        Routes.adminAddServiceScreen,
      ),
      backgroundColor:
          isDark ? AppColors.primaryDark : const Color(0xFFC7847B),
      icon: const Icon(Icons.add_rounded, color: Colors.white),
      label: Text(
        'Add Service',
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

