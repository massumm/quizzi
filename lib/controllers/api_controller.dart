import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:med_task/res/app_urls.dart';
import '../models/catagory_model.dart';
import '../models/question_model.dart';


class ApiController extends GetxController {
  var categories = <Catagory>[].obs;
  var questions = <Questions>[].obs;

  var isLoading = false.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Fetch Categories
  Future<void> fetchCategories() async {
    isLoading.value = true;

    final response = await http.get(Uri.parse(AppUrls.categoriesUrl));
    print("Categories Response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List data = body['trivia_categories'];

      categories.value = data.map((e) => Catagory.fromJson(e)).toList();
    } else {
      print("Error fetching categories: ${response.statusCode}");
    }

    isLoading.value = false;
  }

  /// Fetch Questions
  Future<void> fetchQuestions(int categoryId, String difficulty, int amount) async {
    isLoading.value = true;

    final url = Uri.parse(
        "${AppUrls.questionsUrl}?amount=$amount&category=$categoryId&difficulty=$difficulty&type=multiple"
    );

print("Questions URL: $url");


    final response = await http.get(url);
    print("Questions Response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List data = body['results'];   // ✅ FIX: should be results

      if (data.isNotEmpty) {
        questions.value = data.map((e) => Questions.fromJson(e)).toList();
      } else {
        hasMore.value = false;
      }
    } else {
      print("Error fetching questions: ${response.statusCode}");
    }

    isLoading.value = false;
  }
}
