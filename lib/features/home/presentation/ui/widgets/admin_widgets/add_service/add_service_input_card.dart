import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class AddServiceInputCard extends StatelessWidget {
  final IconData icon;
  final String iconLabel;
  final String? topLabel;
  final Widget child;

  const AddServiceInputCard({
    super.key,
    required this.icon,
    required this.iconLabel,
    this.topLabel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg =
        isDark ? AppColors.surfaceDark : AppColors.cardBgInputLight;
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : AppColors.cardBorderInputLight;
    final iconColor =
        isDark ? AppColors.textPrimaryDark : AppColors.accentDark;
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryWarm;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: cardBorder, width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Icon Column
          SizedBox(
            width: 44.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 23.sp, color: iconColor),
                SizedBox(height: 3.h),
                Text(
                  iconLabel,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: iconColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Vertical Separator
          Container(
            height: 32.h,
            width: 1.w,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            color: AppColors.cardDividerLight,
          ),

          // Right Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (topLabel != null) ...[
                  Text(
                    topLabel!,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

