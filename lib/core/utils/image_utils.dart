import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class ImageUtils {
  static Future<File?> compressXFile(XFile? xFile) async {
    if (xFile == null) {
      return null;
    }

    File file = File(xFile.path);

    final dir = await getTemporaryDirectory();
    final targetPath =
        path.join(dir.path, 'compressed_${path.basename(file.path)}');

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 2300,
      minHeight: 1500,
      quality: 25,
      rotate: 0,
    );

    if (result != null) {
      return File(result.path);
    } else {
      return null;
    }
  }

  static Future<String?> compressImageUint8List(Uint8List imageData) async {
    int quality = 100;
    Uint8List compressedImage;

    do {
      compressedImage = await FlutterImageCompress.compressWithList(
        imageData,
        quality: quality,
      );

      quality -= 10;
    } while (compressedImage.lengthInBytes > 100 * 1024 && quality > 0);

    return base64Encode(compressedImage);
  }
}
