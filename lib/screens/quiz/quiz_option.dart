import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:yt1/constants.dart';
import 'package:yt1/controllers/question_controller.dart';

class Option extends StatelessWidget {
  const Option({
    super.key,
    this.text = "Text",
    this.index = 0,
    //this.color = Colors.black45,
    this.onPress,
  });

  final String text;
  final int index;
  //final Color color;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (qnController) {
        print("regenerate option ${index}");
        Color? getOptionColor() {
          if (qnController.isAnswered) {
            if (qnController.correctAns == index) {
              return Colors.green;
            } else if (qnController.incorrectAns == index) {
              return Colors.red;
            }
          }
          return null;
        }
        IconData? getOptionIcon() {
          if (qnController.isAnswered) {
            if (qnController.correctAns == index) {
              return Icons.check;
            } else if (qnController.incorrectAns == index) {
              return Icons.close;
            }
          }
          return null;
        }
        final color = getOptionColor();
        return InkWell(
          onTap: onPress,
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding*2),
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding),
              border: Border.all(color: color ?? Colors.black45),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index+1}. ${text}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: color ?? Colors.black45,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: color ?? Colors.black45),
                    color: color ?? Colors.transparent,
                  ),
                  child: Icon(
                    getOptionIcon(),
                    size: 16,
                  ),
                )
              ]
            )
          ),
        );
      },
    );
  }
}