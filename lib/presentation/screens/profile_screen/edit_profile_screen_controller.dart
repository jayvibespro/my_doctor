import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/data_service.dart';
import '../../../core/models/api_response_model.dart';
import '../../../core/models/user_model/user_model.dart';
import '../../../core/state/app_state.dart';
import '../../../core/utils/session_manager.dart';
import '../../components/loading_dialog.dart';
import '../../components/top_snack_bar.dart';
import '../auth_screens/auth_state.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@injectable
class EditProfileScreenController {
  late void Function(void Function()) _setState;
  late BuildContext _context;
  final AuthState state;
  final AppState appState;
  late DataService _dataService;
  late SessionManager _sessionManager;

  EditProfileScreenController(this.state, this.appState);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    _dataService = DataService();
    _sessionManager = SessionManager();
  }

  Future<void> editProfile() async {
    loadingDialog(_context);
    ApiResponseModel<UserModel?> response =
        await _dataService.updateUser(appState.userModel!);
    Get.back();
    if (response.success) {
      await _sessionManager.setUserData(response.data!);
      appState.userModel = response.data!;
      Get.back<bool>(result: true);
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
