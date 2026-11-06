import 'package:bloc/bloc.dart';
import 'package:glow_hub/features/appointments/data/model/user_appointments_repo.dart';
import 'package:glow_hub/features/appointments/data/repo/appointments_model.dart';
import 'package:meta/meta.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentsState> {
  final UserAppointmentsRepo appointmentsRepo;
  AppointmentCubit(this.appointmentsRepo) : super(AppointsmentInitial());

  Future<void> getUserAppointments(String userId) async {
    emit(AppointmentsLoading());
    try {
      final appointments = await appointmentsRepo.fetchUserAppointments(userId);
      emit(AppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> cancelUserBooking(String bookingId, String userId) async {
    try {
      emit(AppointmentsLoading());
      await appointmentsRepo.cancelBooking(bookingId);

      await getUserAppointments(userId);
    } catch (e) {
      emit(AppointmentsError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
