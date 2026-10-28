import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/home/data/model/salone_model.dart';

class SalonRepo {
  Future<List<SalonModel>> getSalons({
    String? searchQuery,
    String? selectedCategory,
  }) async {
    try {
      Query<Map<String, dynamic>> query = FireBaseInitial.firestore.collection(
        'salons',
      );

      if (selectedCategory != null && selectedCategory.isNotEmpty) {
        query = query.where('categories', arrayContains: selectedCategory);
      }

      final snapshot = await query.get();

      List<SalonModel> salons = snapshot.docs
          .map((doc) => SalonModel.fromJson(doc.data()))
          .toList();

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final queryText = searchQuery.trim().toLowerCase();
        salons = salons.where((salon) {
          return salon.name.toLowerCase().contains(queryText) ||
              salon.address.toLowerCase().contains(queryText);
        }).toList();
      }

      return salons;
    } catch (e) {
      return [];
    }
  }
}
