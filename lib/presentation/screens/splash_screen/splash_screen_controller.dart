import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/user_model/user_model.dart';
import '../../../core/services/data_service.dart';
import '../../../core/state/app_state.dart';
import '../../../core/utils/session_manager.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@injectable
class SplashScreenController {
  late void Function(void Function()) _setState;
  late BuildContext _context;

  final AppState appState;
  late final DataService _dataService;
  late final SessionManager _sessionManager;

  SplashScreenController(this.appState);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    _dataService = DataService();
    _sessionManager = SessionManager();
    getInitialData();
  }

  Future<void> getUserData() async {
    UserModel? userModel = await _sessionManager.getUserData();
    if (userModel != null) {
      appState.userModel = userModel;
    }
  }

  Future<void> getInitialData() async {
    final futures = [
      getUserData(),
    ];
    await Future.wait(futures);
  }
}
