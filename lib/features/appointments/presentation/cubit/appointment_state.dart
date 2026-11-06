part of 'appointment_cubit.dart';

@immutable
sealed class AppointmentsState {}

final class AppointsmentInitial extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {}

class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentsModel> appointments;

  AppointmentsLoaded(this.appointments);
}

class AppointmentsError extends AppointmentsState {
  final String message;

  AppointmentsError(this.message);
}

class BookingCancelledState extends AppointmentsState {}
