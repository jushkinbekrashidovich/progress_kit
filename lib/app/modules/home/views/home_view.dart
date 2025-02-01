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


         Obx(()=>IconButton(
            onPressed: () {

              controller.isPercentage.value = !controller.isPercentage.value;


            },
            icon:  controller.isPercentage.value==false?
            Icon(CupertinoIcons.percent):Icon(CupertinoIcons.calendar)
          ),),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_WIDGET);
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
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
                  return
                    GestureDetector(
                    onTap: (){

                      Get.toNamed(Routes.WIDGET_DETAILS,
                        arguments: {
                          'index':index,
                          'title': progress.title,
                          'startdate': progress.startDate,  // Replace with actual date
                          'endDate': progress.endDate,    // Replace with actual date
                        },

                      );
                      print(index.toString());

                    },
                    child: Obx(() => ProgressCard(
                      title: progress.title,
                      startDate: progress.startDate,
                      endDate: progress.endDate,
                      isPercentage: controller.isPercentage.value, // ✅ Now inside Obx()
                    )),
                  );
                },
              ),
            ),
          SizedBox(height: 20,),
          ],
        );
      }),


      //   },
      // ),
    );
  }
}
