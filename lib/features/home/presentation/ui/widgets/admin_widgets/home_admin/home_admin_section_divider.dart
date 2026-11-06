import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAdminSectionDivider extends StatelessWidget {
  const HomeAdminSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 7.5.h,
      color: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : const Color(0xFFEFEFF2),
    );
  }
}

