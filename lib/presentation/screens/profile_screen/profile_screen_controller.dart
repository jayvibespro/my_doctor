import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/data_service.dart';

import '../auth_screens/auth_state.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@injectable
class ProfileScreenController {
  late void Function(void Function()) setState;
  late BuildContext context;
  final AuthState state;
  late DataService dataService;

  ProfileScreenController(this.state);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    this.setState = setState;
    this.context = context;
    dataService = DataService();
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
