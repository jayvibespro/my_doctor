import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/screens/profile_screen/edit_profile_screen.dart';
import 'package:my_doctor/presentation/screens/profile_screen/profile_screen_controller.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/string_utils.dart';
import '../../components/custom_material_button.dart';
import 'components/profile_detail_tile.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileScreenController = getIt<ProfileScreenController>();

  @override
  void initState() {
    _profileScreenController.initialize(setState, context);
    super.initState();
  }

  File? cachedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.info_outline),
              ),
            ],
            pinned: true,
            title: const Text("Profile"),
            centerTitle: true,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: double.infinity,
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
                child: CircleAvatar(
                  backgroundColor: cBackground,
                  child: CircleAvatar(
                    radius: 140,
                    backgroundColor: cPrimary.withOpacity(0.8),
                    child:
                        _profileScreenController.appState.userModel?.imageUrl ==
                                    null ||
                                _profileScreenController
                                        .appState.userModel?.imageUrl ==
                                    ""
                            ? const HeroIcon(
                                HeroIcons.userCircle,
                                color: Colors.black54,
                                size: 200,
                              )
                            : ClipOval(
                                child: cachedImage != null
                                    ? Image.file(
                                        cachedImage!,
                                        fit: BoxFit.cover,
                                        width: 600.0,
                                        height: 600.0,
                                      )
                                    : Image.network(
                                        _profileScreenController
                                                .appState.userModel?.imageUrl ??
                                            "",
                                        fit: BoxFit.cover,
                                        width: 600.0,
                                        height: 600.0,
                                      ),
                              ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfileDetailsTile(
                        icon: const Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black54,
                        ),
                        title: 'Account type',
                        subtitle: _profileScreenController
                                .appState.userModel?.accountType ??
                            "USER",
                        isAdmin: true,
                      ),
                      ProfileDetailsTile(
                        isAdmin: false,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.black54,
                        ),
                        title: 'Full name',
                        subtitle:
                            _profileScreenController.appState.userModel?.name ??
                                "",
                      ),
                      ProfileDetailsTile(
                        isAdmin: false,
                        icon: const Icon(
                          Icons.email_rounded,
                          color: Colors.black54,
                        ),
                        title: 'Email address',
                        subtitle: _profileScreenController
                                .appState.userModel?.email ??
                            "",
                      ),
                      ProfileDetailsTile(
                        isAdmin: false,
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.black54,
                        ),
                        title: 'Phone number',
                        subtitle: _profileScreenController
                                .appState.userModel?.phone ??
                            "",
                      ),
                      ProfileDetailsTile(
                        isAdmin: false,
                        icon: const Icon(
                          Icons.watch_later_outlined,
                          color: Colors.black54,
                        ),
                        title: 'Created At',
                        subtitle:
                            "${StringUtils.isoStringToDate(_profileScreenController.appState.userModel?.createdAt ?? DateTime.now().toString())} - ${StringUtils.isoStringTime(_profileScreenController.appState.userModel?.createdAt ?? DateTime.now().toString())}",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomMaterialButton(
                        onPressed: () async {
                          await Get.to(
                            () => const EditProfileScreen(),
                            transition: Transition.rightToLeft,
                            curve: Curves.easeInOutBack,
                            duration: const Duration(
                              milliseconds: 1200,
                            ),
                          );
                          setState(() {});
                        },
                        label: 'Edit profile',
                      ),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
