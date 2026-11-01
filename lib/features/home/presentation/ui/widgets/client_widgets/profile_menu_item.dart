import 'package:flutter/material.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final logOutColor = isdark ? AppColors.primaryDark : AppColors.primaryLight;
    final color = isLogout ? logOutColor : theme.iconTheme.color;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: theme.hintColor,
      ),
      onTap: onTap,
    );
  }
}
