import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:progress_kit/app/const/theme/app_colors.dart';
import 'package:progress_kit/app/custom_widgets/custom_progress_widget_details.dart';
import 'package:progress_kit/app/custom_widgets/custom_progresskit_widget.dart';
import 'package:progress_kit/app/routes/app_pages.dart';

import '../controllers/widget_details_controller.dart';

class WidgetDetailsView extends GetView<WidgetDetailsController> {
  const WidgetDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

appBar: AppBar(
  backgroundColor: AppColors.black,
  actions: [

PopupMenuButton<String>(
onSelected: (String value) {
        // Handle the selected option here
        if (value == 'edit') {

    } else if (value == 'delete') {

            showCupertinoDialog(
              context: Get.context!,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text("Delete Widget"),
                  content: Text("Are you sure you want to delete this widget? This action cannot be undone."),
                  actions: [
                    CupertinoDialogAction(
                      child: Text("Cancel", style: TextStyle(color: CupertinoColors.activeBlue)),
                      onPressed: () => Get.back() // Close dialog
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: Text("Delete"),
                      onPressed: () {
                       controller.deleteProgress(controller.indexWidget);
                       Get.offAllNamed(Routes.HOME) ; // Close dialog
                      },
                    ),
                  ],
                );
              },
            );
          }
    },
    itemBuilder: (BuildContext context) {
    return [
    PopupMenuItem<String>(
    value: 'edit',
    child: Text('Edit'),
    ),
    PopupMenuItem<String>(
    value: 'delete',
    child: Text('Delete', style: TextStyle(color: Colors.red),),
    ),
    ];
    },
    icon: Icon(Icons.more_vert, weight: 3),
    ),
    ],

    ),
      body: SingleChildScrollView(
        child: ProgressCardDetails(
            title: controller.title,
            startDate: controller.startDate,
            endDate: controller.endDate,
        
        ),
      ),
    );
  }
}
