class SalonModel {
  final String salonId;
  final String name;
  final String ownerId;
  final String category;
  final List<String> categories;
  final double rating;
  final String imageUrl;

  SalonModel({
    required this.salonId,
    required this.name,
    required this.ownerId,
    required this.category,
    required this.categories,
    required this.rating,
    this.imageUrl = '',
  });

  Map<String, dynamic> toJson() => {
    'salonId': salonId,
    'salonName': name,
    'name': name,
    'ownerId': ownerId,
    'category': category,
    'categories': categories,
    'rating': rating,
    'imageUrl': imageUrl,
  };

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    List<String> parseCategories(
      dynamic categoriesData,
      String singleCategory,
    ) {
      if (categoriesData is List) {
        return List<String>.from(categoriesData.map((e) => e.toString()));
      } else if (categoriesData is String && categoriesData.isNotEmpty) {
        return categoriesData
            .replaceAll('"', '')
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      } else if (singleCategory.isNotEmpty) {
        return [singleCategory];
      }
      return [];
    }

    final String singleCat = json['category'] ?? '';
    final dynamic rawCategories = json['categories'] ?? json['category'];
    final parsedCategories = parseCategories(rawCategories, singleCat);

    return SalonModel(
      salonId: json['salonId'] ?? '',
      name: json['salonName'] ?? json['name'] ?? '',
      ownerId: json['ownerId'] ?? '',
      category: singleCat.isNotEmpty
          ? singleCat
          : (parsedCategories.isNotEmpty ? parsedCategories.first : ''),
      categories: parsedCategories,
      rating: (json['rating'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
