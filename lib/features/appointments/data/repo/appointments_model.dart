import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';

class AppointmentsModel {
  final String bookingId;
  final String userId;
  final String salonId;
  final List<ServiceModel> services;
  final List<int> homeServiceIndices;
  final double totalPrice;
  final String selectedDay;
  final String timeSlot;
  final bool isHomeService;
  final String status;
  final Timestamp? createdAt;

  AppointmentsModel({
    required this.bookingId,
    required this.userId,
    required this.salonId,
    required this.services,
    required this.homeServiceIndices,
    required this.totalPrice,
    required this.selectedDay,
    required this.timeSlot,
    required this.isHomeService,
    required this.status,
    this.createdAt,
  });

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
      bookingId: json['bookingId'] ?? '',
      userId: json['userId'] ?? '',
      salonId: json['salonId'] ?? '',
      services:
          (json['services'] as List<dynamic>?)
              ?.map((e) => ServiceModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      homeServiceIndices:
          (json['homeServiceIndices'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
      selectedDay: json['selectedDay'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      isHomeService: json['isHomeService'] ?? false,
      status: json['status'] ?? 'pending',
      createdAt: json['createdAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'userId': userId,
      'salonId': salonId,
      'services': services.map((e) => e.toJson()).toList(),
      'homeServiceIndices': homeServiceIndices,
      'totalPrice': totalPrice,
      'selectedDay': selectedDay,
      'timeSlot': timeSlot,
      'isHomeService': isHomeService,
      'status': status,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
