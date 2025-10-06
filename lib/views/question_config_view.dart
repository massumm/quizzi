import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_task/routes/app_routes.dart';

import '../res/app_color.dart';
import '../res/image_assets.dart';
import '../utils/components/custom_btn.dart';

class QuestionConfig extends StatefulWidget {
  const QuestionConfig({Key? key}) : super(key: key);

  @override
  _QuestionConfigState createState() => _QuestionConfigState();
}

class _QuestionConfigState extends State<QuestionConfig> {
  late final category;
  double numberOfQuestions = 10; // default
  String difficulty = "Any Difficulty";

  final List<String> difficulties = [
    "Any Difficulty",
    "easy",
    "medium",
    "hard",
  ];

  @override
  void initState() {
    super.initState();
    category = Get.arguments; // get category from previous screen

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image (your config illustration)
            Image.asset(ImageAssets.configImage, height: 150),

            const SizedBox(height: 20),
            Text("Quizzical", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Colors.black)),
            const Text("Configuration", style: TextStyle(color: Colors.black)),

            const SizedBox(height: 40,),

            // Number of Questions
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Number of Questions",style: TextStyle(color: Colors.black))),
            Text("Select 1-50",style: TextStyle(color: Colors.black)),
            Slider(
              value: numberOfQuestions,
              min: 1,
              max: 50,
              divisions: 49,
              label: numberOfQuestions.round().toString(),
              onChanged: (value) {
                setState(() {
                  numberOfQuestions = value;
                });
              },
            ),
            Text("${numberOfQuestions.round()}",style: TextStyle(color: Colors.black)),

            const SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Difficulty Level",style: TextStyle(color: Colors.black))),
            // Difficulty Dropdown
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              dropdownColor: AppColors.whiteColor,
              value: difficulty,
              items: difficulties
                  .map((d) => DropdownMenuItem(value: d, child: Text(d,style:TextStyle(color: AppColors.blackColor),)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  difficulty = val!;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 30),

            // Start Button
            CustomButton(
              text: "START",
              textColor: AppColors.blackColor,
              border: BorderSide(
                color: AppColors.blackColor,
                width: 2,
              ),
              onPressed: () {
                Get.toNamed(
                  AppRoutes.QUESTIONS,
                  arguments: {
                    "categoryId": category.id,
                    "numQuestions": numberOfQuestions.round(),
                    "difficulty": difficulty,
                  },
                );
              },
              backgroundColor: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
