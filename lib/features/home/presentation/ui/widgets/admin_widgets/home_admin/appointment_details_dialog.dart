import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/admin_dashboard_models.dart';

void showAppointmentDetailsDialog(
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
          Text(
            'Service: ${appointment.service}',
            style: TextStyle(fontSize: 13.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            'Time: ${appointment.time}',
            style: TextStyle(fontSize: 13.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            'Status: ${appointment.statusText}',
            style: TextStyle(fontSize: 13.sp),
          ),
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

