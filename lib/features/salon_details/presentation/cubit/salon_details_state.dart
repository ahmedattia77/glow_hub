part of 'salon_details_cubit.dart';

@immutable
sealed class SalonDetailsState {}

final class SalonDetailsInitial extends SalonDetailsState {}

class SalonDetailsLoading extends SalonDetailsState {}

class SalonDetailsLoaded extends SalonDetailsState {
  final SalonDetailsModel salonDetails;
  final List<int> selectedServiceIndices;
  final int selectedDayIndex;
  final String? selectedTimeSlot;
  final bool isHomeService;

  SalonDetailsLoaded({
    required this.salonDetails,
    this.selectedServiceIndices = const [],
    this.selectedDayIndex = 1,
    this.selectedTimeSlot,
    this.isHomeService = false,
  });

  SalonDetailsLoaded copyWith({
    SalonDetailsModel? salonDetails,
    List<int>? selectedServiceIndices,
    int? selectedDayIndex,
    String? selectedTimeSlot,
    bool? isHomeService,
  }) {
    return SalonDetailsLoaded(
      salonDetails: salonDetails ?? this.salonDetails,
      selectedServiceIndices:
          selectedServiceIndices ?? this.selectedServiceIndices,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      isHomeService: isHomeService ?? this.isHomeService,
    );
  }
}

class SalonDetailsError extends SalonDetailsState {
  final String message;
  SalonDetailsError(this.message);
}
