import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class AddServiceCategorySelector extends StatelessWidget {
  final Set<String> selectedCategories;
  final ValueChanged<String> onCategoryToggle;

  const AddServiceCategorySelector({
    super.key,
    required this.selectedCategories,
    required this.onCategoryToggle,
  });

  static const List<Map<String, dynamic>> _categories = [
    {'label': 'Hair', 'icon': Icons.face_3_rounded},
    {'label': 'Nails', 'icon': Icons.back_hand_rounded},
    {'label': 'Makeup', 'icon': Icons.brush_rounded},
    {'label': 'Skincare', 'icon': Icons.spa_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _categories.map((cat) {
            final label = cat['label'] as String;
            final icon = cat['icon'] as IconData;
            final isSelected = selectedCategories.contains(label);

            return _CategoryChip(
              label: label,
              icon: icon,
              isSelected: isSelected,
              isDark: isDark,
              onTap: () => onCategoryToggle(label),
            );
          }).toList(),
        ),
        SizedBox(height: 10.h),
        Text(
          'Selected: ${selectedCategories.join(', ')}',
          style: TextStyle(
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.primaryDark : AppColors.accentDark,
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedBg =
        isDark ? AppColors.primaryDark : AppColors.accentDark;
    final selectedTextColor = isDark ? Colors.black : Colors.white;
    final unselectedBg =
        isDark ? AppColors.surfaceDark : AppColors.cardBgInputLight;
    final unselectedTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.accentDark;
    final unselectedBorder = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : AppColors.cardBorderInputLight;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 75.w,
        height: 75.w,
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? selectedBg : unselectedBorder,
            width: 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: selectedBg.withValues(alpha: 0.28),
                    blurRadius: 8.r,
                    offset: Offset(0, 3.h),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28.sp,
              color: isSelected ? selectedTextColor : unselectedTextColor,
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: isSelected ? selectedTextColor : unselectedTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

