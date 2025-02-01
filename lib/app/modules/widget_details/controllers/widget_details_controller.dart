import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/progress_model.dart';

class WidgetDetailsController extends GetxController {
  late String title;
  late String startDate;
  late String endDate;



  final RxList<ProgressModel> progressList = <ProgressModel>[].obs;

  /// Delete a progress item
  Future<void> deleteProgress(int index) async {
    progressList.removeAt(index);
    await _saveToSharedPreferences(); // Update local storage after deletion
    Get.snackbar("Deleted", "Progress removed successfully!",
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> _saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> progressJsonList = progressList
        .map((progress) => jsonEncode(progress.toJson()))
        .toList();
    await prefs.setStringList('progressList', progressJsonList);
  }


  @override
  void onInit() {
    final arguments = Get.arguments;

    // Assign the values from the arguments to the variables
    title = arguments['title'];
    startDate = arguments['startdate'];
    endDate = arguments['endDate'];

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
