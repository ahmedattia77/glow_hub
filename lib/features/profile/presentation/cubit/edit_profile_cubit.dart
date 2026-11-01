import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_hub/features/profile/data/model/user_model.dart';
import 'package:glow_hub/features/profile/data/repo/client_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserRepo _userRepo;

  EditProfileCubit(this._userRepo) : super(EditProfileInitial());

  Future<void> loadUserData(String uid) async {
    emit(EditProfileLoading());
    try {
      UserModel user = await _userRepo.getUserData(uid);
      emit(EditProfileLoaded(user));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> saveProfileChanges({
    required String uid,
    String? fullName,
    String? phone,
    String? dateOfBirth,
    File? imageFile,
  }) async {
    emit(EditProfileLoading());
    try {
      await _userRepo.updateUserData(
        uid: uid,
        fullName: fullName,
        phone: phone,
        dateOfBirth: dateOfBirth,
        profileImageFile: imageFile,
      );

      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}
