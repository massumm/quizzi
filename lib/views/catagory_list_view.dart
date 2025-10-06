import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_task/utils/common_header.dart';
import '../controllers/api_controller.dart';
import '../res/app_color.dart';
import '../routes/app_routes.dart';

class CatagoryListView extends StatelessWidget {
  final ApiController controller = Get.put(ApiController());

  CatagoryListView({super.key});

  final List<Color> cardColors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.red.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    controller.fetchCategories();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() {
        if (controller.isLoading.value && controller.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quizzical',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24, // Adjust size as needed
                      ),
                    ),
                    Text(
                      'choose a category to focus on:',
                      style: TextStyle(fontSize: 16,color: Colors.black,), // Adjust size as needed
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0, // to make it square
                ),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  final color = cardColors[index % cardColors.length];
                  return Card(
                    color: color,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () => Get.toNamed(AppRoutes.CONFIG, arguments: category),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
