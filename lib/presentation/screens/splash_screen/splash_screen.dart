import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_doctor/presentation/screens/home_screen/home_screen.dart';
import 'package:my_doctor/presentation/screens/splash_screen/splash_screen_controller.dart';

import '../../../core/di/di.dart';
import '../../../core/utils/constants/colors.dart';
import '../auth_screens/sign_in_screen/sign_in_screen.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _splashScreenController = getIt<SplashScreenController>();
  late AnimationController _logoTranslateAnimationController;
  late AnimationController _logoScaleAnimationController;

  late Animation<double> _logoTranslateAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    _splashScreenController.initialize(setState, context);
    _initAnimations();
    super.initState();
  }

  @override
  void dispose() {
    _logoTranslateAnimationController.dispose();
    _logoScaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: cPrimary.withOpacity(0.3),
        systemNavigationBarColor: cPrimary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                cPrimary.withOpacity(0.3),
                cPrimary,
              ],
            ),
          ),
          child: Center(
            child: AnimatedBuilder(
              animation: _logoTranslateAnimation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, _logoTranslateAnimation.value),
                  child: Opacity(
                    opacity: _logoTranslateAnimationController.value,
                    child: Transform.scale(
                      scale: _logoScaleAnimation.value,
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        width: 200,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _initAnimations() {
    _logoTranslateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addListener(() {});

    _logoScaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addListener(() {});

    _logoTranslateAnimation = Tween<double>(begin: 400, end: 0).animate(
      CurvedAnimation(
        parent: _logoTranslateAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _logoScaleAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    _logoScaleAnimationController.forward();
    await _logoTranslateAnimationController.forward();

    await Future.delayed(
      const Duration(
        milliseconds: 1600,
      ),
    );

    if (_splashScreenController.appState.userModel != null) {
      Get.off(
        () => const HomeScreen(),
        transition: Transition.circularReveal,
        curve: Curves.easeInOut,
        duration: const Duration(
          milliseconds: 1600,
        ),
      );
    } else {
      Get.off(
        () => const SignInScreen(),
        transition: Transition.circularReveal,
        curve: Curves.easeInOut,
        duration: const Duration(
          milliseconds: 1600,
        ),
      );
    }
  }
}
