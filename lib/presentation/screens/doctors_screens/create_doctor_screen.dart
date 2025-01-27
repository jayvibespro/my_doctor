import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_doctor/core/models/user_model.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';

import '../../components/custom_material_button.dart';
import '../../components/custom_text_field.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 26|01|2025
* */

class CreateDoctorScreen extends StatefulWidget {
  final UserModel? doctor;
  const CreateDoctorScreen({super.key, this.doctor});

  @override
  State<CreateDoctorScreen> createState() => _CreateDoctorScreenState();
}

class _CreateDoctorScreenState extends State<CreateDoctorScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
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
          title: Text(widget.doctor != null ? "Edit User" : "Create User"),
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
                      initialValue: widget.doctor?.name,
                      hint: "Full Name",
                      name: "fullName",
                    ),
                    CustomTextField(
                      initialValue: widget.doctor?.email,
                      hint: "Email",
                      name: "email",
                      keyboard: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ],
                      ),
                    ),
                    CustomTextField(
                      initialValue: widget.doctor?.phone,
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
                    CustomTextField(
                      initialValue: widget.doctor?.speciality,
                      hint: "Speciality",
                      name: "speciality",
                    ),
                    CustomMaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          /*_editProfileScreenController.state.user?.phoneNumber =
                              _formKey.currentState?.value["phoneNumber"]
                                  .trim();
                          _editProfileScreenController.editProfile();*/
                        }
                      },
                      label: widget.doctor != null ? "Save Changes" : "Create",
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
