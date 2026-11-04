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

  const HomeAdminScreen({
    super.key,
    this.repo = const AdminDashboardRepo(),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Curved Rose Gold Top Header (Dynamic from Firestore + Salon Details Modal)
            HomeAdminHeader(repo: repo),

            SizedBox(height: 4.h),

            // 2. Search Bar
            const HomeAdminSearchBar(),

            SizedBox(height: 12.h),

            // 3. Quick Action Cards (Add Service, Staff, Offers, Analytics)
            const HomeAdminQuickActions(),

            SizedBox(height: 14.h),

            // Full-width Section Divider 1
            const HomeAdminSectionDivider(),

            SizedBox(height: 14.h),

            // 4. Today's Appointments Section (2x2 Summary + Appointments List)
            HomeAdminAppointmentsSection(repo: repo),

            SizedBox(height: 10.h),

            // Full-width Section Divider 2
            const HomeAdminSectionDivider(),

            SizedBox(height: 14.h),

            // 5. Earnings Overview Section (Bar Chart)
            HomeAdminEarningsSection(repo: repo),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
