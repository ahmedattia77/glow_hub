import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/appointments/presentation/cubit/appointment_cubit.dart';
import 'package:glow_hub/features/appointments/presentation/ui/widgest/appointments_list.dart';

class AppointmentsTabBarView extends StatelessWidget {
  const AppointmentsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentsState>(
      builder: (context, state) {
        if (state is AppointmentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppointmentsError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: AppColors.errorRed, fontSize: 14.sp),
            ),
          );
        } else if (state is AppointmentsLoaded) {
          if (state.appointments.isEmpty) {
            return const Center(child: Text('No appointments found!'));
          }

          final upcomingList = state.appointments
              .where((b) => b.status.toLowerCase() == 'pending')
              .toList();

          final historyList = state.appointments
              .where((b) => b.status.toLowerCase() != 'pending')
              .toList();

          return TabBarView(
            children: [
              AppointmentsList(appointments: upcomingList, isUpcoming: true),
              AppointmentsList(appointments: historyList, isUpcoming: false),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
