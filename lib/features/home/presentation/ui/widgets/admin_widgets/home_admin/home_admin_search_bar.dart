import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class HomeAdminSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const HomeAdminSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : const Color(0xFFF3F3F5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : const Color(0xFFE5E5EA),
            width: 0.9.w,
          ),
        ),
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 13.sp,
            color:
                isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
            isDense: true,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : const Color(0xFF8E8E93),
              size: 19.sp,
            ),
            hintText: 'Search salons, services...',
            hintStyle: TextStyle(
              fontSize: 12.5.sp,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : const Color(0xFF8E8E93),
            ),
          ),
        ),
      ),
    );
  }
}

