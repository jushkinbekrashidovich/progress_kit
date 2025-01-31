import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:progress_kit/app/routes/app_pages.dart';

import '../../../const/theme/app_colors.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Settings',style: GoogleFonts.inconsolata(fontSize: 16, color: AppColors.white),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Subscription Section
          InkWell(
            onTap: (){
              Get.toNamed(Routes.PAYWALL);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(8),
              ),

              padding: const EdgeInsets.all(12.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                   SizedBox(width: 10,),
                   Text(
                    'Subscribe to ProgressKit Pro\nunlimited widgets, more features',
                    style: GoogleFonts.inconsolata(fontSize: 13),
                  ),

                ],
              ),
            ),
          ),
          // General Section

          SizedBox(height: 15,),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.black
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.circle, color: Colors.white, size: 9,),
                  title:  Text('Rate the app',
             style: GoogleFonts.inconsolata(fontSize: 14, color: AppColors.white),),
                  onTap: () {
                    // Handle Rate the App
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: AppColors.white,size: 14,),
                ),
                ListTile(
                  leading: const Icon(Icons.circle, color: Colors.white, size: 9,),
                  title:  Text('Privacy Policy',
                    style: GoogleFonts.inconsolata(fontSize: 14, color: AppColors.white),),
                  onTap: () {
                    // Handle Rate the App
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: AppColors.white,size: 14,),
                ),
                ListTile(
                  leading: const Icon(Icons.circle, color: Colors.white, size: 9,),
                  title:  Text('Feedback',
                    style: GoogleFonts.inconsolata(fontSize: 14, color: AppColors.white),),
                  onTap: () {
                    // Handle Rate the App
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: AppColors.white,size: 14,),
                ),
                ListTile(
                  leading: const Icon(Icons.circle, color: Colors.white, size: 9,),
                  title:  Text('Request a feature',
                    style: GoogleFonts.inconsolata(fontSize: 14, color: AppColors.white),),
                  onTap: () {

                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: AppColors.white,size: 14,),
                ),

              ],
            ),
          ),
         Text("Version 1.0.0"),
        ],
      ),
    );
  }
}