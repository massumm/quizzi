import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_task/res/image_assets.dart';
import 'package:med_task/utils/components/custom_textview.dart';

import '../res/app_color.dart';
import '../utils/components/custom_btn.dart';
import 'catagory_list_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.splashbroImage,
               // Make sure you have this image in your assets folder
              height: screenHeight * 0.3,
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              "Quizzcall",
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.06),
            CustomButton(
              text: "Get Started",
              textColor: AppColors.whiteColor,
              onPressed: () {
                Get.offAll(CatagoryListView());
              },
              backgroundColor: AppColors.greenColor,
            )
          ],
        ),
      ),
    );
  }
}
