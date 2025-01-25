import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/screens/auth_screens/reset_password_screen/reset_password_screen_controller.dart';

import '../../../../core/di/di.dart';
import '../../../components/custom_material_button.dart';
import '../../../components/custom_text_field.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _resetPasswordScreenController = getIt<ResetPasswordScreenController>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _resetPasswordScreenController.initialize(setState, context);
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
          title: const Text(
            "Reset Password",
          ),
        ),
        body: FormBuilder(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(15.0),
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Forgot your Password?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "Enter your account signing Email.\nYou will receive and email to reset your password shortly after clicking the \"Send reset email\" button."),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                initialValue: _resetPasswordScreenController.state.user?.email,
                hint: "Email Address",
                name: "email",
                keyboard: TextInputType.emailAddress,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              CustomMaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    _resetPasswordScreenController.resetPassword(
                      _formKey.currentState?.value["email"].trim(),
                    );
                  }
                },
                label: "Send reset email",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
