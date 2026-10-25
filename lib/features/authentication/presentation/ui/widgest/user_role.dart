import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// declaring user role
enum UserRole { client, admin }

class RoleSelectorWidget extends StatelessWidget {
  final UserRole selectedRole;
  final ValueChanged<UserRole> onRoleSelected;

  const RoleSelectorWidget({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I want to register as:",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: _buildRoleCard(
                context,
                title: "client",
                icon: Icons.person_outline,
                role: UserRole.client,
                isSelected: selectedRole == UserRole.client,
                primaryColor: primaryColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildRoleCard(
                context,
                title: "Salon Owner",
                icon: Icons.storefront_outlined,
                role: UserRole.admin,
                isSelected: selectedRole == UserRole.admin,
                primaryColor: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required UserRole role,
    required bool isSelected,
    required Color primaryColor,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onRoleSelected(role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.12)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : theme.colorScheme.onSurface.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: isSelected
                  ? primaryColor
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            SizedBox(height: 6.h),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? primaryColor : theme.colorScheme.onSurface,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
