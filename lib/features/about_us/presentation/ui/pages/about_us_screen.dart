import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/common_widgets/curved_header_background.dart';
import 'package:glow_hub/core/common_widgets/custom_app_button.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/about_us/data/repo/about_us_repo.dart';
import 'package:glow_hub/features/about_us/presentation/ui/widgets/about_feature_item.dart';

class AboutUsScreen extends StatelessWidget {
  final VoidCallback? onButtonPressed;
  final AboutUsRepo repo;

  const AboutUsScreen({
    super.key,
    this.onButtonPressed,
    this.repo = const AboutUsRepo(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Curved Gradient Header Background
            const CurvedHeaderBackground(),

            SizedBox(height: 18.h),

            // Title
            Text(
              repo.title,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 26.sp,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 14.h),

            // Description Paragraph
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                repo.description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13.5.sp,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  height: 1.55,
                  letterSpacing: 0.1,
                ),
              ),
            ),

            SizedBox(height: 34.h),

            // Three Action / Feature Items Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: repo.features.map((feature) {
                  return Expanded(
                    child: AboutFeatureItem(model: feature),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 48.h),

            // Bottom Action Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomAppButton(
                text: "About Us",
                onPressed: onButtonPressed ??
                    () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
