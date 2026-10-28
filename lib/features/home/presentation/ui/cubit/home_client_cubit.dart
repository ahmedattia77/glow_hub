import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_hub/features/home/data/model/salone_model.dart';
import 'package:glow_hub/features/home/data/repo/salon_repo.dart';

part 'home_client_state.dart';

class HomeClientCubit extends Cubit<HomeClientState> {
  final SalonRepo _salonRepo;

  HomeClientCubit(this._salonRepo) : super(HomeClientInitial());

  void fetchSalons({String? searchQuery, String? selectedCategory}) async {
    emit(HomeLoadingState());
    try {
      final salons = await _salonRepo.getSalons();
      emit(HomeLoadedState(salons: salons));
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }
}
