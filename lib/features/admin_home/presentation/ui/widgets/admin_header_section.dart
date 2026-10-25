import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/common_widgets/curved_header_background.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/admin_home/data/model/quick_action_model.dart';
import 'package:glow_hub/features/admin_home/data/repo/admin_home_repo.dart';

class AdminHeaderSection extends StatelessWidget {
  final AdminHomeRepo repo;
  final VoidCallback? onSalonTap;
  final VoidCallback? onNotificationsTap;
  final ValueChanged<String>? onSearchChanged;

  const AdminHeaderSection({
    super.key,
    required this.repo,
    this.onSalonTap,
    this.onNotificationsTap,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Curved Rose Gold Top Header with camera cutout clearance
        _CurvedTopBar(
          salonName: repo.salonName,
          onSalonTap: onSalonTap,
          onNotificationsTap: onNotificationsTap,
        ),

        SizedBox(height: 4.h),

        // 2. Compact Rounded Search Bar
        _SearchBar(onChanged: onSearchChanged),

        SizedBox(height: 12.h),

        // 3. Quick Action Cards Row (Add Service, Staff, Offers, Analytics)
        _QuickActionsRow(actions: repo.quickActions),
      ],
    );
  }
}

class _CurvedTopBar extends StatelessWidget {
  final String salonName;
  final VoidCallback? onSalonTap;
  final VoidCallback? onNotificationsTap;

  const _CurvedTopBar({
    required this.salonName,
    this.onSalonTap,
    this.onNotificationsTap,
  });

  // Silky metallic rose gold gradient matching the design
  static const LinearGradient roseGoldGradient = LinearGradient(
    colors: [
      Color(0xFFE8B7B0), // Champagne Rose Gold
      Color(0xFFD89B92), // Metallic Blush Mid
      Color(0xFFC7847B), // Warm Rose Depth
    ],
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
          // Background Gradient with bottom curve
          ClipPath(
            clipper: const CurvedHeaderClipper(),
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

          // Header Content with proper top padding to avoid camera cutout
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

                  // Center: Salon Selector
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

                  // Right: Notification Bell with Badge
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

class _SearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const _SearchBar({this.onChanged});

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

class _QuickActionsRow extends StatelessWidget {
  final List<QuickActionModel> actions;

  const _QuickActionsRow({required this.actions});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg =
        isDark ? AppColors.surfaceDark : const Color(0xFFFBF1EC);
    final iconColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF2C2C2C);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // 1. Add Service
          Expanded(
            child: _buildCard(
              title: 'Add\nService',
              iconWidget: Icon(
                Icons.add_rounded,
                size: 24.sp,
                color: iconColor,
              ),
              cardBg: cardBg,
              iconColor: iconColor,
              isDark: isDark,
              onTap: actions.isNotEmpty ? actions[0].onTap : null,
            ),
          ),
          SizedBox(width: 8.w),

          // 2. Staff (clean people outline)
          Expanded(
            child: _buildCard(
              title: 'Staff',
              iconWidget: Icon(
                Icons.people_outline_rounded,
                size: 24.sp,
                color: iconColor,
              ),
              cardBg: cardBg,
              iconColor: iconColor,
              isDark: isDark,
              onTap: actions.length > 1 ? actions[1].onTap : null,
            ),
          ),
          SizedBox(width: 8.w),

          // 3. Offers (scalloped percent badge)
          Expanded(
            child: _buildCard(
              title: 'Offers',
              iconWidget: _OffersBadgeIcon(color: iconColor),
              cardBg: cardBg,
              iconColor: iconColor,
              isDark: isDark,
              onTap: actions.length > 2 ? actions[2].onTap : null,
            ),
          ),
          SizedBox(width: 8.w),

          // 4. Analytics (3 vertical bars, NO frame box!)
          Expanded(
            child: _buildCard(
              title: 'Analytics',
              iconWidget: Icon(
                Icons.bar_chart_rounded,
                size: 24.sp,
                color: iconColor,
              ),
              cardBg: cardBg,
              iconColor: iconColor,
              isDark: isDark,
              onTap: actions.length > 3 ? actions[3].onTap : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required Widget iconWidget,
    required Color cardBg,
    required Color iconColor,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
              child: Center(child: iconWidget),
            ),
            SizedBox(height: 5.h),
            Text(
              title,
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
    );
  }
}

// Scalloped circular badge with % in center matching the design
class _OffersBadgeIcon extends StatelessWidget {
  final Color color;

  const _OffersBadgeIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22.sp,
      height: 22.sp,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(22.sp, 22.sp),
            painter: _BadgePainter(color: color),
          ),
          Text(
            '%',
            style: TextStyle(
              color: color,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgePainter extends CustomPainter {
  final Color color;

  _BadgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw circular outline with subtle scalloped / rosette points
    canvas.drawCircle(center, radius - 1, paint);
  }

  @override
  bool shouldRepaint(covariant _BadgePainter oldDelegate) =>
      oldDelegate.color != color;
}
