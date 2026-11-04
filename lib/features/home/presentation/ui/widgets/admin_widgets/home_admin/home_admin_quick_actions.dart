import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/admin_dashboard_models.dart';
import 'action_notice_dialog.dart';

class HomeAdminQuickActions extends StatelessWidget {
  const HomeAdminQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = _getQuickActions(context);
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
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
                              : Icon(item.icon,
                                  size: 24.sp, color: iconColor),
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

  List<QuickActionItem> _getQuickActions(BuildContext context) {
    return [
      QuickActionItem(
        title: 'Add\nService',
        icon: Icons.add_rounded,
        onTap: () {
          Navigator.pushNamed(context, Routes.adminAddServiceScreen);
        },
      ),
      QuickActionItem(
        title: 'Staff',
        icon: Icons.people_outline_rounded,
        onTap: () {
          showActionNoticeDialog(
            context,
            'Staff Management',
            'Manage salon specialists, team shifts, and assignments.',
          );
        },
      ),
      QuickActionItem(
        title: 'Offers',
        icon: Icons.percent_rounded,
        onTap: () {
          showActionNoticeDialog(
            context,
            'Special Offers',
            'Create discount vouchers and seasonal packages for clients.',
          );
        },
      ),
      QuickActionItem(
        title: 'Analytics',
        icon: Icons.bar_chart_rounded,
        onTap: () {
          showActionNoticeDialog(
            context,
            'Analytics & Revenue',
            'Detailed reports on bookings, client retention, and daily revenue.',
          );
        },
      ),
    ];
  }
}

