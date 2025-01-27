import 'package:url_launcher/url_launcher.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class AppLauncherUtil {
  static Future<void> launchPhone(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(url)) {
      throw Exception('Could not Open Phone');
    }
  }

  static Future<void> launchMessage(String phoneNumber) async {
    final Uri url = Uri.parse('sms:$phoneNumber');
    if (!await launchUrl(url)) {
      throw Exception('Could not Open Message');
    }
  }
}
