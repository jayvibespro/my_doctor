import 'package:flutter/material.dart';
import 'package:my_doctor/core/models/time_slot_model.dart';

import '../../../../core/utils/constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

class TimeSlotCard extends StatelessWidget {
  final String selectedTime;
  final VoidCallback onTap;
  final TimeSlotModel timeSlot;

  const TimeSlotCard({
    super.key,
    required this.selectedTime,
    required this.timeSlot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: timeSlot.isTaken ? null : onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: timeSlot.isTaken
              ? cGrey
              : selectedTime == timeSlot.time
                  ? cPrimary
                  : cCardGreen,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            timeSlot.time,
            style: TextStyle(
              color: timeSlot.isTaken ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
