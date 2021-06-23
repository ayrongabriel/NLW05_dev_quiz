import 'package:dev_quiz/controllers/challenge_controller.dart';
import 'package:dev_quiz/models/question_model.dart';
import 'package:dev_quiz/views/challenge/next_button/next_button.dart';
import 'package:dev_quiz/views/challenge/widgets/question_indication/question_indicator.dart';
import 'package:dev_quiz/views/challenge/widgets/quiz/quiz_widget.dart';
import 'package:dev_quiz/views/result/result_page.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  const ChallengePage({Key? key, required this.questions, required this.title})
      : super(key: key);
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    //   controller.currentPageNotifier.addListener(() {
    //     setState(() {});
    //   });
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
  }

  _nextPage() {
    if (controller.currentPage < widget.questions.length)
      pageController.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.linear);
  }

  void onSelected(bool value) {
    if (value) controller.qtdAwnserRight++;
    _nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(108),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ValueListenableBuilder<int>(
                      valueListenable: controller.currentPageNotifier,
                      builder: (context, value, _) => QuestionIndicator(
                            currentPage: value,
                            lenght: widget.questions.length,
                          )),
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          // physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: widget.questions
              .map((e) => QuizWidget(
                    title: e.title,
                    questions: e,
                    onSelected: onSelected,
                  ))
              .toList(),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ValueListenableBuilder<int>(
              valueListenable: controller.currentPageNotifier,
              builder: (context, value, _) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (value < widget.questions.length)
                    Expanded(
                      child: NextButtonWidget.white(
                        label: "Pular",
                        onTap: _nextPage,
                      ),
                    ),
                  // if (value == widget.questions.length)
                  //   SizedBox(
                  //     width: 10,
                  //   ),
                  if (value == widget.questions.length)
                    Expanded(
                        child: NextButtonWidget.gree(
                      label: "Confirmar",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => ResultPage(
                                      title: widget.title,
                                      lenght: widget.questions.length,
                                      result: controller.qtdAwnserRight,
                                    )));
                      },
                    ))
                ],
              ),
            )),
      ),
    );
  }
}
