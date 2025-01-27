import 'package:injectable/injectable.dart';

import '../../../core/models/user_model.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

@singleton
class AuthState {
  bool loading = false;
  UserModel? user;
}
