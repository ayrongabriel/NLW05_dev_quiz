import 'dart:convert';

import 'package:dev_quiz/models/question_model.dart';

enum Level { facil, medio, dificil, perito }

extension LevelStringExt on String {
  Level get parse => {
        "facil": Level.facil,
        "medio": Level.medio,
        "dificil": Level.dificil,
        "perito": Level.perito,
      }[this]!;
}

extension LevelExt on Level {
  String get parse => {
        Level.facil: "facil",
        Level.medio: "medio",
        Level.dificil: "dificil",
        Level.perito: "perito",
      }[this]!;
}

class QuizModel {
  final List<QuestionModel> questions;
  final String title;
  final int questionAnswered;
  final String image;
  final Level level;

  QuizModel({
    required this.questions,
    required this.title,
    this.questionAnswered = 0,
    required this.image,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'questions': questions.map((x) => x.toMap()).toList(),
      'title': title,
      'questionAnswered': questionAnswered,
      'image': image,
      'level': level.parse,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
      title: map['title'],
      questionAnswered: map['questionAnswered'],
      image: map['image'],
      level: map['level'].toString().parse,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
