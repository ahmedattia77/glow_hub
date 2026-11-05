import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';

class AdminServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onDelete;

  const AdminServiceCard({
    super.key,
    required this.service,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.surfaceDark : AppColors.cardBgLight;
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : AppColors.cardBorderLight;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final IconData categoryIcon = _getCategoryIcon(service.category);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: cardBorder, width: 0.8.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Icon Container
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primaryDark.withValues(alpha: 0.15)
                      : const Color(0xFFE8B7B0).withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  categoryIcon,
                  size: 22.sp,
                  color: isDark
                      ? AppColors.primaryDark
                      : const Color(0xFF8A4F46),
                ),
              ),

              SizedBox(width: 12.w),

              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                    ),
                    if (service.description.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        service.description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: secondaryTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Delete Menu Option
              IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.redAccent.withValues(alpha: 0.8),
                  size: 20.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onDelete,
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Details Row: Price, Duration, Category badge, Home service badge
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Price
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${service.price.toStringAsFixed(0)} EGP',
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.successGreen,
                  ),
                ),
              ),

              // Discount (if any)
              if (service.discount != null && service.discount! > 0)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '-${service.discount!.toStringAsFixed(0)} EGP',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),

              // Duration
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 13.sp,
                    color: secondaryTextColor,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    '${service.durationMinutes} min',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Category Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : AppColors.accentDarkBrown.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  service.category,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.accentDarkBrown,
                  ),
                ),
              ),

              // Home Service Available
              if (service.isHomeServiceAvailable)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 13.sp,
                      color: AppColors.successGreen,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Home Service',
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.successGreen,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    final cat = category.toLowerCase();
    if (cat.contains('hair')) {
      return Icons.face_retouching_natural_rounded;
    } else if (cat.contains('nail')) {
      return Icons.back_hand_outlined;
    } else if (cat.contains('makeup')) {
      return Icons.brush_rounded;
    } else if (cat.contains('skin')) {
      return Icons.spa_outlined;
    }
    return Icons.auto_awesome_rounded;
  }
}

