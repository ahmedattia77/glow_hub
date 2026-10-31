import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/admin_dashboard_models.dart';
import 'package:glow_hub/features/home/data/repo/admin_dashboard_repo.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/admin_appointments_section.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/admin_earnings_section.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/admin_header_section.dart';

class HomeAdminScreen extends StatefulWidget {
  final AdminDashboardRepo repo;

  const HomeAdminScreen({
    super.key,
    this.repo = const AdminDashboardRepo(),
  });

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final repo = widget.repo;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Curved Rose Gold Top Header (Dynamic from Firestore)
            StreamBuilder<String>(
              stream: repo.ownerSalonNameStream,
              initialData: repo.salonName,
              builder: (context, snapshot) {
                final currentSalonName = snapshot.data ?? repo.salonName;

                return AdminCurvedHeader(
                  salonName: currentSalonName,
                  onSalonTap: () => _showSalonDetailsModal(context, currentSalonName),
                  onNotificationsTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No new notifications today'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),

            SizedBox(height: 4.h),

            // 2. Search Bar
            const AdminSearchBar(),

            SizedBox(height: 12.h),

            // 3. Quick Action Cards (Add Service, Staff, Offers, Analytics)
            AdminQuickActions(
              actions: _getQuickActions(context),
            ),

            SizedBox(height: 14.h),

            // Full-width Section Divider 1
            const SectionDivider(),

            SizedBox(height: 14.h),

            // 4. Today's Appointments Section (2x2 Summary + Appointments List)
            AdminAppointmentsSection(
              total: repo.totalAppointments,
              confirmed: repo.confirmedAppointments,
              completed: repo.completedAppointments,
              cancelled: repo.cancelledAppointments,
              appointments: repo.todayAppointments,
              onAppointmentTap: (appointment) {
                _showAppointmentDetails(context, appointment);
              },
            ),

            SizedBox(height: 10.h),

            // Full-width Section Divider 2
            const SectionDivider(),

            SizedBox(height: 14.h),

            // 5. Earnings Overview Section (Bar Chart)
            AdminEarningsSection(
              yAxisMarks: repo.yAxisMarks,
              bars: repo.earningsBars,
            ),

            SizedBox(height: 32.h),
          ],
        ),
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
          _showActionNotice(
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
          _showActionNotice(
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
          _showActionNotice(
            context,
            'Analytics & Revenue',
            'Detailed reports on bookings, client retention, and daily revenue.',
          );
        },
      ),
    ];
  }

  void _showActionNotice(
    BuildContext context,
    String title,
    String description,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        content: Text(
          description,
          style: TextStyle(
            fontSize: 13.5.sp,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAppointmentDetails(
    BuildContext context,
    AppointmentItem appointment,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: Text(
          appointment.clientName,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service: ${appointment.service}', style: TextStyle(fontSize: 13.sp)),
            SizedBox(height: 6.h),
            Text('Time: ${appointment.time}', style: TextStyle(fontSize: 13.sp)),
            SizedBox(height: 6.h),
            Text('Status: ${appointment.statusText}', style: TextStyle(fontSize: 13.sp)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSalonDetailsModal(BuildContext context, String currentSalonName) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final email = FireBaseInitial.auth.currentUser?.email ?? 'owner@glowhub.com';

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.primaryDark.withValues(alpha: 0.2)
                          : const Color(0xFFFBF1EC),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.storefront_rounded,
                      color: isDark
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSalonName,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : const Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Open',
                      style: TextStyle(
                        color: const Color(0xFF2E7D32),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.logout_rounded,
                  color: Colors.redAccent,
                  size: 22.sp,
                ),
                title: Text(
                  'Log Out (تسجيل الخروج)',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                onTap: () async {
                  Navigator.pop(ctx);
                  await FireBaseInitial.auth.signOut();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.onboarding,
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
