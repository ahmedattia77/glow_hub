part of 'admin_services_cubit.dart';

@immutable
sealed class AdminServicesState {
  const AdminServicesState();
}

final class AdminServicesInitial extends AdminServicesState {
  const AdminServicesInitial();
}

final class AdminServicesLoading extends AdminServicesState {
  const AdminServicesLoading();
}

final class AdminServicesLoaded extends AdminServicesState {
  final List<ServiceModel> allServices;
  final List<ServiceModel> filteredServices;
  final String selectedCategory;
  final String salonName;

  const AdminServicesLoaded({
    required this.allServices,
    required this.filteredServices,
    this.selectedCategory = 'All',
    this.salonName = 'Dois Salon',
  });

  AdminServicesLoaded copyWith({
    List<ServiceModel>? allServices,
    List<ServiceModel>? filteredServices,
    String? selectedCategory,
    String? salonName,
  }) {
    return AdminServicesLoaded(
      allServices: allServices ?? this.allServices,
      filteredServices: filteredServices ?? this.filteredServices,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      salonName: salonName ?? this.salonName,
    );
  }
}

final class AdminServicesError extends AdminServicesState {
  final String message;
  const AdminServicesError(this.message);
}

