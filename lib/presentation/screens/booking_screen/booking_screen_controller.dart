import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_doctor/core/models/time_slot_model.dart';
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
  late DataService dataService;

  BookingScreenController(this.state);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    dataService = DataService();
    _initializeTimeSlots();
  }

  Future<void> signIn() async {
    /* loadingDialog(context);
    UserModel? newUser = await dataService.signIn(state.user!);
    Get.back();
    if (newUser != null) {
      state.user = newUser;
      Get.off(
            () => const HomePage(),
      );
    }*/
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

  void _update() {
    if (!_context.mounted) return;
    _setState(() {});
  }
}
