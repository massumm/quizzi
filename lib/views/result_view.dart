import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_task/res/app_color.dart';
import 'package:med_task/views/catagory_list_view.dart';
import 'package:med_task/views/questions_view.dart';

import '../res/image_assets.dart';
import '../utils/components/custom_btn.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String percentage = args['percentage'] ?? "0";

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(title: const Text("Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.congratesImage, height: 289),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: 200,
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                "Percentage: $percentage%",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            const Text("You've got a great foundation. Ready to try a different category?"),
            const SizedBox(height: 40),
            CustomButton(
              text: "Play Again",
              textColor: AppColors.whiteColor,
              onPressed: () {
                Get.offAll(CatagoryListView());
              },
              backgroundColor: AppColors.greenColor,
            ),
          ],
        ),
      ),
    );
  }

}
