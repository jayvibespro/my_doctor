import 'package:injectable/injectable.dart';
import 'package:my_doctor/core/models/time_slot_model.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

@singleton
class BookingState {
  List<TimeSlotModel> timeSlots = [];
}
