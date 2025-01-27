import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_doctor/core/models/api_response_model.dart';

import '../../models/booking_model.dart';
import '../../utils/constants/firebase_collections.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

mixin BookingService {
  final _db = FirebaseFirestore.instance;

  Future<ApiResponseModel<List<BookingModel>?>> getBookingsByDateAndDoctor(
      String doctorId, String date) async {
    try {
      final querySnapshot = await _db
          .collection(fcBookings)
          .where('doctor_id', isEqualTo: doctorId)
          .where('date', isEqualTo: date)
          .get();

      final bookings = querySnapshot.docs
          .map((doc) => BookingModel.fromDocumentSnapshot(doc: doc))
          .toList();

      return ApiResponseModel(
        data: bookings,
        statusCode: 200,
        message: "Bookings fetched successfully",
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

  Future<ApiResponseModel<bool>> createBooking(BookingModel booking) async {
    try {
      await _db.collection(fcBookings).add(booking.toMap());

      return ApiResponseModel(
        data: true,
        statusCode: 201,
        message: "Booking created successfully",
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("ERROR: ${e.message}");
      }

      return ApiResponseModel(
        data: false,
        statusCode: 500,
        message: e.message ?? "An unknown error occurred.",
      );
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected ERROR: $e");
      }

      return ApiResponseModel(
        data: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }
}
