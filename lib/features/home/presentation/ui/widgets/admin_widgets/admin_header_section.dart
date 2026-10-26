import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/admin_dashboard_models.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/header_curved_clipper.dart';

/// 1. Curved Rose Gold Top Header
class AdminCurvedHeader extends StatelessWidget {
  final String salonName;
  final VoidCallback? onSalonTap;
  final VoidCallback? onNotificationsTap;

  const AdminCurvedHeader({
    super.key,
    required this.salonName,
    this.onSalonTap,
    this.onNotificationsTap,
  });

  static const LinearGradient roseGoldGradient = LinearGradient(
    colors: [Color(0xFFE8B7B0), Color(0xFFD89B92), Color(0xFFC7847B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
                    : roseGoldGradient,
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
                                color: const Color(0xFFE53935),
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

/// 2. Admin Search Bar
class AdminSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const AdminSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : const Color(0xFFF3F3F5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : const Color(0xFFE5E5EA),
            width: 0.9.w,
          ),
        ),
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 13.sp,
            color:
                isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
            isDense: true,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : const Color(0xFF8E8E93),
              size: 19.sp,
            ),
            hintText: 'Search salons, services...',
            hintStyle: TextStyle(
              fontSize: 12.5.sp,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : const Color(0xFF8E8E93),
            ),
          ),
        ),
      ),
    );
  }
}

/// 3. Admin Quick Actions Grid
class AdminQuickActions extends StatelessWidget {
  final List<QuickActionItem> actions;

  const AdminQuickActions({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : const Color(0xFFFBF1EC);
    final iconColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF2C2C2C);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: actions.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index < actions.length - 1 ? 8.w : 0,
              ),
              child: InkWell(
                onTap: item.onTap,
                borderRadius: BorderRadius.circular(14.r),
                child: Container(
                  height: 74.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : const Color(0xFFF2DFD7),
                      width: 0.8.w,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24.sp,
                        child: Center(
                          child: item.icon == Icons.percent_rounded
                              ? Container(
                                  width: 22.sp,
                                  height: 22.sp,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: iconColor,
                                      width: 1.4,
                                    ),
                                  ),
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                      color: iconColor,
                                      fontSize: 10.5.sp,
                                      fontWeight: FontWeight.w800,
                                      height: 1.0,
                                    ),
                                  ),
                                )
                              : Icon(item.icon, size: 24.sp, color: iconColor),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: iconColor,
                          height: 1.15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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

/// 4. Section Divider
class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 7.5.h,
      color: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : const Color(0xFFEFEFF2),
    );
  }
}
