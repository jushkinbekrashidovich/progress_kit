import 'dart:convert';

import 'package:get/get.dart';
import 'package:progress_kit/app/data/progress_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {






  // Observable progress list
  RxList<ProgressModel> progressList = <ProgressModel>[].obs;

  // Observable view mode
  RxString viewMode = 'days'.obs;

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

  // Save the progress list back to SharedPreferences
  Future<void> saveProgressEntries() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> progressJsonList = progressList
        .map((progress) => jsonEncode(progress.toJson()))
        .toList();
    await prefs.setStringList('progressList', progressJsonList);
  }

  // Toggle view mode for progress entries
  void toggleViewMode() {
    List<String> modes = ['days', 'hours', 'weeks', 'months', 'years'];
    int currentIndex = modes.indexOf(viewMode.value);
    viewMode.value = modes[(currentIndex + 1) % modes.length];
  }

  // Add a new progress entry and save it
  Future<void> addProgress(ProgressModel progress) async {
    progressList.add(progress);
    await saveProgressEntries();
  }

  // Remove a progress entry and save changes
  Future<void> removeProgress(int index) async {
    progressList.removeAt(index);
    await saveProgressEntries();
  }

  @override
  void onInit() {
    super.onInit();

    loadProgressEntries();
  }
}
