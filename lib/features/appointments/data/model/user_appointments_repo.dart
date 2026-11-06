import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/appointments/data/repo/appointments_model.dart';

class UserAppointmentsRepo {
  Future<List<AppointmentsModel>> fetchUserAppointments(String userId) async {
    try {
      final querySnapshot = await FireBaseInitial.firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => AppointmentsModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      final querySnapshot = await FireBaseInitial.firestore
          .collection('bookings')
          .where('bookingId', isEqualTo: bookingId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await FireBaseInitial.firestore
            .collection('bookings')
            .doc(docId)
            .update({'status': 'cancelled'});
      } else {
        throw Exception('Booking not found');
      }
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }
}
