import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:glow_hub/features/salon_details/data/model/salon_details_model.dart';
import 'package:glow_hub/features/salon_details/data/repo/salon_details_repo.dart';

part 'salon_details_state.dart';

class SalonDetailsCubit extends Cubit<SalonDetailsState> {
  final SalonDetailsRepo _repo;

  SalonDetailsCubit(this._repo) : super(SalonDetailsInitial());

  Future<void> fetchSalonDetails(String salonId) async {
    emit(SalonDetailsLoading());
    try {
      final details = await _repo.getSalonDetails(salonId);
      print("salonDetails" + details.name);
      emit(SalonDetailsLoaded(salonDetails: details));
    } catch (e) {
      emit(SalonDetailsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void toggleServiceSelection(int index) {
    if (state is SalonDetailsLoaded) {
      final currentState = state as SalonDetailsLoaded;
      final list = List<int>.from(currentState.selectedServiceIndices);
      if (list.contains(index)) {
        list.remove(index);
      } else {
        list.add(index);
      }
      emit(currentState.copyWith(selectedServiceIndices: list));
    }
  }

  void selectDay(int index) {
    if (state is SalonDetailsLoaded) {
      final currentState = state as SalonDetailsLoaded;
      emit(currentState.copyWith(selectedDayIndex: index));
    }
  }

  void selectTimeSlot(String slot) {
    if (state is SalonDetailsLoaded) {
      final currentState = state as SalonDetailsLoaded;
      emit(currentState.copyWith(selectedTimeSlot: slot));
    }
  }

  void toggleServiceType(bool isHome) {
    if (state is SalonDetailsLoaded) {
      final currentState = state as SalonDetailsLoaded;
      emit(currentState.copyWith(isHomeService: isHome));
    }
  }
}
