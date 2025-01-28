import 'package:flutter/material.dart';
import 'package:my_doctor/core/utils/constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 28|01|2025
* */

selectImageBottomSheet({
  required BuildContext context,
  required Function() cameraAction,
  required Function() galleryAction,
}) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: cBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Select Image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12,
                top: 0,
                bottom: 0,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: cameraAction,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.camera,
                          color: cBlack,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Open Camera'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12,
                top: 0,
                bottom: 0,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: galleryAction,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.photo,
                          color: cBlack,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Select from gallery'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
