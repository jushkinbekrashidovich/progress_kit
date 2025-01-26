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
        leading: IconButton(onPressed: (){
          
        }, icon: Icon(CupertinoIcons.settings)
        ),
        actions: [
          IconButton(onPressed: (){
            Get.toNamed(Routes.ADD_WIDGET);
            
          }, icon: Icon(CupertinoIcons.add_circled))

        ],
      ),
      
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
