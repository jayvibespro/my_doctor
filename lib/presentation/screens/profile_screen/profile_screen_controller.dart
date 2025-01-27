import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_doctor/core/state/app_state.dart';

import '../../../../core/services/data_service.dart';

import '../../../core/utils/session_manager.dart';
import '../auth_screens/auth_state.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@injectable
class ProfileScreenController {
  late void Function(void Function()) _setState;
  late BuildContext _context;
  final AuthState state;
  final AppState appState;
  late DataService _dataService;
  late SessionManager _sessionManager;

  ProfileScreenController(this.state, this.appState);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    _dataService = DataService();
    _sessionManager = SessionManager();
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
