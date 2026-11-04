import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class AdminServicesEmptyState extends StatelessWidget {
  final VoidCallback onAddService;

  const AdminServicesEmptyState({
    super.key,
    required this.onAddService,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFC7847B).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.spa_outlined,
                size: 50.sp,
                color: const Color(0xFFC7847B),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Services Added Yet',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Start showcasing your beauty services, pricing, and timing to your clients.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: secondaryTextColor,
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: onAddService,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC7847B),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 22.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 3,
              ),
              icon: const Icon(Icons.add_rounded),
              label: Text(
                'Add Your First Service',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

