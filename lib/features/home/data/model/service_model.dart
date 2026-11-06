class ServiceModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;
  final String category;
  final bool isHomeServiceAvailable;
  final double? discount;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.category,
    this.isHomeServiceAvailable = false,
    this.discount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'durationMinutes': durationMinutes,
      'category': category,
      'isHomeServiceAvailable': isHomeServiceAvailable,
      'discount': discount,
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      durationMinutes: json['durationMinutes'] ?? 0,
      category: json['category'] ?? '',
      isHomeServiceAvailable: json['isHomeServiceAvailable'] ?? false,
      discount: json['discount'] != null
          ? (json['discount'] as num).toDouble()
          : null,
    );
  }
}
