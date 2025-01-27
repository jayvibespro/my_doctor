import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/models/booking_model.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';

import 'booking_status_card.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class BookingCard extends StatelessWidget {
  final BookingModel booking;

  const BookingCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: cBackground,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.asset('assets/images/app_logo.png'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            booking.patientName ?? "",
                            // maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: HeroIcon(
                            HeroIcons.arrowRight,
                            color: Colors.grey,
                            size: 12,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            booking.doctorName ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${booking.date} - ${booking.time}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        BookingStatusCard(
                          status: booking.status ?? "",
                        ),
                      ],
                    ),
                    Text(
                      booking.description ?? "",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
