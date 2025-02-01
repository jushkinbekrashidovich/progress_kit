import 'package:get/get.dart';
import 'package:progress_kit/app/data/privacy_policy_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyController extends GetxController {

  late final WebViewController controller;



  @override
  void onInit() {
    controller = WebViewController()..loadHtmlString( AppConstParams.htmlPrivacy,

    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
