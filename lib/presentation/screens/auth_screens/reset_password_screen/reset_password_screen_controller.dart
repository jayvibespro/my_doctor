import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/data_service.dart';

import '../auth_state.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@injectable
class ResetPasswordScreenController {
  late void Function(void Function()) setState;
  late BuildContext context;
  final AuthState state;
  late DataService dataService;

  ResetPasswordScreenController(this.state);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    this.setState = setState;
    this.context = context;
    dataService = DataService();
  }

  Future<void> resetPassword(String email) async {
    /*loadingDialog(context);
    await dataService.resetPassword(email);
    Get.back();*/
  }
}
