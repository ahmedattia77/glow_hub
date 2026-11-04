import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/header_curved_clipper.dart';

class HomeAdminCurvedHeader extends StatelessWidget {
  final String salonName;
  final VoidCallback? onSalonTap;
  final VoidCallback? onNotificationsTap;

  const HomeAdminCurvedHeader({
    super.key,
    required this.salonName,
    this.onSalonTap,
    this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF2A2323);

    return SizedBox(
      height: 142.h,
      child: Stack(
        children: [
          ClipPath(
            clipper: HeaderCurvedClipper(),
            child: Container(
              height: 124.h,
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
              padding: EdgeInsets.only(
                left: 18.w,
                right: 18.w,
                top: 12.h,
                bottom: 4.h,
              ),
              child: Row(
                children: [
                  SizedBox(width: 32.w),
                  Expanded(
                    child: InkWell(
                      onTap: onSalonTap,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              salonName,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 17.5.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.2,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: textColor,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onNotificationsTap,
                    borderRadius: BorderRadius.circular(20.r),
                    child: SizedBox(
                      width: 32.w,
                      height: 32.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.notifications_none_rounded,
                            color: textColor,
                            size: 23.sp,
                          ),
                          Positioned(
                            top: 3.h,
                            right: 4.w,
                            child: Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: AppColors.errorRed,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.2.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

