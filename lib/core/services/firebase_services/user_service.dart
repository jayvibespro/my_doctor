import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_doctor/core/models/api_response_model.dart';

import '../../models/user_model.dart';
import '../../utils/constants/firebase_collections.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

mixin UserService {
  final _db = FirebaseFirestore.instance;

  Future<ApiResponseModel<List<UserModel>?>> getUsers() async {
    try {
      final querySnapshot = await _db
          .collection(fcUsers)
          .where('account_type', isNotEqualTo: 'ADMIN')
          .get();

      final users = querySnapshot.docs
          .map((doc) => UserModel.fromDocumentSnapshot(doc: doc))
          .toList();

      return ApiResponseModel(
        data: users,
        statusCode: 200,
        message: "Users fetched successfully",
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
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected ERROR: $e");
      }

      return ApiResponseModel(
        data: null,
        statusCode: 500,
        message: "An unknown error occurred.",
      );
    }
  }
}
