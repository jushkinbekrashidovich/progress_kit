import 'dart:convert';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/progress_model.dart';

class AddWidgetController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxString startDate = ''.obs;
  final RxString endDate = ''.obs;
  final RxString dateRangeText = ''.obs;

  List<ProgressModel> progressList = [];

  Future<void> saveProgress() async {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        startDate.isNotEmpty &&
        endDate.isNotEmpty) {
      // Create a Progress object
      ProgressModel progress = ProgressModel(
        title: titleController.text,
        description: descriptionController.text,
        startDate: startDate.value,
        endDate: endDate.value,
      );

      // Save Progress to SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      progressList.add(progress);

      List<String> progressJsonList = progressList
          .map((progress) => jsonEncode(progress.toJson()))
          .toList();

      await prefs.setStringList('progressList', progressJsonList);

      // Reset inputs
      titleController.clear();
      descriptionController.clear();
      startDate.value = '';
      endDate.value = '';
      dateRangeText.value = '';

      Get.snackbar("Success", "Progress saved successfully!",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Please fill all fields before saving!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> loadProgress() async {
    // Retrieve Progress from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? progressJsonList = prefs.getStringList('progressList');

    if (progressJsonList != null) {
      progressList = progressJsonList
          .map((progressJson) =>
          ProgressModel.fromJson(jsonDecode(progressJson) as Map<String, dynamic>))
          .toList();
    }
  }

  void selectDateRange() {
    BottomPicker.range(
      pickerTitle: const Text(
        'Set date range',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      pickerDescription: const Text(
        'Please select a first date and an end date',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      minFirstDate: DateTime.now(),
      initialFirstDate: DateTime.now().add(const Duration(days: 1)),
      pickerTextStyle: const TextStyle(
        color: Colors.blue,
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
}