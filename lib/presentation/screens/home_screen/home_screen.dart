import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/screens/booking_screen/booking_screen.dart';
import 'package:my_doctor/presentation/screens/doctors_screens/doctors_screen.dart';
import 'package:my_doctor/presentation/screens/home_screen/home_screen_controller.dart';
import 'package:my_doctor/presentation/screens/patients_screen/patients_screen.dart';
import 'package:my_doctor/presentation/screens/profile_screen/profile_screen.dart';

import '../../../core/di/di.dart';
import '../../components/booking_card.dart';
import '../../components/doctor_card.dart';
import '../../components/patient_card.dart';
import '../../components/section_header.dart';
import 'components/home_card.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeScreenController = getIt<HomeScreenController>();
  String accountType = '';

  @override
  void initState() {
    _homeScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: cPrimary,
        title: Text(_homeScreenController.appState.userModel?.name ?? "Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () async {
                await Get.to(
                  () => const ProfileScreen(),
                  transition: Transition.rightToLeft,
                  curve: Curves.easeInOutBack,
                  duration: const Duration(
                    milliseconds: 1200,
                  ),
                );
                setState(() {});
              },
              child: const HeroIcon(
                HeroIcons.userCircle,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: cBackground,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    cPrimary,
                    cPrimary.withOpacity(0.4),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HeroIcon(
                    HeroIcons.userCircle,
                    color: Colors.white,
                    size: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _homeScreenController.appState.userModel?.email ??
                        "abc@gmail.com",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _homeScreenController.appState.userModel?.name ?? "Account",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () async {
                await Get.to(
                  () => const ProfileScreen(),
                  transition: Transition.rightToLeft,
                  curve: Curves.easeInOutBack,
                  duration: const Duration(
                    milliseconds: 1200,
                  ),
                );
                setState(() {});
              },
              leading: const HeroIcon(
                HeroIcons.user,
                color: Colors.black54,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const ListTile(
              leading: HeroIcon(
                HeroIcons.cog,
                color: Colors.black54,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: _homeScreenController.signOut,
              leading: const HeroIcon(
                HeroIcons.arrowRightOnRectangle,
                color: Colors.black54,
              ),
              title: const Text(
                'Sign out',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cBackground,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Patients',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '12',
                        style: TextStyle(
                          color: cPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Doctors',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '5',
                        style: TextStyle(
                          color: cPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Bookings',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '17',
                        style: TextStyle(
                          color: cPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              HomeCard(
                icon: const HeroIcon(
                  HeroIcons.userGroup,
                  color: Colors.black,
                  size: 30,
                ),
                onTap: () {
                  Get.to(
                    () => const PatientsScreen(),
                    transition: Transition.rightToLeft,
                    curve: Curves.easeInOutBack,
                    duration: const Duration(
                      milliseconds: 1200,
                    ),
                  );
                },
                label: 'Patient',
                colors: [
                  cPrimary.withOpacity(0.1),
                  cPrimary,
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              HomeCard(
                icon: const HeroIcon(
                  HeroIcons.checkBadge,
                  color: Colors.black,
                  size: 30,
                ),
                onTap: () {
                  Get.to(
                    () => const DoctorsScreen(),
                    transition: Transition.rightToLeft,
                    curve: Curves.easeInOutBack,
                    duration: const Duration(
                      milliseconds: 1200,
                    ),
                  );
                },
                label: 'Doctor',
                colors: [
                  cAccent.withOpacity(0.1),
                  cAccent,
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              HomeCard(
                icon: const HeroIcon(
                  HeroIcons.calendarDays,
                  color: Colors.black,
                  size: 30,
                ),
                onTap: () {},
                label: 'Bookings',
                colors: [
                  cYellow.withOpacity(0.1),
                  cYellow,
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SectionHeader(
            title: 'Recent Bookings',
          ),
          const BookingCard(),
          const BookingCard(),
          const BookingCard(),
          SectionHeader(
            title: 'Doctors',
            onTap: () {
              Get.to(
                () => const DoctorsScreen(),
                transition: Transition.rightToLeft,
                curve: Curves.easeInOutBack,
                duration: const Duration(
                  milliseconds: 1200,
                ),
              );
            },
          ),
          DoctorCard(
            onTap: () {
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
          DoctorCard(
            onTap: () {
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
          SectionHeader(
            title: 'Patients',
            onTap: () {
              Get.to(
                () => const PatientsScreen(),
                transition: Transition.rightToLeft,
                curve: Curves.easeInOutBack,
                duration: const Duration(
                  milliseconds: 1200,
                ),
              );
            },
          ),
          const PatientCard(),
          const PatientCard(),
        ],
      ),
    );
  }
}
