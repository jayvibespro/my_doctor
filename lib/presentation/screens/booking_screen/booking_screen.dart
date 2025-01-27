import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/app_launcher_util.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/core/utils/string_utils.dart';
import 'package:my_doctor/presentation/components/custom_loader.dart';
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
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedTime = '';
  DateTime? selectedDate;

  @override
  void initState() {
    _bookingScreenController.initialize(setState, context);
    _bookingScreenController.getBookingsByDateAndDoctor(
        StringUtils.ymdDateFormatter(DateTime.now(), pattern: 'dd-MM-yyy'));
    dateController.text =
        StringUtils.ymdDateFormatter(DateTime.now(), pattern: 'dd-MM-yyy');
    super.initState();
  }

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

        dateController.text =
            StringUtils.ymdDateFormatter(pickedDate, pattern: 'dd-MM-yyy');
        _bookingScreenController
            .getBookingsByDateAndDoctor(dateController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Book an Appointment'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 10),
            child: Row(
              children: [
                const HeroIcon(
                  HeroIcons.userCircle,
                  size: 50,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _bookingScreenController.appState.selectedDoctor.name ??
                            "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _bookingScreenController
                                .appState.selectedDoctor.email ??
                            "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        _bookingScreenController
                                .appState.selectedDoctor.phone ??
                            "",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _bookingScreenController
                                      .appState.selectedDoctor.speciality ??
                                  "",
                              style: const TextStyle(
                                color: cPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AppLauncherUtil.launchPhone(
                                  _bookingScreenController
                                          .appState.selectedDoctor.phone ??
                                      "0000000000");
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: const HeroIcon(
                              HeroIcons.phone,
                              style: HeroIconStyle.solid,
                              color: cCardGreen,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              AppLauncherUtil.launchMessage(
                                  _bookingScreenController
                                          .appState.selectedDoctor.phone ??
                                      "0000000000");
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: const HeroIcon(
                              HeroIcons.chatBubbleLeft,
                              style: HeroIconStyle.solid,
                              color: cPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: cGrey,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                CustomTextField(
                  controller: dateController,
                  hint: 'Appointment Date',
                  name: 'date',
                  label: 'Appointment Date',
                  readOnly: true,
                  onTap: () {
                    _openDatePicker();
                  },
                ),
                CustomTextField(
                  controller: descriptionController,
                  hint: 'Description',
                  name: 'description',
                  label: 'Description',
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
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: _bookingScreenController.state.timeSlots
                      .map((slot) => TimeSlotCard(
                            selectedTime: selectedTime,
                            timeSlot: slot,
                            onTap: () {
                              selectedTime = slot.time;
                              setState(() {});
                            },
                          ))
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomMaterialButton(
                    backgroundColor:
                        selectedTime == "" || descriptionController.text.isEmpty
                            ? Colors.grey
                            : cPrimary,
                    onPressed:
                        selectedTime == "" || descriptionController.text.isEmpty
                            ? () {}
                            : () {
                                _bookingScreenController.createBooking(
                                  dateController.text,
                                  selectedTime,
                                  descriptionController.text,
                                );
                              },
                    label: 'Finish Booking',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
