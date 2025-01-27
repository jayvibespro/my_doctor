import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/utils/constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

void topSnackBar(
    {required BuildContext context,
    required String message,
    SnackBarType snackBarType = SnackBarType.info}) {
  Color backgroundColor;
  TextStyle textStyle;
  switch (snackBarType) {
    case SnackBarType.success:
      backgroundColor = cCardGreen;
      textStyle = const TextStyle(
        color: Colors.white,
        fontSize: 14,
      );
      break;
    case SnackBarType.error:
      backgroundColor = const Color(0xffff5252);
      textStyle = const TextStyle(
        color: Colors.white,
        fontSize: 14,
      );
      break;
    case SnackBarType.info:
    default:
      backgroundColor = cBlackTransparent;
      textStyle = const TextStyle(
        color: Colors.white,
        fontSize: 14,
      );
      break;
  }

  return showTopSnackBar(
    dismissDirection: [DismissDirection.horizontal],
    dismissType: DismissType.onSwipe,
    displayDuration: const Duration(seconds: 4),
    Overlay.of(context),
    CustomSnackBar.info(
      message: message,
      messagePadding: const EdgeInsets.symmetric(horizontal: 15),
      backgroundColor: backgroundColor,
      textStyle: textStyle,
    ),
  );
}

enum SnackBarType {
  info,
  success,
  error,
}
