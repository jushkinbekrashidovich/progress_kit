import 'package:get/get.dart';

import '../controllers/add_widget_controller.dart';

class AddWidgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWidgetController>(
      () => AddWidgetController(),
    );
  }
}
