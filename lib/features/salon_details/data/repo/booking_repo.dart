import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';

class BookingRepo {
  Future<void> createBooking({
    required String salonId,
    required List<ServiceModel> selectedServices,
    required List<int> homeServiceIndices,
    required double totalPrice,
    required String selectedDay,
    required String timeSlot,
    bool isHomeService = false,
  }) async {
    try {
      final uid = FireBaseInitial.auth.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');

      final bookingDocRef = FireBaseInitial.firestore
          .collection('bookings')
          .doc();
      final bookingId = bookingDocRef.id;

      // 1. تحويل List<ServiceModel> لـ List of Maps مع إضافة حالة الـ Home Service لكل خدمة
      final servicesJson = selectedServices.asMap().entries.map((entry) {
        final index = entry.key;
        final service = entry.value;
        final serviceMap = service.toJson();

        // إضافة دلالة هل الخدمة دي محددة هوم سيرفس في الحجز ده ولا لأ
        serviceMap['requestedAtHome'] = homeServiceIndices.contains(index);

        return serviceMap;
      }).toList();

      final bookingData = {
        'bookingId': bookingId,
        'userId': uid,
        'salonId': salonId,
        'services': servicesJson,
        'totalPrice': totalPrice,
        'selectedDay': selectedDay,
        'timeSlot': timeSlot,
        'isHomeService': homeServiceIndices
            .isNotEmpty, // true لو فيه على الأقل خدمة واحدة منزلية
        'homeServiceIndices': homeServiceIndices,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await bookingDocRef.set(bookingData);
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }
}
