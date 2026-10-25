class SalonModel {
  final String salonId;
  final String name;
  final String address;
  final double rating;
  final String imageUrl;
  final List<String> categories;

  SalonModel({
    required this.salonId,
    required this.name,
    required this.address,
    required this.rating,
    required this.imageUrl,
    required this.categories,
  });

  Map<String, dynamic> toJson() => {
    'salonId': salonId,
    'name': name,
    'address': address,
    'rating': rating,
    'imageUrl': imageUrl,
    'categories': categories,
  };

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    List<String> parseCategories(dynamic categoriesData) {
      if (categoriesData is List) {
        return List<String>.from(categoriesData.map((e) => e.toString()));
      } else if (categoriesData is String) {
        if (categoriesData.isEmpty) return [];
        return categoriesData
            .replaceAll('"', '')
            .split(',')
            .map((e) => e.trim())
            .toList();
      }
      return [];
    }

    return SalonModel(
      salonId: json['salonId'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      categories: parseCategories(json['categories']),
    );
  }
}
