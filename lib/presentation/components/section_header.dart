import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';

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
          const Text(
            'See All',
            style: TextStyle(
              color: cPrimary,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          const HeroIcon(
            HeroIcons.arrowRight,
            color: cPrimary,
            size: 16,
          ),
        ],
      ),
    );
  }
}
