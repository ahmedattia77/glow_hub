import 'package:flutter/material.dart';
import '../model/appointment_model.dart';
import '../model/earnings_model.dart';
import '../model/quick_action_model.dart';

class AdminHomeRepo {
  const AdminHomeRepo();

  final String salonName = 'Faten Salon';

  final int totalAppointments = 15;
  final int confirmedAppointments = 10;
  final int completedAppointments = 3;
  final int cancelledAppointments = 2;

  List<QuickActionModel> get quickActions => const [
        QuickActionModel(
          title: 'Add\nService',
          icon: Icons.add_rounded,
        ),
        QuickActionModel(
          title: 'Staff',
          icon: Icons.people_outline_rounded,
        ),
        QuickActionModel(
          title: 'Offers',
          icon: Icons.percent_rounded,
        ),
        QuickActionModel(
          title: 'Analytics',
          icon: Icons.insert_chart_outlined_rounded,
        ),
      ];

  List<AppointmentModel> get todayAppointments => const [
        AppointmentModel(
          id: '1',
          clientName: 'Sarah K.',
          service: 'Nails',
          time: '10:30 AM',
          status: AppointmentStatus.confirmed,
          avatarType: ClientAvatarType.sarah,
        ),
        AppointmentModel(
          id: '2',
          clientName: 'Maria L.',
          service: 'Haircut',
          time: '11:45 AM',
          status: AppointmentStatus.confirmed,
          avatarType: ClientAvatarType.maria,
        ),
        AppointmentModel(
          id: '3',
          clientName: 'Fatima A.',
          service: 'Makeup',
          time: '1:00 PM',
          status: AppointmentStatus.completed,
          avatarType: ClientAvatarType.fatima,
        ),
      ];

  EarningsOverviewModel get earningsOverview => const EarningsOverviewModel(
        yAxisMarks: [2500, 2100, 1500, 500],
        bars: [
          EarningsBarData(amount: 720, color: Color(0xFFB87878)),
          EarningsBarData(amount: 580, color: Color(0xFFB87878)),
          EarningsBarData(amount: 2280, color: Color(0xFF2E4E52)),
          EarningsBarData(amount: 1550, color: Color(0xFFB87878)),
          EarningsBarData(amount: 2420, color: Color(0xFF2E4E52)),
        ],
      );
}
