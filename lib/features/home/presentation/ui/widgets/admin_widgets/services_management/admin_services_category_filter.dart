import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class AdminServicesCategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const AdminServicesCategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const List<String> categories = [
    'All',
    'Hair',
    'Nails',
    'Makeup',
    'Skincare',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: categories.map((cat) {
          final isSelected = selectedCategory == cat;
          final selectedBg =
              isDark ? AppColors.primaryDark : AppColors.accentDarkBrown;
          final selectedText = isDark ? Colors.black : Colors.white;
          final unselectedBg =
              isDark ? AppColors.surfaceDark : AppColors.cardBgLight;
          final unselectedText =
              isDark ? AppColors.textPrimaryDark : AppColors.accentDarkBrown;

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: InkWell(
              onTap: () => onCategorySelected(cat),
              borderRadius: BorderRadius.circular(20.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected ? selectedBg : unselectedBg,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? selectedBg
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : AppColors.cardBorderLight),
                    width: 0.8.w,
                  ),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? selectedText : unselectedText,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

