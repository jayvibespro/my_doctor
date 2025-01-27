import 'package:flutter/material.dart';

import '../../core/utils/constants/colors.dart';

class BookingStatusCard extends StatelessWidget {
  final String status;
  const BookingStatusCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 1, 4, 2),
      decoration: BoxDecoration(
        color: status == 'COMPLETED'
            ? cCardGreen
            : status == 'MISSED'
                ? cYellow
                : status == 'CANCELLED'
                    ? Colors.red
                    : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.toLowerCase(),
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
