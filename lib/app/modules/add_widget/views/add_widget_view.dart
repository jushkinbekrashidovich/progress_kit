import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_kit/app/const/theme/app_colors.dart';
import 'package:progress_kit/app/custom_widgets/custom_text_field.dart';

import '../controllers/add_widget_controller.dart';

class AddWidgetView extends GetView<AddWidgetController> {
  const AddWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
             controller.saveProgress();
            },
            child: Text(
              "SAVE",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),
              CustomTextField(textEditingController: controller.titleController),
              const SizedBox(height: 14),

              // Description
              const Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  textEditingController: controller.descriptionController),
              const SizedBox(height: 14),

              // Date Range
              const Text(
                "Select time range",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: controller.selectDateRange,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Obx(
                        () => Text(
                      controller.dateRangeText.value.isEmpty
                          ? "Select"
                          : controller.dateRangeText.value,
                      style: TextStyle(
                        color: controller.dateRangeText.value.isEmpty
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Selected Dates
              Row(
                children: [
                  Expanded(
                    child: Obx(
                          () => TextField(
                        enabled: false,
                        controller: TextEditingController(
                          text: controller.startDate.value,
                        ),
                        decoration: _inputDecoration("Start Date"),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                          () => TextField(
                        enabled: false,
                        controller: TextEditingController(
                          text: controller.endDate.value,
                        ),
                        decoration: _inputDecoration("End Date"),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Color Picker
              const Text(
                "Select Color",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}
