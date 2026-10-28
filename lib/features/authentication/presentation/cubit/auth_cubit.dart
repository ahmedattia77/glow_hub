import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await FireBaseInitial.auth
          .signInWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc = await FireBaseInitial.firestore
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        String role = userDoc.get('role') ?? 'customer';
        emit(AuthSuccess(role: role));
      } else {
        emit(AuthFailure(errorMessage: "User data not found in database"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(errorMessage: _handleFirebaseAuthError(e.code)));
    } catch (e) {
      emit(AuthFailure(errorMessage: "An unexpected error occurred."));
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String role,
    String? salonName,
    String? salonCategory,
  }) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await FireBaseInitial.auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      String uid = userCredential.user!.uid;

      Map<String, dynamic> userData = {
        'uid': uid,
        'firstName': firstName.trim(),
        'lastName': lastName.trim(),
        'email': email.trim(),
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FireBaseInitial.firestore
          .collection('users')
          .doc(uid)
          .set(userData);

      if (role == 'admin') {
        String salonId = FireBaseInitial.firestore
            .collection('salons')
            .doc()
            .id;

        // defualt values until admin have change it later .
        Map<String, dynamic> salonData = {
          'salonId': salonId,
          'ownerId': uid,
          'salonName': salonName?.trim() ?? 'My Salon',
          'category': salonCategory?.trim() ?? 'Beauty & Care',
          'rating': 0.0,
          'isOpen': true,
          'workingHours': {
            "saturday": {
              "isOpen": true,
              "openTime": "10:00 AM",
              "closeTime": "10:00 PM",
            },
            "sunday": {
              "isOpen": true,
              "openTime": "10:00 AM",
              "closeTime": "10:00 PM",
            },
            "monday": {
              "isOpen": true,
              "openTime": "10:00 AM",
              "closeTime": "10:00 PM",
            },
            "tuesday": {
              "isOpen": true,
              "openTime": "10:00 AM",
              "closeTime": "10:00 PM",
            },
            "wednesday": {
              "isOpen": true,
              "openTime": "10:00 AM",
              "closeTime": "10:00 PM",
            },
            "thursday": {
              "isOpen": true,
              "openTime": "10:00 AM",
              "closeTime": "11:00 PM",
            },
            "friday": {"isOpen": false, "openTime": "", "closeTime": ""},
          },
          'createdAt': FieldValue.serverTimestamp(),
        };

        await FireBaseInitial.firestore
            .collection('salons')
            .doc(salonId)
            .set(salonData);
      }

      emit(AuthSuccess(role: role));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(errorMessage: _handleFirebaseAuthError(e.code)));
    } catch (e) {
      emit(AuthFailure(errorMessage: "An unexpected error occurred."));
    }
  }

  String _handleFirebaseAuthError(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email address is already in use.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'Authentication failed. Please check your network and credentials.';
    }
  }
}
