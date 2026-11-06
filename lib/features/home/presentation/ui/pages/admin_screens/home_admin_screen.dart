import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/repo/admin_dashboard_repo.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/home_admin/home_admin_appointments_section.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/home_admin/home_admin_earnings_section.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/home_admin/home_admin_header.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/home_admin/home_admin_quick_actions.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/home_admin/home_admin_search_bar.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/home_admin/home_admin_section_divider.dart';

class HomeAdminScreen extends StatelessWidget {
  final AdminDashboardRepo repo;

  const HomeAdminScreen({super.key, this.repo = const AdminDashboardRepo()});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAdminHeader(repo: repo),

            SizedBox(height: 4.h),

            const HomeAdminSearchBar(),

            SizedBox(height: 12.h),

            const HomeAdminQuickActions(),

            SizedBox(height: 14.h),

            const HomeAdminSectionDivider(),

            SizedBox(height: 14.h),

            HomeAdminAppointmentsSection(repo: repo),

            SizedBox(height: 10.h),

            const HomeAdminSectionDivider(),

            SizedBox(height: 14.h),

            HomeAdminEarningsSection(repo: repo),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
