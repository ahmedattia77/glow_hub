import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'package:glow_hub/features/salon_details/data/model/salon_details_model.dart';
import 'package:glow_hub/features/salon_details/data/repo/booking_repo.dart';
import 'package:glow_hub/features/salon_details/data/repo/salon_details_repo.dart';

part 'salon_details_state.dart';

class SalonDetailsCubit extends Cubit<SalonDetailsState> {
  final SalonDetailsRepo _repo;

  SalonDetailsCubit(this._repo) : super(SalonDetailsInitial());

  Future<void> fetchSalonDetails(String salonId) async {
    emit(SalonDetailsLoading());
    try {
      final details = await _repo.getSalonDetails(salonId);
      emit(SalonDetailsLoaded(salonDetails: details));
    } catch (e) {
      emit(SalonDetailsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // void toggleServiceSelection(int index) {
  //   if (state is SalonDetailsLoaded) {
  //     final currentState = state as SalonDetailsLoaded;
  //     final list = List<int>.from(currentState.selectedServiceIndices);
  //     if (list.contains(index)) {
  //       list.remove(index);
  //     } else {
  //       list.add(index);
  //     }
  //     emit(currentState.copyWith(selectedServiceIndices: list));
  //   }
  // }

  void toggleServiceSelection(int index) {
    if (state is SalonDetailsLoaded) {
      final currentState = state as SalonDetailsLoaded;
      final selectedList = List<int>.from(currentState.selectedServiceIndices);
      final homeList = List<int>.from(currentState.homeServiceIndices);

      if (selectedList.contains(index)) {
        selectedList.remove(index);
        homeList.remove(index);
      } else {
        selectedList.add(index);
      }
      emit(
        currentState.copyWith(
          selectedServiceIndices: selectedList,
          homeServiceIndices: homeList,
        ),
      );
    }
  }

  void toggleServiceHome(int index, bool isHome) {
    if (state is SalonDetailsLoaded) {
      final currentState = state as SalonDetailsLoaded;
      final homeList = List<int>.from(currentState.homeServiceIndices);

      final service = currentState.salonDetails.services[index];

      if (isHome && !service.isHomeServiceAvailable) {
        emit(
          SalonDetailsError(
            'Service "${service.name}" is not available for home service!',
          ),
        );
        return;
      }

      if (isHome) {
        if (!homeList.contains(index)) homeList.add(index);
      } else {
        homeList.remove(index);
      }

      emit(currentState.copyWith(homeServiceIndices: homeList));
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

  Future<void> confirmBooking({
    required String salonId,
    required BookingRepo bookingRepo,
  }) async {
    if (state is SalonDetailsLoaded) {
      final currentState = state as SalonDetailsLoaded;

      if (currentState.selectedServiceIndices.isEmpty) {
        emit(SalonDetailsError('Please select at least one service'));
        return;
      }

      if (currentState.selectedTimeSlot == null) {
        emit(SalonDetailsError('Please select a time slot!'));
        return;
      }

      for (var index in currentState.homeServiceIndices) {
        final service = currentState.salonDetails.services[index];
        if (!service.isHomeServiceAvailable) {
          emit(
            SalonDetailsError(
              'Service "${service.name}" is not available for home service!',
            ),
          );
          return;
        }
      }

      // final selectedServices = currentState.selectedServiceIndices
      //     .map((index) => currentState.salonDetails.services[index])
      //     .toList();

      final List<ServiceModel> selectedServices = currentState
          .selectedServiceIndices
          .map(
            (index) =>
                currentState.salonDetails.services[index] as ServiceModel,
          )
          .toList();

      double totalPrice = 0.0;
      for (var index in currentState.selectedServiceIndices) {
        final service = currentState.salonDetails.services[index];
        final double originalPrice = service.price;
        final double? discount = service.discount;

        final double finalPrice = (discount != null && discount > 0)
            ? (originalPrice - discount)
            : originalPrice;

        totalPrice += finalPrice;
      }

      emit(SalonDetailsLoading());
      try {
        await bookingRepo.createBooking(
          salonId: salonId,
          selectedServices: selectedServices,
          homeServiceIndices: currentState.homeServiceIndices,
          totalPrice: totalPrice,
          selectedDay: currentState.selectedDayIndex.toString(),
          timeSlot: currentState.selectedTimeSlot!,
        );

        emit(
          SalonDetailsLoaded(
            salonDetails: currentState.salonDetails,
            selectedServiceIndices: currentState.selectedServiceIndices,
            homeServiceIndices: currentState.homeServiceIndices,
            selectedDayIndex: currentState.selectedDayIndex,
            selectedTimeSlot: currentState.selectedTimeSlot,
          ),
        );
      } catch (e) {
        emit(SalonDetailsError(e.toString().replaceAll('Exception: ', '')));
      }
    }
  }
}
