import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:yt1/constants.dart';
import 'package:yt1/controllers/question_controller.dart';
import 'quiz_option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kDefaultPadding*2),
      ),
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding*2),
        child: Column(
          children: [
            Text(
              question.question,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
            ),
            SizedBox(height: kDefaultPadding/2),
            ...List.generate(
              question.answers.length,
              (index) => Option(
                index: index,
                text: question.answers[index],
                onPress: () {
                  _controller.checkAnswer(question, index);
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}