import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';

class ServicesRepo {
  const ServicesRepo();

  /// Get the current owner's salon ID
  Future<String?> getOwnerSalonId() async {
    try {
      final uid = FireBaseInitial.auth.currentUser?.uid;
      if (uid == null) return null;

      final snapshot = await FireBaseInitial.firestore
          .collection('salons')
          .where('ownerId', isEqualTo: uid)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Get the current owner's salon name
  Future<String> getOwnerSalonName() async {
    try {
      final uid = FireBaseInitial.auth.currentUser?.uid;
      if (uid == null) return 'Dois Salon';

      final snapshot = await FireBaseInitial.firestore
          .collection('salons')
          .where('ownerId', isEqualTo: uid)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        final name = data['salonName'] as String?;
        if (name != null && name.trim().isNotEmpty) {
          return name.trim();
        }
      }
      return 'Dois Salon';
    } catch (_) {
      return 'Dois Salon';
    }
  }

  /// Save a new service to Firestore
  Future<void> addService(ServiceModel service) async {
    final uid = FireBaseInitial.auth.currentUser?.uid;
    String salonId = await getOwnerSalonId() ?? '';
    String salonName = await getOwnerSalonName();

    // If salon doesn't exist yet, generate a fallback salon doc
    if (salonId.isEmpty) {
      if (uid != null) {
        final newSalonDoc = FireBaseInitial.firestore.collection('salons').doc();
        salonId = newSalonDoc.id;
        await newSalonDoc.set({
          'salonId': salonId,
          'ownerId': uid,
          'salonName': salonName,
          'rating': 5.0,
          'isOpen': true,
          'categories': [service.category],
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        salonId = 'default_salon';
      }
    }

    final serviceDocId = service.id.isNotEmpty
        ? service.id
        : FireBaseInitial.firestore.collection('services').doc().id;

    final serviceToSave = ServiceModel(
      id: serviceDocId,
      name: service.name,
      description: service.description,
      price: service.price,
      durationMinutes: service.durationMinutes,
      category: service.category,
      isHomeServiceAvailable: service.isHomeServiceAvailable,
      discount: service.discount,
    );

    final serviceData = serviceToSave.toJson();
    serviceData['salonId'] = salonId;
    serviceData['salonName'] = salonName;
    serviceData['ownerId'] = uid ?? '';
    serviceData['createdAt'] = FieldValue.serverTimestamp();

    // 1. Save in top-level 'services' collection
    await FireBaseInitial.firestore
        .collection('services')
        .doc(serviceDocId)
        .set(serviceData);

    // 2. Save in subcollection under the salon
    if (salonId.isNotEmpty) {
      await FireBaseInitial.firestore
          .collection('salons')
          .doc(salonId)
          .collection('services')
          .doc(serviceDocId)
          .set(serviceToSave.toJson());

      // 3. Update salon categories array so client filtering picks up the salon
      if (service.category.isNotEmpty) {
        final categoriesList = service.category
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        await FireBaseInitial.firestore
            .collection('salons')
            .doc(salonId)
            .update({
          'categories': FieldValue.arrayUnion(categoriesList),
        }).catchError((_) {});
      }
    }
  }

  /// Stream of services for a given salon
  Stream<List<ServiceModel>> getSalonServicesStream(String salonId) {
    return FireBaseInitial.firestore
        .collection('salons')
        .doc(salonId)
        .collection('services')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ServiceModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Stream of services for the currently logged-in owner
  Stream<List<ServiceModel>> getOwnerServicesStream() {
    final uid = FireBaseInitial.auth.currentUser?.uid;
    if (uid == null) {
      return Stream.value([]);
    }
    return FireBaseInitial.firestore
        .collection('services')
        .where('ownerId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ServiceModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Delete a service by its ID
  Future<void> deleteService(String serviceId) async {
    try {
      final salonId = await getOwnerSalonId();
      await FireBaseInitial.firestore
          .collection('services')
          .doc(serviceId)
          .delete();
      if (salonId != null && salonId.isNotEmpty) {
        await FireBaseInitial.firestore
            .collection('salons')
            .doc(salonId)
            .collection('services')
            .doc(serviceId)
            .delete();
      }
    } catch (_) {}
  }
}
