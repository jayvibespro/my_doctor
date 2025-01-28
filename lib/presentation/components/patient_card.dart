import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/models/user_model.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class PatientCard extends StatelessWidget {
  final UserModel patient;

  const PatientCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: cBackground,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: cGrey,
              ),
              child: patient.imageUrl != ''
                  ? CachedNetworkImage(
                      imageUrl: patient.imageUrl ?? "",
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade300,
                        child: Center(
                          child: HeroIcon(
                            HeroIcons.photo,
                            color: cGrey,
                            style: HeroIconStyle.solid,
                            size: 60,
                          ),
                        ),
                      ),
                      fit: BoxFit.cover,
                    )
                  : const HeroIcon(
                      HeroIcons.user,
                      color: cPrimary,
                      size: 30,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name ?? "",
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      patient.phone ?? "",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const HeroIcon(
              HeroIcons.arrowRight,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
