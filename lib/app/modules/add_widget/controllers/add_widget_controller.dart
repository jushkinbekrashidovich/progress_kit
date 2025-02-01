import 'dart:convert';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_kit/app/const/theme/app_colors.dart';
import 'package:progress_kit/app/modules/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/progress_model.dart';

class AddWidgetController extends GetxController {
  // Controllers for title and description
  final TextEditingController titleController = TextEditingController();


  // Date range observables
  final RxString startDate = ''.obs;
  final RxString endDate = ''.obs;
  final RxString dateRangeText = ''.obs;

  // Reactive list to store all progress entries
  final RxList<ProgressModel> progressList = <ProgressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProgress(); // Load progress list when the controller is initialized
  }

  /// Save progress to the local list and SharedPreferences
  Future<void> saveProgress() async {
    if (titleController.text.isNotEmpty &&

        startDate.isNotEmpty &&
        endDate.isNotEmpty) {
      // Create a ProgressModel instance
      ProgressModel progress = ProgressModel(
        title: titleController.text,

        startDate: startDate.value,
        endDate: endDate.value,
      );

      // Add to the progress list and save to SharedPreferences
      progressList.add(progress);
      await _saveToSharedPreferences();

      // Clear input fields
      titleController.clear();

      startDate.value = '';
      endDate.value = '';
      dateRangeText.value = '';

      Get.snackbar("Success", "Progress saved successfully!",
          snackPosition: SnackPosition.BOTTOM);
      Get.find<HomeController>().loadProgressEntries();

    } else {
      Get.snackbar("Error", "Please fill all fields before saving!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Load progress list from SharedPreferences
  Future<void> loadProgress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? progressJsonList = prefs.getStringList('progressList');

    if (progressJsonList != null) {
      progressList.value = progressJsonList
          .map((progressJson) => ProgressModel.fromJson(jsonDecode(progressJson)))
          .toList();
    }
  }

  /// Save the progress list to SharedPreferences
  Future<void> _saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> progressJsonList = progressList
        .map((progress) => jsonEncode(progress.toJson()))
        .toList();
    await prefs.setStringList('progressList', progressJsonList);
  }


  /// Select date range using BottomPicker
  void selectDateRange() {
    BottomPicker.range(
      dismissable: true,
      pickerTitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Text(
          'Select a start and end date to track progress',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black,
          ),
        ),
      ),

      dateOrder: DatePickerDateOrder.dmy,
      minFirstDate: DateTime(1970),
      initialFirstDate: DateTime.now(),
      maxSecondDate: DateTime(2200),
      maxFirstDate: DateTime(2200),
      minSecondDate: DateTime.now(),
      buttonSingleColor: AppColors.black,
      pickerTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      onRangeDateSubmitPressed: (firstDate, secondDate) {
        startDate.value = firstDate.toString().split(' ')[0];
        endDate.value = secondDate.toString().split(' ')[0];
        dateRangeText.value = "$startDate - $endDate";
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(Get.context!);
  }

  @override
  void onClose() {
    titleController.dispose();  // Dispose text controllers

    super.onClose();
  }
}
