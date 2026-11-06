import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/header_curved_clipper.dart';

class AdminServicesHeader extends StatelessWidget {
  final String salonName;

  const AdminServicesHeader({
    super.key,
    required this.salonName,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF2A2323);

    return SizedBox(
      height: 124.h,
      child: Stack(
        children: [
          ClipPath(
            clipper: HeaderCurvedClipper(),
            child: Container(
              height: 108.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: isDark
                    ? AppColors.buttonGradientDark
                    : AppColors.roseGoldGradient,
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          salonName,
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            color: headerTextColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Services Management',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: headerTextColor.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      size: 20.sp,
                      color: headerTextColor,
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

