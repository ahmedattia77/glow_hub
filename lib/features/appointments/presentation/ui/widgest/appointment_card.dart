import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/appointments/data/repo/appointments_model.dart';
import 'package:glow_hub/features/appointments/presentation/cubit/appointment_cubit.dart';
import 'package:glow_hub/features/appointments/presentation/ui/pages/client_appointments_screen.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentsModel booking;

  const AppointmentCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPending = booking.status.toLowerCase() == 'pending';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppointmentCardHeader(
            salonId: booking.salonId,
            status: booking.status,
            isPending: isPending,
          ),
          SizedBox(height: 8.h),
          AppointmentCardDate(
            date: '${booking.selectedDay} • ${booking.timeSlot}',
          ),
          SizedBox(height: 8.h),
          Divider(color: colorScheme.outline.withValues(alpha: 0.1)),

          ...booking.services.asMap().entries.map((entry) {
            final idx = entry.key;
            final service = entry.value;
            final isHome = booking.homeServiceIndices.contains(idx);

            return AppointmentServiceRow(
              serviceName: service.name,
              isHomeService: isHome,
            );
          }),

          SizedBox(height: 8.h),
          Divider(color: colorScheme.outline.withValues(alpha: 0.1)),

          AppointmentCardFooter(
            totalPrice: booking.totalPrice,
            isPending: isPending,
            onCancel: () {
              final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
              context.read<AppointmentCubit>().cancelUserBooking(
                booking.bookingId,
                userId,
              );
            },
          ),
        ],
      ),
    );
  }
}
