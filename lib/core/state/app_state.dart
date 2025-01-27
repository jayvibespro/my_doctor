import 'package:injectable/injectable.dart';
import 'package:my_doctor/core/models/booking_model.dart';

import '../models/user_model.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 24|01|2025
* */

@singleton
class AppState {
  UserModel? userModel;
  List<BookingModel> bookings = [];
  List<UserModel> doctors = [];
  List<UserModel> patients = [];
  late UserModel selectedDoctor;
  late BookingModel selectedBooking;
}
