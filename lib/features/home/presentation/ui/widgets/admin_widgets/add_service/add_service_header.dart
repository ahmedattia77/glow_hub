import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class AddServiceHeader extends StatelessWidget {
  final String salonName;
  final VoidCallback? onBackTap;

  const AddServiceHeader({
    super.key,
    required this.salonName,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textHeaderDark;

    return SizedBox(
      height: 140.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background gentle curved rose gold container
          ClipPath(
            clipper: const _AddServiceHeaderClipper(),
            child: Container(
              height: 125.h,
              decoration: BoxDecoration(
                gradient: isDark
                    ? AppColors.buttonGradientDark
                    : AppColors.roseGoldHeaderGradient,
              ),
            ),
          ),

          // Content Row: Back button on the left, Centered Salon Name, balanced right space
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    // Back Button
                    SizedBox(
                      width: 75.w,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: onBackTap ?? () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 6.h,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18.sp,
                                  color: headerTextColor,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: headerTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Centered Salon Name
                    Expanded(
                      child: Center(
                        child: Text(
                          salonName,
                          style: TextStyle(
                            fontSize: 18.5.sp,
                            fontWeight: FontWeight.w800,
                            color: headerTextColor,
                            letterSpacing: 0.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // Balanced right spacer to ensure symmetrical center alignment
                    SizedBox(width: 75.w),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddServiceHeaderClipper extends CustomClipper<Path> {
  const _AddServiceHeaderClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 24);

    final controlPoint = Offset(size.width / 2, size.height + 12);
    final endPoint = Offset(size.width, size.height - 24);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

