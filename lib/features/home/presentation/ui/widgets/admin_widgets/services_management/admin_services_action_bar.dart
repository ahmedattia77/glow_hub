import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class AdminServicesActionBar extends StatelessWidget {
  final VoidCallback? onAddService;

  const AdminServicesActionBar({
    super.key,
    this.onAddService,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Services',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Manage your salon offers & pricing',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
          // Prominent "Add Service" Button
          InkWell(
            onTap: onAddService ??
                () => Navigator.pushNamed(
                      context,
                      Routes.adminAddServiceScreen,
                    ),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                gradient: isDark
                    ? AppColors.buttonGradientDark
                    : AppColors.roseGoldGradient,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC7847B).withValues(alpha: 0.3),
                    blurRadius: 8.r,
                    offset: Offset(0, 3.h),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 18.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Add Service',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

