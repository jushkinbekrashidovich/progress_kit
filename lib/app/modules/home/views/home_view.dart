import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_kit/app/routes/app_pages.dart';
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
            // Navigate to settings or implement settings functionality.
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
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.progressList.length,
          itemBuilder: (context, index) {
            final progress = controller.progressList[index];
            return _buildProgressCard(progress);
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

  Widget _buildProgressCard(progress) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              progress.title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "${_calculateTimeLeft(progress)} left",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 16),
            _buildDotGrid(progress),
          ],
        ),
      ),
    );
  }

  String _calculateTimeLeft(progress) {
    DateTime endDate = DateTime.parse(progress.endDate);
    DateTime now = DateTime.now();
    Duration diff = endDate.difference(now);

    switch (controller.viewMode.value) {
      case 'hours':
        return "${diff.inHours} hours";
      case 'weeks':
        return "${(diff.inDays / 7).ceil()} weeks";
      case 'months':
        return "${(diff.inDays / 30).ceil()} months";
      case 'years':
        return "${(diff.inDays / 365).ceil()} years";
      default:
        return "${diff.inDays} days";
    }
  }

  Widget _buildDotGrid(progress) {
    int dotsCount;
    DateTime endDate = DateTime.parse(progress.endDate);
    DateTime now = DateTime.now();
    Duration diff = endDate.difference(now);

    switch (controller.viewMode.value) {
      case 'hours':
        dotsCount = diff.inHours;
        break;
      case 'weeks':
        dotsCount = (diff.inDays / 7).ceil();
        break;
      case 'months':
        dotsCount = (diff.inDays / 30).ceil();
        break;
      case 'years':
        dotsCount = (diff.inDays / 365).ceil();
        break;
      default:
        dotsCount = diff.inDays;
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List.generate(
        dotsCount > 200 ? 200 : dotsCount, // Limit the dots to 200 for performance.
            (index) => Icon(
          Icons.circle,
          size: 8,
          color: index < dotsCount * 0.93
              ? Colors.white
              : Colors.grey.shade700, // Filled and unfilled dots based on completion.
        ),
      ),
    );
  }
}
