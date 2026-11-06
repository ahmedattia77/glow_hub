import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/appointments/presentation/ui/widgest/appointments_tab_bar_view.dart';

class ClientAppointmentsScreen extends StatelessWidget {
  const ClientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: const AppointmentsTabBarView(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      title: Text(
        'My Appointments',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      centerTitle: true,
      bottom: TabBar(
        labelColor: colorScheme.primary,
        unselectedLabelColor: Colors.grey,
        indicatorColor: colorScheme.primary,
        tabs: const [
          Tab(text: 'Upcoming'),
          Tab(text: 'History'),
        ],
      ),
    );
  }
}

class AppointmentCardHeader extends StatelessWidget {
  final String salonId;
  final String status;
  final bool isPending;

  const AppointmentCardHeader({
    super.key,
    required this.salonId,
    required this.status,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Salon ID: ',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isPending
                ? Colors.orange.withValues(alpha: 0.1)
                : Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status.toUpperCase(),
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: isPending ? Colors.orange : Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}

class AppointmentCardDate extends StatelessWidget {
  final String date;

  const AppointmentCardDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(
          Icons.calendar_today_rounded,
          size: 14,
          color: colorScheme.primary,
        ),
        SizedBox(width: 6.w),
        Text(
          date,
          style: TextStyle(
            fontSize: 12.sp,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class AppointmentServiceRow extends StatelessWidget {
  final String serviceName;
  final bool isHomeService;

  const AppointmentServiceRow({
    super.key,
    required this.serviceName,
    required this.isHomeService,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 14,
                color: Colors.grey,
              ),
              SizedBox(width: 6.w),
              Text(
                serviceName,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          if (isHomeService)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AppointmentCardFooter extends StatelessWidget {
  final double totalPrice;
  final bool isPending;
  final VoidCallback onCancel;

  const AppointmentCardFooter({
    super.key,
    required this.totalPrice,
    required this.isPending,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total: \$${totalPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        if (isPending)
          OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
              minimumSize: Size(60.w, 28.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text('Cancel', style: TextStyle(fontSize: 11.sp)),
          ),
      ],
    );
  }
}
