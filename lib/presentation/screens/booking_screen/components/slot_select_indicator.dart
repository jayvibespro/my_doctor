import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class SlotSelectIndicator extends StatelessWidget {
  final String label;
  const SlotSelectIndicator({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: label == 'Taken'
                  ? cGrey
                  : label == 'Available'
                      ? cCardGreen
                      : cPrimary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
