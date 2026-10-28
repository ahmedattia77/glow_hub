import 'package:flutter/material.dart';

enum AppointmentStatus {
  confirmed,
  completed,
  cancelled,
}

enum ClientAvatarType {
  sarah,
  maria,
  fatima,
}

class QuickActionItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const QuickActionItem({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class AppointmentItem {
  final String id;
  final String clientName;
  final String service;
  final String time;
  final AppointmentStatus status;
  final ClientAvatarType avatarType;

  const AppointmentItem({
    required this.id,
    required this.clientName,
    required this.service,
    required this.time,
    required this.status,
    required this.avatarType,
  });

  String get statusText {
    switch (status) {
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class EarningsBarItem {
  final double amount;
  final Color? color;

  const EarningsBarItem({
    required this.amount,
    this.color,
  });
}
