import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:yt1/constants.dart';
import 'package:yt1/controllers/question_controller.dart';
import 'package:yt1/screens/quiz/quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final qnController = Get.put(QuestionController());
    final inController = TextEditingController();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 2),
                Text(
                  "Let's play quiz!!!!!",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Enter your information below",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Spacer(flex: 1),
                TextField(
                  controller: inController,
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                  ),
                ),
                Spacer(flex: 1),
                InkWell(
                  onTap: () {
                    qnController.name = inController.text;
                    qnController.play();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text("Continye to questions", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ]
      ),
    );
  }
}