import 'package:my_doctor/core/services/firebase_services/booking_service.dart';
import 'package:my_doctor/core/services/firebase_services/user_service.dart';

import 'firebase_services/auth_service.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class DataService extends AuthService with UserService, BookingService {}
