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

class AppointmentModel {
  final String id;
  final String clientName;
  final String service;
  final String time;
  final AppointmentStatus status;
  final ClientAvatarType avatarType;

  const AppointmentModel({
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
