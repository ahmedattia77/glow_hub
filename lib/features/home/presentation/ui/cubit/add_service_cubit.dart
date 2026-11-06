import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'package:glow_hub/features/home/data/repo/services_repo.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  final ServicesRepo _servicesRepo;

  AddServiceCubit(this._servicesRepo) : super(const AddServiceInitial());

  Future<void> loadSalonName() async {
    try {
      final name = await _servicesRepo.getOwnerSalonName();
      emit(AddServiceInitial(salonName: name));
    } catch (_) {}
  }

  Future<void> addService(ServiceModel service) async {
    emit(AddServiceLoading(salonName: state.salonName));
    try {
      await _servicesRepo.addService(service);
      emit(AddServiceSuccess(salonName: state.salonName));
    } catch (e) {
      emit(AddServiceFailure(
        errorMessage: e.toString(),
        salonName: state.salonName,
      ));
    }
  }
}

