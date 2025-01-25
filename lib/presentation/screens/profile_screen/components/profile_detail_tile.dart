import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors.dart';

class ProfileDetailsTile extends StatelessWidget {
  const ProfileDetailsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.isAdmin,
  });

  final String title;
  final String subtitle;
  final Icon icon;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 4,
              decoration: BoxDecoration(
                color: isAdmin ? cAccent : cPrimary.withOpacity(0.9),
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(4)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
