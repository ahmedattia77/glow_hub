import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/salon_details/data/model/salon_details_model.dart';

class SalonDetailsRepo {
  Future<SalonDetailsModel> getSalonDetails(String salonId) async {
    try {
      final docSnapshot = await FireBaseInitial.firestore
          .collection('salons')
          .doc(salonId)
          .get();

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        throw Exception('Salon details not found');
      }

      final salonData = docSnapshot.data()!;

      final servicesSnapshot = await FireBaseInitial.firestore
          .collection('salons')
          .doc(salonId)
          .collection('services')
          .get();

      final servicesList = servicesSnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      salonData['services'] = servicesList;

      return SalonDetailsModel.fromJson(salonData, docSnapshot.id);
    } catch (e) {
      throw Exception('Failed to load salon details: $e');
    }
  }
}
