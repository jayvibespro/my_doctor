import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:my_doctor/core/models/api_response_model.dart';
import 'package:my_doctor/core/models/booking_model.dart';
import 'package:my_doctor/core/models/time_slot_model.dart';
import 'package:my_doctor/core/state/app_state.dart';
import 'package:my_doctor/presentation/components/loading_dialog.dart';
import 'package:my_doctor/presentation/components/top_snack_bar.dart';
import 'package:my_doctor/presentation/screens/booking_screen/booking_state.dart';

import '../../../../core/services/data_service.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

@injectable
class BookingScreenController {
  late void Function(void Function()) _setState;
  late BuildContext _context;
  final BookingState state;
  final AppState appState;
  late DataService _dataService;

  BookingScreenController(this.state, this.appState);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    _dataService = DataService();
    _initializeTimeSlots();
  }

  void _initializeTimeSlots() {
    final times = [
      '07:00 am',
      '08:00 am',
      '09:00 am',
      '10:00 am',
      '11:00 am',
      '12:00 pm',
      '01:00 pm',
      '08:00 pm',
      '09:00 pm',
      '10:00 pm',
      '11:00 pm',
    ];

    state.timeSlots
      ..clear()
      ..addAll(times.map((time) => TimeSlotModel(time: time, isTaken: false)));
    _update();
  }

  Future<void> getBookingsByDateAndDoctor(String date) async {
    await Future.delayed(const Duration(milliseconds: 600));
    state.loading = true;
    _update();

    ApiResponseModel<List<BookingModel>?> response = await _dataService
        .getBookingsByDateAndDoctor(appState.selectedDoctor.userId ?? "", date);
    if (response.success) {
      final Set<String?> bookedTimes =
          response.data!.map((booking) => booking.time).toSet();

      for (var slot in state.timeSlots) {
        slot.isTaken = bookedTimes.contains(slot.time);
      }
    }
    state.loading = false;
    _update();
  }

  Future<void> createBooking(
    String date,
    String time,
    String description,
  ) async {
    loadingDialog(_context);

    BookingModel booking = BookingModel(
      patientId: appState.userModel?.userId,
      patientName: appState.userModel?.name,
      patientPhone: appState.userModel?.phone,
      doctorId: appState.selectedDoctor.userId,
      doctorName: appState.selectedDoctor.name,
      doctorPhone: appState.selectedDoctor.phone,
      date: date,
      time: time,
      createdAt: DateTime.now().toString(),
      description: description,
      status: 'PENDING',
    );
    ApiResponseModel<bool> response = await _dataService.createBooking(booking);
    Get.back();
    if (response.data == true) {
      if (!_context.mounted) return;
      topSnackBar(
        context: _context,
        message: response.message,
        snackBarType: SnackBarType.success,
      );
      Get.back<bool>(result: true);
    } else {
      if (!_context.mounted) return;
      topSnackBar(
        context: _context,
        message: response.message,
        snackBarType: SnackBarType.error,
      );
    }
  }

  void _update() {
    if (!_context.mounted) return;
    _setState(() {});
  }
}
