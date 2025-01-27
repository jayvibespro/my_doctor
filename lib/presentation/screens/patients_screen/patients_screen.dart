import 'package:flutter/material.dart';

import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/components/patient_card.dart';
import 'package:my_doctor/presentation/screens/patients_screen/patients_screen_controller.dart';

import '../../../core/di/di.dart';
import '../../components/custom_loader.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final _patientsScreenController = getIt<PatientsScreenController>();

  @override
  void initState() {
    _patientsScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Patients'),
      ),
      body: _patientsScreenController.state.loading
          ? const CustomLoader()
          : ListView(
              padding: const EdgeInsets.all(20),
              children: _patientsScreenController.appState.patients
                  .map(
                    (patient) => PatientCard(
                      patient: patient,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
