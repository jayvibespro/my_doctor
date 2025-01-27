import 'package:injectable/injectable.dart';

import '../models/user_model.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 24|01|2025
* */

@singleton
class AppState {
  UserModel? userModel;
  List<UserModel> doctors = [];
  List<UserModel> patients = [];
  late UserModel selectedDoctor;
}
