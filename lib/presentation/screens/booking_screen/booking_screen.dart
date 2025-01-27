import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/components/custom_material_button.dart';
import 'package:my_doctor/presentation/components/custom_text_field.dart';
import 'package:my_doctor/presentation/screens/booking_screen/booking_screen_controller.dart';
import 'package:my_doctor/presentation/screens/booking_screen/components/slot_select_indicator.dart';
import 'package:my_doctor/presentation/screens/booking_screen/components/time_slot_card.dart';

import '../../../core/di/di.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _bookingScreenController = getIt<BookingScreenController>();
  String selectedTime = '';
  DateTime? selectedDate;

  Future<void> _openDatePicker() async {
    DateTime today = DateTime.now();
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: cPrimary, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: cBlackMain, backgroundColor: cPrimary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    _bookingScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Book an Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                HeroIcon(
                  HeroIcons.userCircle,
                  size: 50,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doctor Full name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Doctor email',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Doctor phone number',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Speciality',
                        style: TextStyle(
                          color: cPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: 'Appointment Date',
              name: 'date',
              label: 'Appointment Date',
              readOnly: true,
              onTap: () {
                _openDatePicker();
              },
            ),
            const Text('Time Slots'),
            const SlotSelectIndicator(
              label: 'Selected',
            ),
            const SlotSelectIndicator(
              label: 'Available',
            ),
            const SlotSelectIndicator(
              label: 'Taken',
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.5,
                ),
                itemCount: _bookingScreenController.state.timeSlots.length,
                itemBuilder: (context, index) {
                  final timeSlot =
                      _bookingScreenController.state.timeSlots[index];
                  return TimeSlotCard(
                    selectedTime: selectedTime,
                    timeSlot: timeSlot,
                    onTap: () {
                      selectedTime = timeSlot.time;
                      setState(() {});
                    },
                  );
                },
              ),
            ),
            CustomMaterialButton(
              backgroundColor: selectedTime == "" ? Colors.grey : cPrimary,
              onPressed: () {},
              label: 'Finish Booking',
            ),
          ],
        ),
      ),
    );
  }
}
