import 'package:dev_quiz/core/app_text_styles.dart';
import 'package:dev_quiz/models/awnser_model.dart';
import 'package:dev_quiz/models/question_model.dart';
import 'package:dev_quiz/views/challenge/awnser/awnser_widgwt.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatefulWidget {
  final String title;
  final QuestionModel questions;
  final ValueChanged<bool> onSelected;

  const QuizWidget(
      {Key? key,
      required this.title,
      required this.questions,
      required this.onSelected})
      : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int indexSeleted = -1;

  AwnserModel awnser(int index) => widget.questions.awnsers[index];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.questions.title,
              style: AppTextStyles.heading,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          for (var i = 0; i < widget.questions.awnsers.length; i++)
            AwnserWidget(
              awnser: awnser(i),
              isSelected: indexSeleted == i,
              disabled: indexSeleted != -1,
              onTap: (value) {
                setState(() {
                  indexSeleted = i;
                  Future.delayed(Duration(seconds: 1))
                      .then((_) => widget.onSelected(value));
                });
              },
            ),
        ],
      ),
    );
  }
}
