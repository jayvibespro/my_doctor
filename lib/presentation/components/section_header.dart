import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const SectionHeader({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(4),
            child: const Row(
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    color: cPrimary,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                HeroIcon(
                  HeroIcons.arrowRight,
                  color: cPrimary,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
