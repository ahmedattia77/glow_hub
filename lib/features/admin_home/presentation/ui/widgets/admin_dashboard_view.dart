import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/admin_home/data/repo/admin_home_repo.dart';
import 'admin_header_section.dart';
import 'appointments_section.dart';
import 'earnings_section.dart';

class AdminDashboardView extends StatelessWidget {
  final AdminHomeRepo repo;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onSalonTap;

  const AdminDashboardView({
    super.key,
    this.repo = const AdminHomeRepo(),
    this.onNotificationsTap,
    this.onSalonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Section: Curved Header + Search Bar + Quick Actions Row
          AdminHeaderSection(
            repo: repo,
            onSalonTap: onSalonTap,
            onNotificationsTap: onNotificationsTap,
          ),

          SizedBox(height: 14.h),

          // Full-width Section Divider 1 (after Quick Actions)
          const _SectionDivider(),

          SizedBox(height: 14.h),

          // 2. Middle Section: Today's Appointments (Summary & List)
          AppointmentsSection(
            total: repo.totalAppointments,
            confirmed: repo.confirmedAppointments,
            completed: repo.completedAppointments,
            cancelled: repo.cancelledAppointments,
            appointments: repo.todayAppointments,
          ),

          SizedBox(height: 10.h),

          // Full-width Section Divider 2 (after Appointments)
          const _SectionDivider(),

          SizedBox(height: 14.h),

          // 3. Bottom Section: Earnings Overview (Bar Chart)
          EarningsSection(
            model: repo.earningsOverview,
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

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
