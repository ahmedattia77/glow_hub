import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/about_us/data/model/about_feature_model.dart';

class AboutFeatureItem extends StatelessWidget {
  final AboutFeatureModel model;

  const AboutFeatureItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: model.onTap,
          borderRadius: BorderRadius.circular(30.r),
          child: Container(
            width: 58.w,
            height: 58.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppColors.surfaceDark : Colors.white,
              border: Border.all(
                color: primaryColor.withValues(alpha: 0.35),
                width: 1.2.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Icon(
              model.icon,
              size: 24.sp,
              color: primaryColor,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}
