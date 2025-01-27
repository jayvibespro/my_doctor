import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/screens/booking_screen/bookings_screen_controller.dart';

import '../../../core/di/di.dart';
import '../../components/booking_card.dart';
import '../../components/custom_loader.dart';
import 'booking_details_screen.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final _bookingsScreenController = getIt<BookingsScreenController>();

  @override
  void initState() {
    _bookingsScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Bookings'),
      ),
      body: _bookingsScreenController.state.loading
          ? const CustomLoader()
          : ListView(
              padding: const EdgeInsets.all(20),
              children: _bookingsScreenController.appState.bookings
                  .map(
                    (booking) => BookingCard(
                      booking: booking,
                      onTap: () async {
                        _bookingsScreenController.appState.selectedBooking =
                            booking;
                        bool? result = await Get.to(
                          () => const BookingDetailsScreen(),
                          transition: Transition.rightToLeft,
                          curve: Curves.easeInOutBack,
                          duration: const Duration(
                            milliseconds: 1200,
                          ),
                        );
                        if (result == true) {
                          _bookingsScreenController.getBookings();
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
