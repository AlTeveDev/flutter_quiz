import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:yt1/constants.dart';
import 'package:yt1/controllers/question_controller.dart';
import 'progress_bar.dart';
import 'question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: controller.nextQuestion,
              child: Text(
                "Skip",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            SvgPicture.asset(
              "assets/bg.svg",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: ProgressBar(),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text.rich(
                        TextSpan(
                          text: "Question ${controller.currentPage+1}",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white38),
                          children: [
                            TextSpan(
                                text: "/${controller.questions.length}",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white38),
                            ),
                          ]
                        ),
                      ),
                  ),
                  const Divider(thickness: 1.5),
                  const SizedBox(height: kDefaultPadding),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (int page) {
                        setState(() {
                          currentQuestion = page;
                        });
                      },
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      itemCount: controller.questions.length,

                      itemBuilder: (context, index) => QuestionCard(
                        question: controller.questions[index],
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}