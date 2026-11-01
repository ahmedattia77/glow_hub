import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/header_curved_clipper.dart';

class CurvedAppHeader extends StatelessWidget {
  final Widget? titleWidget;
  final Widget? bottomChild;
  final int notificationCount;
  final VoidCallback? onNotificationPressed;
  final bool showNotification;
  final double? customPaddingBottom;

  const CurvedAppHeader({
    super.key,
    this.titleWidget,
    this.bottomChild,
    this.notificationCount = 0,
    this.onNotificationPressed,
    this.showNotification = true,
    this.customPaddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return ClipPath(
      clipper: HeaderCurvedClipper(),
      child: Container(
        padding: EdgeInsets.only(
          top: 50.h,
          left: 20.w,
          right: 20.w,
          bottom: customPaddingBottom ?? (bottomChild != null ? 35.h : 25.h),
        ),
        decoration: BoxDecoration(color: primaryColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: titleWidget ?? const SizedBox.shrink()),
                if (showNotification)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 4, end: 4),
                    showBadge: notificationCount > 0,
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: Colors.redAccent,
                      padding: EdgeInsets.all(4),
                    ),
                    badgeContent: Text(
                      '$notificationCount',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                      onPressed: onNotificationPressed ?? () {},
                    ),
                  ),
              ],
            ),

            if (bottomChild != null) ...[SizedBox(height: 15.h), bottomChild!],
          ],
        ),
      ),
    );
  }
}
