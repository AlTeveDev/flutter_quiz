import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:yt1/constants.dart';
import 'package:yt1/controllers/question_controller.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: kBorderColor,
            width: 3,
          )
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              LayoutBuilder(builder: (context, constraints) => Container(
                width: constraints.maxWidth*controller.animation.value,
                decoration: BoxDecoration(
                  gradient: kPrimaryGradient,
                  borderRadius: BorderRadius.circular(50),
                ),
              )),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${(controller.animation.value*60).round()} Sec",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SvgPicture.network("https://github.com/abuanwar072/Quiz-App-Flutter/raw/master/assets/icons/clock.svg"),
                      ]
                  ),
                ),
              ),
            ],
           );
         },
      ),
    );
  }
}