import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/appointments/data/repo/appointments_model.dart';
import 'package:glow_hub/features/appointments/presentation/ui/widgest/appointment_card.dart';

class AppointmentsList extends StatelessWidget {
  final List<AppointmentsModel> appointments;
  final bool isUpcoming;

  const AppointmentsList({
    super.key,
    required this.appointments,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Center(
        child: Text(
          isUpcoming ? 'No upcoming appointments' : 'No past appointments',
          style: TextStyle(fontSize: 14.sp, color: AppColors.hintTextWarm),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final booking = appointments[index];
        return AppointmentCard(booking: booking);
      },
    );
  }
}
