import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/api_response_model.dart';
import '../../../../core/services/data_service.dart';

import '../../../components/loading_dialog.dart';
import '../../../components/top_snack_bar.dart';
import '../auth_state.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@injectable
class ResetPasswordScreenController {
  late void Function(void Function()) _setState;
  late BuildContext _context;
  final AuthState state;
  late DataService _dataService;

  ResetPasswordScreenController(this.state);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    _dataService = DataService();
  }

  Future<void> resetPassword(String email) async {
    loadingDialog(_context);
    ApiResponseModel<bool> response = await _dataService.resetPassword(email);
    Get.back();
    if (response.success) {
      if (!_context.mounted) return;
      topSnackBar(
        context: _context,
        message: response.message,
        snackBarType: SnackBarType.success,
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
}
