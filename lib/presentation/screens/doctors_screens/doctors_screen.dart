import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/screens/doctors_screens/create_doctor_screen.dart';

import '../../components/doctor_card.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Doctors'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DoctorCard(
            onTap: () {},
          ),
          DoctorCard(
            onTap: () {},
          ),
          DoctorCard(
            onTap: () {},
          ),
          DoctorCard(
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const CreateDoctorScreen(),
            transition: Transition.rightToLeft,
            curve: Curves.easeInOutBack,
            duration: const Duration(
              milliseconds: 1200,
            ),
          );
        },
        child: const HeroIcon(
          HeroIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
