import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'add_service_category_selector.dart';

class AddServiceCategorySection extends StatelessWidget {
  final Set<String> selectedCategories;
  final ValueChanged<String> onCategoryToggle;

  const AddServiceCategorySection({
    super.key,
    required this.selectedCategories,
    required this.onCategoryToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF241816);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(
            fontSize: 18.5.sp,
            fontWeight: FontWeight.w800,
            color: primaryTextColor,
          ),
        ),
        SizedBox(height: 10.h),
        AddServiceCategorySelector(
          selectedCategories: selectedCategories,
          onCategoryToggle: onCategoryToggle,
        ),
      ],
    );
  }
}

