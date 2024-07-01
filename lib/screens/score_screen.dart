import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:yt1/constants.dart';
import 'package:yt1/controllers/question_controller.dart';
import 'package:yt1/screens/quiz/quiz_screen.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    final qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
          children: [
            SvgPicture.asset(
              "assets/bg.svg",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(flex: 3),
                  Text(
                    "Score",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    qnController.name != "" ? "${qnController.name}, your score is: " : "Your score is:",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Spacer(flex: 1),
                  Text(
                    "${qnController.correctAnswers}/${qnController.questions.length}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 100),
                  ),
                  Spacer(flex: 1),
                  InkWell(
                    onTap: () {
                      qnController.replay();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text("Replay", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
          ]
      ),
    );
  }
}