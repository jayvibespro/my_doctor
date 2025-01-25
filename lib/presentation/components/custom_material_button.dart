import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    this.label,
    required this.onPressed,
    this.child,
    this.backgroundColor = cPrimary,
    this.textColor = Colors.white,
    this.radius = 4,
    this.padding = 12,
    this.elevation,
    this.width,
    this.height,
    this.disabled = false,
  });

  final Function() onPressed;
  final Widget? child;
  final Color backgroundColor;
  final Color textColor;
  final String? label;
  final double radius;
  final double padding;
  final double? elevation;
  final double? width;
  final double? height;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: cBlackTransparent,
      disabledElevation: 0,
      elevation: elevation ?? 5,
      minWidth: width ?? MediaQuery.of(context).size.width,
      // height: height ?? 50,
      padding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      color: backgroundColor,
      onPressed: disabled == false ? onPressed : null,
      child: child ??
          Text(
            label ?? "Continue".tr,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}
