import 'package:flutter/material.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import '../model/admin_dashboard_models.dart';

class AdminDashboardRepo {
  const AdminDashboardRepo();

  final String salonName = 'Faten Salon';

  /// Real-time stream of the current owner's salon name from Firestore
  Stream<String> get ownerSalonNameStream {
    final currentUid = FireBaseInitial.auth.currentUser?.uid;
    if (currentUid == null) {
      return Stream.value(salonName);
    }
    return FireBaseInitial.firestore
        .collection('salons')
        .where('ownerId', isEqualTo: currentUid)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        final name = data['salonName'] as String?;
        if (name != null && name.trim().isNotEmpty) {
          return name.trim();
        }
      }
      return salonName;
    });
  }

  /// Real-time stream of the current owner's full salon data from Firestore
  Stream<Map<String, dynamic>?> get ownerSalonDataStream {
    final currentUid = FireBaseInitial.auth.currentUser?.uid;
    if (currentUid == null) {
      return Stream.value(null);
    }
    return FireBaseInitial.firestore
        .collection('salons')
        .where('ownerId', isEqualTo: currentUid)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      }
      return null;
    });
  }

  /// One-time fetch of the current owner's salon name
  Future<String> fetchOwnerSalonName() async {
    try {
      final currentUid = FireBaseInitial.auth.currentUser?.uid;
      if (currentUid == null) return salonName;

      final snapshot = await FireBaseInitial.firestore
          .collection('salons')
          .where('ownerId', isEqualTo: currentUid)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        final name = data['salonName'] as String?;
        if (name != null && name.trim().isNotEmpty) {
          return name.trim();
        }
      }
      return salonName;
    } catch (_) {
      return salonName;
    }
  }

  final int totalAppointments = 15;
  final int confirmedAppointments = 10;
  final int completedAppointments = 3;
  final int cancelledAppointments = 2;

  List<QuickActionItem> get quickActions => const [
        QuickActionItem(
          title: 'Add\nService',
          icon: Icons.add_rounded,
        ),
        QuickActionItem(
          title: 'Staff',
          icon: Icons.people_outline_rounded,
        ),
        QuickActionItem(
          title: 'Offers',
          icon: Icons.percent_rounded,
        ),
        QuickActionItem(
          title: 'Analytics',
          icon: Icons.bar_chart_rounded,
        ),
      ];

  List<AppointmentItem> get todayAppointments => const [
        AppointmentItem(
          id: '1',
          clientName: 'Sarah K.',
          service: 'Nails',
          time: '10:30 AM',
          status: AppointmentStatus.confirmed,
          avatarType: ClientAvatarType.sarah,
        ),
        AppointmentItem(
          id: '2',
          clientName: 'Maria L.',
          service: 'Haircut',
          time: '11:45 AM',
          status: AppointmentStatus.confirmed,
          avatarType: ClientAvatarType.maria,
        ),
        AppointmentItem(
          id: '3',
          clientName: 'Fatima A.',
          service: 'Makeup',
          time: '1:00 PM',
          status: AppointmentStatus.completed,
          avatarType: ClientAvatarType.fatima,
        ),
      ];

  List<double> get yAxisMarks => const [2500, 2100, 1500, 500];

  List<EarningsBarItem> get earningsBars => const [
        EarningsBarItem(amount: 720, color: Color(0xFFB87878)),
        EarningsBarItem(amount: 580, color: Color(0xFFB87878)),
        EarningsBarItem(amount: 2280, color: Color(0xFF2E4E52)),
        EarningsBarItem(amount: 1550, color: Color(0xFFB87878)),
        EarningsBarItem(amount: 2420, color: Color(0xFF2E4E52)),
      ];
}
