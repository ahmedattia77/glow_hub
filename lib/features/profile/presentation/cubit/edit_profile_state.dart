part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

final class EditProfileLoaded extends EditProfileState {
  final UserModel user;
  EditProfileLoaded(this.user);
}

class EditProfileSuccess extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message);
}
