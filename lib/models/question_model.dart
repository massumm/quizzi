class Questions {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Questions({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }

  /// ✅ Return shuffled options (correct + incorrect)
  List<String> get allOptions {
    final options = [...incorrectAnswers, correctAnswer];
    options.shuffle();
    return options;
  }
}
