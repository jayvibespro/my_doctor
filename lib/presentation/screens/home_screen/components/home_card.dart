import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class HomeCard extends StatelessWidget {
  final String label;
  final List<Color> colors;
  final VoidCallback onTap;
  final Widget icon;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const HomeCard({
    super.key,
    required this.onTap,
    required this.label,
    required this.colors,
    required this.icon,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: colors,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 30,
          ),
          child: Column(
            children: [
              icon,
              const SizedBox(
                height: 20,
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const HeroIcon(
                HeroIcons.arrowRight,
                color: Colors.black,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
