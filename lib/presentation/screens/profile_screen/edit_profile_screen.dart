import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';

import '../../../../core/di/di.dart';
import '../../components/custom_material_button.dart';
import '../../components/custom_text_field.dart';
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
                          _editProfileScreenController.editProfile();
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
