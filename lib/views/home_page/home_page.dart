import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:dev_quiz/core/app_colors.dart';
import 'package:dev_quiz/controllers/home_controller.dart';
import 'package:dev_quiz/views/home_page/home_state.dart';
import 'package:dev_quiz/views/home_page/quiz_card/quiz_card_widget.dart';
import 'package:dev_quiz/views/home_page/widgets/appbar/app_bar_widget.dart';
import 'package:dev_quiz/views/home_page/widgets/level_button/level_button_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.fetchData();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success)
      return Scaffold(
        appBar: AppBarWidget(
          user: controller.user!,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 40, right: 20, bottom: 0, left: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                LevelButtonWidget(
                  label: "Fácil",
                ),
                LevelButtonWidget(
                  label: "Médio",
                ),
                LevelButtonWidget(
                  label: "Difícil",
                ),
                LevelButtonWidget(
                  label: "Perito",
                ),
              ]),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: kIsWeb ? 4 : 2,
                  children: controller.quizzes!
                      .map((e) => QuizCardWidget(
                            title: e.title,
                            percent: e.questionAnswered / e.questions.length,
                            completed:
                                "${e.questionAnswered} de ${e.questions.length}",
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
          ),
        ),
      );
    }
  }
}
