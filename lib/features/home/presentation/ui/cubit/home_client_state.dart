part of 'home_client_cubit.dart';

@immutable
sealed class HomeClientState {}

final class HomeClientInitial extends HomeClientState {}

class HomeLoadingState extends HomeClientState {}

class HomeLoadedState extends HomeClientState {
  final List<SalonModel> salons;
  HomeLoadedState({required this.salons});
}

class HomeErrorState extends HomeClientState {
  final String message;
  HomeErrorState({required this.message});
}
