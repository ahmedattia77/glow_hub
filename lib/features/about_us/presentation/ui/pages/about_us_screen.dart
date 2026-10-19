import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/common_widgets/custom_app_button.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/about_us/data/repo/about_us_repo.dart';
import 'package:glow_hub/features/about_us/presentation/ui/widgets/about_feature_item.dart';
import 'package:glow_hub/features/about_us/presentation/ui/widgets/about_us_header.dart';

class AboutUsScreen extends StatefulWidget {
  final VoidCallback? onButtonPressed;

  const AboutUsScreen({
    super.key,
    this.onButtonPressed,
  });

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final AboutUsRepo _repo = AboutUsRepo();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Curved Gradient Header with Logo Emblem
            const AboutUsHeader(),

            SizedBox(height: 18.h),

            // Title
            Text(
              _repo.title,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 14.h),

            // Description Paragraph
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                _repo.description,
                textAlign: TextAlign.center,
                style: TextStyle(
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
                children: _repo.features.map((feature) {
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
                onPressed: widget.onButtonPressed ??
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
