import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';

import '../../../../core/di/di.dart';
import '../../components/custom_material_button.dart';
import '../../components/custom_text_field.dart';
import '../../components/select_image_bottom_sheet.dart';
import 'edit_profile_screen_controller.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _editProfileScreenController = getIt<EditProfileScreenController>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  File? avatarImage;

  @override
  void initState() {
    _editProfileScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  Future pickImage(ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File imageTemporary = File(image.path);
      avatarImage = imageTemporary;
      setState(() {});
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: cPrimary,
        systemNavigationBarColor: cBackground,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        backgroundColor: cBackground,
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text("Edit Profile"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          selectImageBottomSheet(
                            context: context,
                            cameraAction: () {
                              Get.back();
                              pickImage(ImageSource.camera);
                            },
                            galleryAction: () {
                              Get.back();
                              pickImage(ImageSource.gallery);
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: avatarImage != null ? 100 : 56,
                              child: CircleAvatar(
                                backgroundColor: cGrey,
                                radius: avatarImage != null ? 92 : 50,
                                child: ClipOval(
                                  child: avatarImage != null
                                      ? Image.file(
                                          avatarImage!,
                                          fit: BoxFit.cover,
                                          width: 200.0,
                                          height: 200.0,
                                        )
                                      : (_editProfileScreenController.appState
                                                      .userModel?.imageUrl ??
                                                  '') ==
                                              ''
                                          ? const HeroIcon(
                                              HeroIcons.user,
                                              size: 50,
                                              color: Colors.black54,
                                            )
                                          : Image.network(
                                              _editProfileScreenController
                                                      .appState
                                                      .userModel
                                                      ?.imageUrl ??
                                                  '',
                                              fit: BoxFit.cover,
                                              width: 200.0,
                                              height: 200.0,
                                            ),
                                ),
                              ),
                            ),
                            const Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: cBackground,
                                radius: 22,
                                child: CircleAvatar(
                                  backgroundColor: cCardGreen,
                                  radius: 16,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      initialValue:
                          _editProfileScreenController.appState.userModel?.name,
                      hint: "Full Name",
                      name: "fullName",
                    ),
                    CustomTextField(
                      readOnly: true,
                      initialValue: _editProfileScreenController
                          .appState.userModel?.email,
                      keyboard: TextInputType.emailAddress,
                      hint: "Email",
                      name: "email",
                    ),
                    CustomTextField(
                      initialValue: _editProfileScreenController
                          .appState.userModel?.phone,
                      hint: "Phone Number",
                      name: "phoneNumber",
                      keyboard: TextInputType.phone,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.integer(),
                          FormBuilderValidators.maxLength(10),
                        ],
                      ),
                    ),
                    if (_editProfileScreenController
                            .appState.userModel?.accountType ==
                        "DOCTOR")
                      CustomTextField(
                        initialValue: _editProfileScreenController
                            .appState.userModel?.speciality,
                        hint: "Speciality",
                        name: "speciality",
                      ),
                    CustomMaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          _editProfileScreenController
                                  .appState.userModel?.phone =
                              _formKey.currentState?.value["phoneNumber"]
                                  .trim();
                          _editProfileScreenController
                                  .appState.userModel?.name =
                              _formKey.currentState?.value["fullName"].trim();
                          _editProfileScreenController
                                  .appState.userModel?.speciality =
                              _formKey.currentState?.value["speciality"] ?? '';
                          _editProfileScreenController.editProfile(avatarImage);
                        }
                      },
                      label: "Save Changes",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
