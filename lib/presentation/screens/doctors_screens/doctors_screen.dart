import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/screens/doctors_screens/create_doctor_screen.dart';
import 'package:my_doctor/presentation/screens/doctors_screens/doctors_screen_controller.dart';

import '../../../core/di/di.dart';
import '../../components/custom_loader.dart';
import '../../components/doctor_card.dart';
import '../../components/more_doctor_bottom_sheet.dart';
import '../booking_screen/booking_screen.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final _doctorsScreenController = getIt<DoctorsScreenController>();

  @override
  void initState() {
    _doctorsScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Doctors'),
      ),
      body: _doctorsScreenController.state.loading
          ? const CustomLoader()
          : ListView(
              padding: const EdgeInsets.all(20),
              children: _doctorsScreenController.appState.doctors
                  .map(
                    (doctor) => DoctorCard(
                      doctor: doctor,
                      onTap: () {
                        _doctorsScreenController.appState.selectedDoctor =
                            doctor;
                        if (_doctorsScreenController
                                .appState.userModel?.accountType ==
                            "ADMIN") {
                          doctorMoreBottomSheet(
                            context: context,
                            homeController: _doctorsScreenController,
                          );
                          return;
                        }

                        Get.to(
                          () => const BookingScreen(),
                          transition: Transition.rightToLeft,
                          curve: Curves.easeInOutBack,
                          duration: const Duration(
                            milliseconds: 1200,
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
      floatingActionButton:
          _doctorsScreenController.appState.userModel?.accountType == 'ADMIN'
              ? FloatingActionButton(
                  backgroundColor: cPrimary,
                  onPressed: () async {
                    bool? result = await Get.to(
                      () => const CreateDoctorScreen(),
                      transition: Transition.rightToLeft,
                      curve: Curves.easeInOutBack,
                      duration: const Duration(
                        milliseconds: 1200,
                      ),
                    );
                    if (result == true) {
                      _doctorsScreenController.getDoctors();
                    }
                  },
                  child: const HeroIcon(
                    HeroIcons.plus,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
    );
  }
}
