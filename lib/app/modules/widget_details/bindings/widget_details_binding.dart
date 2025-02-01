import 'package:get/get.dart';

import '../controllers/widget_details_controller.dart';

class WidgetDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WidgetDetailsController>(
      () => WidgetDetailsController(),
    );
  }
}
