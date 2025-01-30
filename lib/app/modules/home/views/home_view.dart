import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_kit/app/routes/app_pages.dart';
import '../../../const/theme/app_colors.dart';
import '../../../custom_widgets/custom_progresskit_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('ProgressKit',style: GoogleFonts.inconsolata(fontSize: 17.5, color: AppColors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.toNamed(Routes.SETTINGS);
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
          return Center(
            child: Text(
              'No progress entries yet!',
                style: GoogleFonts.inconsolata(fontSize: 20, color: AppColors.white),
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: controller.progressList.length,
                itemBuilder: (context, index) {
                  final progress = controller.progressList[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      controller.removeProgress(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Progress entry removed")),
                      );
                    },
                    child: ProgressCard(
                      title: progress.title,
                      startDate: progress.startDate,
                      endDate: progress.endDate,
                    ),
                  );
                },
              ),
            ),
          SizedBox(height: 20,),
          ],
        );
      }),

      bottomSheet: BottomSheet(
        onClosing: () {},
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
         );}),
      //   },
      // ),
    );
  }
}
