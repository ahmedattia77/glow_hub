import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'package:glow_hub/features/home/data/repo/services_repo.dart';

part 'admin_services_state.dart';

class AdminServicesCubit extends Cubit<AdminServicesState> {
  final ServicesRepo _servicesRepo;
  StreamSubscription<List<ServiceModel>>? _servicesSubscription;
  String _currentSalonName = 'Dois Salon';
  String _selectedCategory = 'All';

  AdminServicesCubit(this._servicesRepo) : super(const AdminServicesInitial());

  Future<void> getSalonName() async {
    try {
      final name = await _servicesRepo.getOwnerSalonName();
      _currentSalonName = name;
      if (state is AdminServicesLoaded) {
        final current = state as AdminServicesLoaded;
        emit(current.copyWith(salonName: name));
      }
    } catch (_) {}
  }

  void getServices() {
    emit(const AdminServicesLoading());
    _servicesSubscription?.cancel();
    _servicesSubscription = _servicesRepo.getOwnerServicesStream().listen(
      (services) {
        final filtered = _filterServices(services, _selectedCategory);
        emit(AdminServicesLoaded(
          allServices: services,
          filteredServices: filtered,
          selectedCategory: _selectedCategory,
          salonName: _currentSalonName,
        ));
      },
      onError: (error) {
        emit(AdminServicesError(error.toString()));
      },
    );
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    if (state is AdminServicesLoaded) {
      final current = state as AdminServicesLoaded;
      final filtered = _filterServices(current.allServices, category);
      emit(current.copyWith(
        filteredServices: filtered,
        selectedCategory: category,
      ));
    }
  }

  List<ServiceModel> _filterServices(
    List<ServiceModel> services,
    String category,
  ) {
    if (category == 'All') return services;
    return services
        .where((s) => s.category.toLowerCase().contains(category.toLowerCase()))
        .toList();
  }

  Future<void> deleteService(String serviceId) async {
    try {
      await _servicesRepo.deleteService(serviceId);
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}

