import 'package:glow_hub/features/home/data/model/service_model.dart';

class SalonDetailsModel {
  final String salonId;
  final String ownerId;
  final String name;
  final String imageUrl;
  final String address;
  final double rating;
  final List<String> categories;
  final Map<String, dynamic> workingHours;
  final List services;

  SalonDetailsModel({
    required this.salonId,
    required this.ownerId,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.rating,
    required this.categories,
    required this.workingHours,
    required this.services,
  });

  factory SalonDetailsModel.fromJson(Map<String, dynamic> json, String id) {
    List<String> parseCategories(dynamic categoriesData) {
      if (categoriesData is List) {
        return List<String>.from(categoriesData.map((e) => e.toString()));
      } else if (categoriesData is String && categoriesData.isNotEmpty) {
        return categoriesData
            .replaceAll('"', '')
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
      return [];
    }

    List<ServiceModel> parseServices(dynamic servicesData) {
      if (servicesData is List) {
        return servicesData
            .map((e) => ServiceModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      return [];
    }

    return SalonDetailsModel(
      salonId: id,
      ownerId: json['ownerId'] ?? '',
      name: json['salonName'] ?? json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      address: json['address'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      categories: parseCategories(json['categories'] ?? json['category']),
      workingHours: json['workingHours'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(json['workingHours'])
          : {},
      services: parseServices(json['services']),
    );
  }
}
