import 'package:flutter/material.dart';

import '../../core/utils/constants/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: cPrimary,
              strokeCap: StrokeCap.round,
              strokeWidth: 8,
            ),
          ],
        ),
      ),
    );
  }
}
