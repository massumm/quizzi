import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:med_task/views/question_config_view.dart';

import '../views/questions_view.dart';
import '../views/catagory_list_view.dart';
import '../views/result_view.dart';
import '../views/splash_view.dart';
import 'app_routes.dart';

class AppPages{
  static final pages = [
    GetPage(name: AppRoutes.SPLASH, page: () => SplashView()),
    GetPage(name: AppRoutes.HOME, page: () => CatagoryListView()),
    GetPage(name: AppRoutes.QUESTIONS, page: () => QuestionsView()),
    GetPage(name: AppRoutes.CONFIG, page: () => QuestionConfig()),
    GetPage(name: AppRoutes.RESULT, page: () => ResultScreen()),
    ];
}