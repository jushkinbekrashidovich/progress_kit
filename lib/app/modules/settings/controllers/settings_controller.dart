import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class SettingsController extends GetxController {


  String ?appVersion;

  @override
  void onInit() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    super.onInit();

  }


  Future<void> sendFeedback() async {
    try {
      // Get app version details
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;

      // Get device info
      String osVersion = Platform.operatingSystemVersion;
      String os = Platform.isAndroid ? "Android" : "iOS";

      // Construct email body
      String emailBody = '''
      
      
      
    Phone specification:
    OS: $os $osVersion
   App Version: $appVersion

   Your feedback:
   ''';

      // Encode mailto link
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'jushkinbek.co@gmail.com',
        queryParameters: {
          'subject': 'ProgressKit Feedback',
          'body': emailBody,
        },
      );

      // Launch email app
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw 'Could not launch email app.';
      }
    } catch (e) {
      print('Error sending feedback: $e');
    }
  }
}
