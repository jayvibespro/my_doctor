import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/screens/doctors_screens/create_doctor_screen.dart';

import '../screens/home_screen/home_screen_controller.dart';

/*
   * Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
**/

void doctorMoreBottomSheet(
    {required BuildContext context, required var homeController}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.8,
        minChildSize: 0.5,
        snap: true,
        snapAnimationDuration: const Duration(milliseconds: 200),
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: cBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '${homeController.appState.selectedDoctor?.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '${homeController.appState.selectedDoctor?.phone}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${homeController.appState.selectedDoctor?.email}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 0),
                    child: Divider(color: cGrey),
                  ),
                  ...[
                    [
                      const HeroIcon(
                        HeroIcons.pencilSquare,
                        color: cCardGreen,
                      ),
                      'Edit',
                      () {
                        Get.off(
                          () => CreateDoctorScreen(
                            doctor: homeController.appState.selectedDoctor,
                          ),
                          transition: Transition.rightToLeft,
                          curve: Curves.easeInOutBack,
                          duration: const Duration(
                            milliseconds: 1200,
                          ),
                        );
                      },
                    ],
                    [
                      const HeroIcon(
                        HeroIcons.archiveBoxXMark,
                        color: Colors.red,
                      ),
                      'Deactivate',
                      () {
                        Get.off(
                          () => CreateDoctorScreen(
                            doctor: homeController.appState.selectedDoctor,
                          ),
                          transition: Transition.rightToLeft,
                          curve: Curves.easeInOutBack,
                          duration: const Duration(
                            milliseconds: 1200,
                          ),
                        );
                      },
                    ],
                  ].map((item) {
                    return ListTile(
                      onTap: item[2] as void Function(),
                      leading: item[0] as Widget,
                      title: Text(
                        (item[1] as String).tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
