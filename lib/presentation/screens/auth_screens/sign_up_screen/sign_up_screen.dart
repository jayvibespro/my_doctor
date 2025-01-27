import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:my_doctor/presentation/components/top_snack_bar.dart';
import 'package:my_doctor/presentation/screens/auth_screens/sign_up_screen/sign_up_screen_controller.dart';

import '../../../../core/di/di.dart';
import '../../../../core/models/user_model/user_model.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../components/chip_select.dart';
import '../../../components/custom_material_button.dart';
import '../../../components/custom_outline_button.dart';
import '../../../components/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _signUpScreenController = getIt<SignUpScreenController>();
  String accountType = '';

  @override
  void initState() {
    _signUpScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "APP_LOGO",
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    height: 100,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Doctor",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        "Join us now\nto experience our service.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Account Type',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  ChipSelect(
                    titles: const ["Patient", "Doctor"],
                    actions: [
                      () {
                        accountType = 'PATIENT';
                        setState(() {});
                      },
                      () {
                        accountType = 'DOCTOR';
                        setState(() {});
                      },
                    ],
                    selectedChip: accountType,
                  ),
                  const CustomTextField(
                    label: "Full name",
                    hint: "Full name",
                    name: "name",
                  ),
                  CustomTextField(
                    label: "Email",
                    hint: "abc@gmail.com",
                    name: "email",
                    keyboard: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  CustomTextField(
                    label: "Phone number",
                    hint: "0786******",
                    name: "phone",
                    keyboard: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.equalLength(10),
                    ]),
                  ),
                  if (accountType == 'DOCTOR')
                    const CustomTextField(
                      label: "Speciality",
                      hint: "Speciality",
                      name: "speciality",
                    ),
                  CustomTextField(
                    label: "Password",
                    hint: "********",
                    name: "password",
                    keyboard: TextInputType.text,
                    isPassword: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  CustomTextField(
                    label: "Confirm Password",
                    hint: "********",
                    name: "confirmPassword",
                    keyboard: TextInputType.text,
                    isPassword: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  CustomMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        if (accountType.isEmpty) {
                          topSnackBar(
                              context: context,
                              message:
                                  "Please select your desired account type to proceed");
                          return;
                        }
                        _signUpScreenController.state.user = UserModel(
                          accountType: accountType,
                          imageUrl: '',
                          email: _formKey.currentState?.value["email"].trim(),
                          name: _formKey.currentState?.value["name"].trim(),
                          phone: _formKey.currentState?.value["phone"].trim(),
                          speciality: _formKey.currentState?.value["speciality"]
                                  .trim() ??
                              "",
                          password:
                              _formKey.currentState?.value["password"].trim(),
                          createdAt: DateTime.now().toString(),
                        );
                        _signUpScreenController.signUp();
                      }
                    },
                    label: "Sign up",
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("already have an account?"),
                      ),
                    ],
                  ),
                  CustomOutlineButton(
                    onPressed: () => Get.back(),
                    label: "Sign in",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
