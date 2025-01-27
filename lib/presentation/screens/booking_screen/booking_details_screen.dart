import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/components/booking_status_card.dart';
import 'package:my_doctor/presentation/components/custom_material_button.dart';
import 'package:my_doctor/presentation/screens/booking_screen/booking_details_screen_controller.dart';

import '../../../core/di/di.dart';
import '../../components/custom_dropdown_field.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _bookingDetailsScreenController =
      getIt<BookingDetailsScreenController>();
  String status = '';

  @override
  void initState() {
    _bookingDetailsScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Booking Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (_bookingDetailsScreenController.appState.userModel?.accountType !=
              'PATIENT')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Patient's Info",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text("Name:"),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(_bookingDetailsScreenController
                              .appState.selectedBooking.patientName ??
                          ""),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text("Phone:"),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(_bookingDetailsScreenController
                              .appState.selectedBooking.patientPhone ??
                          ""),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          if (_bookingDetailsScreenController.appState.userModel?.accountType !=
              'DOCTOR')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Doctor's Info",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text("Name:"),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(_bookingDetailsScreenController
                              .appState.selectedBooking.doctorName ??
                          ""),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text("Phone:"),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(_bookingDetailsScreenController
                              .appState.selectedBooking.doctorPhone ??
                          ""),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          const Text(
            'Appointment Info',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Text("Date:"),
              ),
              Expanded(
                flex: 4,
                child: Text(_bookingDetailsScreenController
                        .appState.selectedBooking.date ??
                    ""),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Text("Time:"),
              ),
              Expanded(
                flex: 4,
                child: Text(_bookingDetailsScreenController
                        .appState.selectedBooking.time ??
                    ""),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Text("Created At:"),
              ),
              Expanded(
                flex: 4,
                child: Text(_bookingDetailsScreenController
                        .appState.selectedBooking.createdAt ??
                    ""),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Text("Description:"),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  _bookingDetailsScreenController
                          .appState.selectedBooking.description ??
                      "",
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Text("Status:"),
              ),
              Flexible(
                flex: 4,
                child: BookingStatusCard(
                  status: _bookingDetailsScreenController
                          .appState.selectedBooking.status ??
                      "",
                ),
              ),
            ],
          ),
          if (_bookingDetailsScreenController.appState.userModel?.accountType !=
              'PATIENT')
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Divider(
                    height: 40,
                    color: cGrey,
                  ),
                  CustomDropDownField(
                    optionsList: const [
                      DropDownValueModel(name: 'Pending', value: 'PENDING'),
                      DropDownValueModel(name: 'Completed', value: 'COMPLETED'),
                      DropDownValueModel(name: 'Missed', value: 'MISSED'),
                      DropDownValueModel(name: 'Cancel', value: 'CANCELLED'),
                    ],
                    onChange: (value) {
                      if (value != null) {
                        status = value.value;
                        setState(() {});
                      }
                    },
                    hint: 'Booking status',
                    label: 'Booking status',
                  ),
                  CustomMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        _bookingDetailsScreenController
                            .appState.selectedBooking.status = status;
                        _bookingDetailsScreenController.updateBooking();
                      }
                    },
                    label: 'Save changes',
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
