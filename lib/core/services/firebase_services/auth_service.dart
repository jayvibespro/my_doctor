import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_doctor/core/models/api_response_model.dart';

import '../../models/user_model/user_model.dart';
import '../../utils/constants/firebase_collections.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<ApiResponseModel<UserModel?>> signUp(UserModel userModel) async {
    UserModel? newUser;
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: userModel.email ?? "",
        password: userModel.password ?? "",
      )
          .then((value) async {
        if (value.user != null) {
          userModel.userId = value.user!.uid;
          userModel.isActive = true;
          userModel.imageUrl = value.user?.photoURL ?? "";

          await _db.collection(fcUsers).add(userModel.toMap()).then((value) {
            newUser = UserModel(
              id: value.id,
              userId: _auth.currentUser!.uid,
              accountType: userModel.accountType,
              name: userModel.name,
              createdAt: userModel.createdAt,
              phone: userModel.phone,
              email: _auth.currentUser?.email,
              imageUrl: userModel.imageUrl,
              isActive: true,
              speciality: userModel.speciality,
            );
          });
        }
      });

      return ApiResponseModel(
        data: newUser,
        statusCode: 201,
        message: "User Sign up successfully",
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("ERROR: ${e.message}");
      }

      return ApiResponseModel(
        data: null,
        statusCode: 500,
        message: e.message ?? "An unknown error occurred.",
      );
    }
  }

  Future<ApiResponseModel<UserModel?>> signIn(UserModel userModel) async {
    UserModel? newUser;
    try {
      await _auth.signInWithEmailAndPassword(
        email: userModel.email ?? "",
        password: userModel.password ?? "",
      );
      User? user = _auth.currentUser;
      if (user == null) {
        return ApiResponseModel(
          data: null,
          statusCode: 500,
          message: "Sign in failed",
        );
      }

      await _db
          .collection(fcUsers)
          .where("user_id", isEqualTo: user.uid)
          .limit(1)
          .get()
          .then((value) {
        final doc = value.docs.first;
        newUser = UserModel.fromDocumentSnapshot(doc: doc);
      });

      return ApiResponseModel(
        data: newUser,
        statusCode: 200,
        message: "User Sign in successfully",
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("EXCEPTION: ${e.message}");
      }

      return ApiResponseModel(
        data: null,
        statusCode: 500,
        message: e.message ?? "An unknown error occurred.",
      );
    }
  }

  Future<ApiResponseModel<UserModel?>> updateUser(UserModel userModel) async {
    UserModel? newUser;
    try {
      if (_auth.currentUser != null) {
        await _db
            .collection(fcUsers)
            .doc(userModel.id)
            .update(userModel.toMapForUpdate())
            .then((value) {
          newUser = UserModel(
            id: userModel.id,
            userId: _auth.currentUser!.uid,
            speciality: userModel.speciality,
            phone: userModel.phone,
            email: userModel.email,
            name: userModel.name,
            accountType: userModel.accountType,
            imageUrl: userModel.imageUrl,
            isActive: userModel.isActive,
            createdAt: userModel.createdAt,
          );
        });
      }
      return ApiResponseModel(
        data: newUser,
        statusCode: 200,
        message: "User updated successfully",
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("EXCEPTION: ${e.message}");
      }

      return ApiResponseModel(
        data: null,
        statusCode: 500,
        message: e.message ?? "An unknown error occurred.",
      );
    }
  }

  Future<ApiResponseModel<bool>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ApiResponseModel(
        data: true,
        statusCode: 500,
        message: "Password reset email has been sent to $email",
      );
    } catch (e) {
      if (kDebugMode) {
        print("EXCEPTION: ${e.toString()}");
      }
      return ApiResponseModel(
        data: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponseModel<bool>> signOut() async {
    try {
      await _auth.signOut();
      return ApiResponseModel(
        data: true,
        statusCode: 200,
        message: "User Sign out successfully",
      );
    } on FirebaseAuthException catch (e) {
      return ApiResponseModel(
        data: null,
        statusCode: 500,
        message: e.message ?? "An unknown error occurred.",
      );
    }
  }

  Future<bool> checkIsUserSignedIn() async {
    if (_auth.currentUser == null) {
      return false;
    }
    return true;
  }
}
