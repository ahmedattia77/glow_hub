part of 'add_service_cubit.dart';

@immutable
sealed class AddServiceState {
  final String salonName;
  const AddServiceState({this.salonName = 'Dois Salon'});
}

final class AddServiceInitial extends AddServiceState {
  const AddServiceInitial({super.salonName});
}

final class AddServiceLoading extends AddServiceState {
  const AddServiceLoading({super.salonName});
}

final class AddServiceSuccess extends AddServiceState {
  const AddServiceSuccess({super.salonName});
}

final class AddServiceFailure extends AddServiceState {
  final String errorMessage;

  const AddServiceFailure({
    required this.errorMessage,
    super.salonName,
  });
}

