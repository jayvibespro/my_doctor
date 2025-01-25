import 'package:flutter/material.dart';

import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/components/patient_card.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Patients'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          PatientCard(),
          PatientCard(),
          PatientCard(),
          PatientCard(),
        ],
      ),
    );
  }
}
