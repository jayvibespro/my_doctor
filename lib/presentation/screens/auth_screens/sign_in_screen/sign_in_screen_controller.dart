import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/api_response_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/data_service.dart';

import '../../../../core/state/app_state.dart';
import '../../../../core/utils/session_manager.dart';
import '../../../components/loading_dialog.dart';
import '../../../components/top_snack_bar.dart';
import '../../home_screen/home_screen.dart';
import '../auth_state.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@injectable
class SignInScreenController {
  late void Function(void Function()) _setState;
  late BuildContext _context;
  final AuthState state;
  final AppState appState;
  late DataService _dataService;
  late SessionManager _sessionManager;

  SignInScreenController(this.state, this.appState);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    _dataService = DataService();
    _sessionManager = SessionManager();
  }

  Future<void> signIn() async {
    loadingDialog(_context);
    ApiResponseModel<UserModel?> response =
        await _dataService.signIn(state.user!);
    Get.back();
    if (response.success) {
      await _sessionManager.setUserData(response.data!);
      appState.userModel = response.data!;
      Get.to(
        () => const HomeScreen(),
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

  /*
  Future<void> editProfile() async {
    loadingDialog(context);
    UserModel? newUser = await dataService.updateUser(state.user!);
    Get.back();
    if (newUser != null) {
      state.user = newUser;
      Get.back<bool>(result: true);
    }
  }



  Future<void> getUser() async {
    // if (state.user == null) {
    //   state.user = await dataService.getUser();
    //   setState(() {});
    // }
  }


  Future<void> signOut() async {
    loadingDialog(context);
    await dataService.signOut();
    Get.back();
    Get.offAll(
      () => const SplashPage(),
    );
  }

  Future<bool> checkIsUserSignedIn() async {
    return dataService.checkIsUserSignedIn();
  }*/
}
