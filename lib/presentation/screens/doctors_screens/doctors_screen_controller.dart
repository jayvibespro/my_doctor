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
class DoctorsScreenController {
  late void Function(void Function()) _setState;
  late BuildContext _context;
  final AuthState state;
  final AppState appState;
  late DataService _dataService;
  late SessionManager _sessionManager;

  DoctorsScreenController(this.state, this.appState);

  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _setState = setState;
    _context = context;
    _dataService = DataService();
    _sessionManager = SessionManager();
  }

  void _update() {
    if (!_context.mounted) return;
    _setState(() {});
  }
}
