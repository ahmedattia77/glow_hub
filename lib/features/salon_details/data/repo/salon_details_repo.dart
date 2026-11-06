import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/salon_details/data/model/salon_details_model.dart';

class SalonDetailsRepo {
  Future<SalonDetailsModel> getSalonDetails(String salonId) async {
    try {
      final docSnapshot = await FireBaseInitial.firestore
          .collection('salons')
          .doc(salonId)
          .get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        return SalonDetailsModel.fromJson(docSnapshot.data()!, docSnapshot.id);
      } else {
        throw Exception('Salon details not found');
      }
    } catch (e) {
      throw Exception('Failed to load salon details: $e');
    }
  }
}
