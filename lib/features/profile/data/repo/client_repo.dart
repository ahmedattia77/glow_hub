import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/features/profile/data/model/user_model.dart';

class UserRepo {
  Future<UserModel> getUserData(String uid) async {
    DocumentSnapshot doc = await FireBaseInitial.firestore
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      throw Exception('User data not found');
    }
  }

  Future<void> updateUserData({
    required String uid,
    String? fullName,
    String? phone,
    String? dateOfBirth,
    File? profileImageFile,
  }) async {
    try {
      Map<String, dynamic> dataToUpdate = {};

      if (fullName != null && fullName.trim().isNotEmpty) {
        dataToUpdate['fullName'] = fullName.trim();
      }
      if (phone != null && phone.trim().isNotEmpty) {
        dataToUpdate['phone'] = phone.trim();
      }
      if (dateOfBirth != null && dateOfBirth.trim().isNotEmpty) {
        dataToUpdate['dateOfBirth'] = dateOfBirth.trim();
      }

      if (profileImageFile != null) {
        final ref = FireBaseInitial.storage
            .ref()
            .child('users_avatars')
            .child('$uid.jpg');

        await ref.putFile(profileImageFile);
        String imageUrl = await ref.getDownloadURL();
        dataToUpdate['profileImage'] = imageUrl;
      }

      if (dataToUpdate.isNotEmpty) {
        await FireBaseInitial.firestore
            .collection('users')
            .doc(uid)
            .update(dataToUpdate);
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
