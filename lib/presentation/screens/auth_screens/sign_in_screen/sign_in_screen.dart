import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:my_doctor/presentation/screens/auth_screens/reset_password_screen/reset_password_screen.dart';
import 'package:my_doctor/presentation/screens/auth_screens/sign_in_screen/sign_in_screen_controller.dart';
import 'package:flutter/services.dart';
import 'package:my_doctor/presentation/screens/auth_screens/sign_up_screen/sign_up_screen.dart';
import 'package:my_doctor/presentation/screens/profile_screen/profile_screen.dart';
import '../../../../../core/di/di.dart';
import '../../../../core/models/user_model/user_model.dart';
import '../../../components/custom_material_button.dart';
import '../../../components/custom_outline_button.dart';
import '../../../components/custom_text_field.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _signInScreenController = getIt<SignInScreenController>();

  @override
  void initState() {
    _signInScreenController.initialize(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: cBackground,
        systemNavigationBarColor: cBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: cBackground,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(
                height: 20,
              ),
              Hero(
                tag: "APP_LOGO",
                child: Image.asset(
                  'assets/images/app_logo.png',
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "My Doctor",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const Text(
                "Book your doctor effortlessly and take charge of your health.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
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
                      "Sign in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    const Text(
                      "Enter your sign in credentials to continue",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                    CustomMaterialButton(
                      onPressed: () {
                        Get.to(
                          () => const ProfileScreen(),
                          transition: Transition.circularReveal,
                          curve: Curves.easeInOut,
                          duration: const Duration(
                            milliseconds: 1200,
                          ),
                        );

                        if (_formKey.currentState!.saveAndValidate()) {
                          _signInScreenController.state.user = UserModel(
                            email: _formKey.currentState?.value["email"].trim(),
                            password:
                                _formKey.currentState?.value["password"].trim(),
                          );
                          _signInScreenController.signIn();
                        }
                      },
                      label: "Sign in",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomOutlineButton(
                      onPressed: () async {
                        await Get.to(
                          () => const ResetPasswordScreen(),
                          transition: Transition.rightToLeft,
                          curve: Curves.easeInOutBack,
                          duration: const Duration(
                            milliseconds: 1200,
                          ),
                        );
                      },
                      label: "Forgot password?",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 80),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: cGrey,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Or"),
                          ),
                          Expanded(
                            child: Divider(
                              color: cGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomOutlineButton(
                      onPressed: () async {
                        await Get.to(
                          () => const SignUpScreen(),
                          transition: Transition.rightToLeft,
                          curve: Curves.easeInOutBack,
                          duration: const Duration(
                            milliseconds: 1200,
                          ),
                        );
                      },
                      label: "Sign up",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
