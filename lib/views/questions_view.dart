import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_task/routes/app_routes.dart';
import 'package:med_task/views/result_view.dart';
import '../controllers/api_controller.dart';
import '../models/question_model.dart';
import '../res/app_color.dart';
import '../utils/components/custom_btn.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  final ApiController controller = Get.put(ApiController());

  int currentIndex = 0;
  String? selectedAnswer;
  bool answered = false;
  int score = 0;

  late final int categoryId;
  late final int numQuestions;
  late final String difficulty;

  @override
  void initState() {
    super.initState();

    /// ✅ Get arguments from QuestionConfig
    final args = Get.arguments as Map<String, dynamic>;
    categoryId = args["categoryId"];
    numQuestions = args["numQuestions"];
    difficulty = args["difficulty"];

    print("Category ID: $categoryId");
    print("Number of Questions: $numQuestions");
    print("Difficulty: $difficulty");

    /// ✅ Fetch questions with dynamic values
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchQuestions(categoryId, difficulty, numQuestions);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.grayColor,
      appBar: AppBar(
        backgroundColor: AppColors.grayColor,
        automaticallyImplyLeading: false,
        title: Obx(
          () => Text(
            "${currentIndex + 1}/${controller.questions.length}",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Get.toNamed(AppRoutes.HOME),
          )
        ],
      ) ,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.questions.isEmpty) {
          return const Center(child: Text("No questions available"));
        }

        final Questions q = controller.questions[currentIndex];
        final options = q.allOptions;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0, // This adds the shadow
                color: AppColors.blackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    q.question,
                    style: const TextStyle(color:Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Options
              ...options.map((option) {
                final isCorrect = option == q.correctAnswer;
                final isSelected = selectedAnswer == option;

                Color? color;
                IconData? icon;

                if (answered) {
                  if (isSelected && isCorrect) {
                    color = Colors.green.shade200;
                    icon = Icons.check;
                  } else if (isSelected && !isCorrect) {
                    color = Colors.red.shade200;
                    icon = Icons.close;
                  }
                }

                return InkWell(
                  onTap: answered
                      ? null
                      : () {
                          setState(() {
                            selectedAnswer = option;
                            answered = true;

                            if (option == q.correctAnswer) {
                              score++;
                            }
                          });
                        },
                  child: Card(
                    color: color,
                    child: ListTile(
                      title: Text(option),
                      trailing: answered && isSelected
                          ? Icon(icon, color: Colors.black)
                          : null,
                      leading: Radio<String>(
                        value: option,
                        groupValue: selectedAnswer,
                        onChanged: null, // Logic is handled by InkWell's onTap
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),

              if (answered)
                CustomButton(
                  text: currentIndex < controller.questions.length - 1
                      ? "Next"
                      : "Finish",
                  textColor: AppColors.whiteColor,
                  onPressed: () {
                    if (currentIndex < controller.questions.length - 1) {
                      setState(() {
                        currentIndex++;
                        selectedAnswer = null;
                        answered = false;
                      });
                    }
                    else {
                      // Calculate percentage
                      final percentage = (score / controller.questions.length) * 100;

                      // Pass argument to ResultScreen
                      Get.toNamed(AppRoutes.RESULT, arguments: {"percentage": percentage.toStringAsFixed(1)});
                    }

                  },
                  backgroundColor: AppColors.greenColor,
                )
            ],
          ),
        );
      }),
    );
  }
}
