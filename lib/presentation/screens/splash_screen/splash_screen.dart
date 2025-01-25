import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_doctor/presentation/screens/splash_screen/splash_screen_controller.dart';

import '../../../core/di/di.dart';
import '../../../core/utils/constants/colors.dart';
import '../auth_screens/sign_in_screen.dart';

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
      value: const SystemUiOverlayStyle(
        statusBarColor: cPrimary,
        systemNavigationBarColor: cPrimary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: cPrimary,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _logoTranslateAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: Offset(0, _logoTranslateAnimation.value),
                    child: Opacity(
                      opacity: _logoTranslateAnimationController.value,
                      child: Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Hero(
                          tag: "APP_LOGO",
                          child: Image.asset(
                            'assets/images/app_logo.png',
                            width: 200,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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

    /* Get.off(
      () => const RootScreen(),
      transition: Transition.circularReveal,
      curve: Curves.easeInOut,
      duration: const Duration(
        milliseconds: 1600,
      ),
    );

    return;*/

    await Future.delayed(
      const Duration(
        milliseconds: 1600,
      ),
    );

    if (_splashScreenController.appState.userModel != null) {
      /*   Get.off(
        () => const RootScreen(),
        transition: Transition.circularReveal,
        curve: Curves.easeInOut,
        duration: const Duration(
          milliseconds: 1600,
        ),
      );*/
    } else {
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignInScreen()));
    }
  }
}
