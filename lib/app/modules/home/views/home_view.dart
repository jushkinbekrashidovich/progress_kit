import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_kit/app/routes/app_pages.dart';
import '../../../custom_widgets/custom_progresskit_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProgressKit'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {

          },
          icon: const Icon(CupertinoIcons.settings),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_WIDGET);
            },
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
      body: Obx(() {
        if (controller.progressList.isEmpty) {
          return const Center(
            child: Text(
              'No progress entries yet!',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        if (controller.progressList.isEmpty) {
          return const Center(
            child: Text(
              'No progress entries yet!',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.progressList.length,
          itemBuilder: (context, index) {
            final progress = controller.progressList[index];
            return ProgressCard(
              title: progress.title,
              endDate: progress.endDate,
              startDate: progress.startDate,
            );
          },

        );
      }),


      bottomSheet: BottomSheet(
        onClosing: () {}, // Keep it as is per your request.
        builder: (context) {
          return Container(
            height: 60,
            color: Colors.grey[300],
            child: Center(
              child: TextButton(
                onPressed: controller.toggleViewMode,
                child: Obx(() => Text(
                  'Switch View: ${controller.viewMode.value.capitalizeFirst}',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                )),
              ),
            ),
          );
        },
      ),
    );
  }

}
