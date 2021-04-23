import 'package:dev_quiz/core/app_text_styles.dart';
import 'package:dev_quiz/views/shared/widgets/progress_indicator/linear_progress_indicator_widget.dart';
import 'package:flutter/material.dart';

class QuestionIndicator extends StatelessWidget {
  final int currentPage;
  final int lenght;

  const QuestionIndicator(
      {Key? key, required this.currentPage, required this.lenght})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Questão ${currentPage}",
                style: AppTextStyles.body,
              ),
              Text(
                " de ${lenght}",
                style: AppTextStyles.body,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          LinearProgressIndicatorWidget(
            value: currentPage / lenght,
          ),
        ],
      ),
    );
  }
}
