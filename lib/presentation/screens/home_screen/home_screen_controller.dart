import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:my_doctor/presentation/screens/splash_screen/splash_screen.dart';

import '../../../../core/models/api_response_model.dart';
import '../../../core/models/booking_model.dart';
import '../../../core/models/user_model.dart';
import '../../../../core/services/data_service.dart';

import '../../../../core/state/app_state.dart';
import '../../../../core/utils/session_manager.dart';
import '../../components/loading_dialog.dart';
import '../../components/top_snack_bar.dart';
import '../auth_screens/auth_state.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

@injectable
class HomeScreenController {
  late void Function(void Function()) _setState;
  late BuildContext _context;
  final AuthState state;
  final AppState appState;
  late DataService _dataService;
  late SessionManager _sessionManager;

  HomeScreenController(this.state, this.appState);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    _dataService = DataService();
    _sessionManager = SessionManager();
    getUsers();
    getBookings();
  }

  Future<void> getUsers() async {
    if (appState.doctors.isEmpty && appState.patients.isEmpty) {
      state.loading = true;
    }
    _update();

    ApiResponseModel<List<UserModel>?> response = await _dataService.getUsers();

    if (response.success) {
      appState.doctors =
          response.data!.where((user) => user.accountType == "DOCTOR").toList();
      appState.patients = response.data!
          .where((user) => user.accountType == "PATIENT")
          .toList();
    } else {
      if (!_context.mounted) return;
      topSnackBar(
        context: _context,
        message: response.message,
        snackBarType: SnackBarType.error,
      );
    }
    state.loading = false;
    _update();
  }

  Future<void> getBookings() async {
    if (appState.bookings.isEmpty) {
      state.loading = true;
    }
    _update();

    ApiResponseModel<List<BookingModel>?> response =
        await _dataService.getAllBookings();

    if (response.success) {
      if (appState.userModel?.accountType == 'PATIENT') {
        appState.bookings = response.data!
            .where(
              (item) => item.patientId == appState.userModel?.userId,
            )
            .toList();
      } else if (appState.userModel?.accountType == 'DOCTOR') {
        appState.bookings = response.data!
            .where(
              (item) => item.doctorId == appState.userModel?.userId,
            )
            .toList();
      } else {
        appState.bookings = response.data!;
      }
    } else {
      if (!_context.mounted) return;
      topSnackBar(
        context: _context,
        message: response.message,
        snackBarType: SnackBarType.error,
      );
    }
    state.loading = false;
    _update();
  }

  Future<void> signOut() async {
    loadingDialog(_context);
    ApiResponseModel<bool> response = await _dataService.signOut();
    Get.back();
    if (response.data == true) {
      await _sessionManager.clearUserData();
      appState.userModel = null;
      Get.off(
        () => const SplashScreen(),
        transition: Transition.circularReveal,
        curve: Curves.easeInOut,
        duration: const Duration(
          milliseconds: 1200,
        ),
      );
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
