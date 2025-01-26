import 'dart:convert';

import 'package:get/get.dart';
import 'package:progress_kit/app/data/progress_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxList<ProgressModel> progressList = <ProgressModel>[].obs;
  RxString viewMode = 'days'.obs; // Default view mode.

  // Load progress entries from SharedPreferences
  Future<void> loadProgressEntries() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? progressJsonList = prefs.getStringList('progressList');
    if (progressJsonList != null) {
      progressList.value = progressJsonList
          .map((progressJson) =>
          ProgressModel.fromJson(jsonDecode(progressJson) as Map<String, dynamic>))
          .toList();
    }
  }

  // Toggle view mode
  void toggleViewMode() {
    List<String> modes = ['days', 'hours', 'weeks', 'months', 'years'];
    int currentIndex = modes.indexOf(viewMode.value);
    viewMode.value = modes[(currentIndex + 1) % modes.length];
  }

  @override
  void onInit() {
    super.onInit();
    loadProgressEntries(); // Load progress on initialization.
  }
}
