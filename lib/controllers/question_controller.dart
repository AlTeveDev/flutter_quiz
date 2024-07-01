import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yt1/screens/quiz/quiz_screen.dart';

import 'package:yt1/screens/score_screen.dart';

class Question {
  Question({required this.question, required this.answers, required this.correctAnswer});

  String question;
  List<String> answers;
  int correctAnswer;
}

class QuestionController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  Animation get animation => _animation;

  PageController _pageController = PageController();
  PageController get pageController => _pageController;

  late List<Question> _questions = [];
  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAns = -1;
  int get correctAns => _correctAns;

  int _incorrectAns = -1;
  int get incorrectAns => _incorrectAns;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  int _correctAnswers = 0;
  int get correctAnswers => _correctAnswers;

  String name = "";

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  @override
  void onInit() async {
    _animationController = AnimationController(duration: Duration(seconds: 5), vsync: this);
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        update();
      });
    // _animationController.forward().whenComplete(nextQuestion);

    final questionsString = await rootBundle.loadString("assets/questions.json");
    final data = jsonDecode(questionsString) as List<dynamic>;
    _questions = data.map((question) => Question(
        question: question["question"],
        answers: question["options"].map<String>((ans) => ans as String).toList(),
        correctAnswer: question["answer_index"])
    ).toList();

    super.onInit();
  }

  void checkAnswer(Question question, int answer) {
    _isAnswered = true;
    _correctAns = question.correctAnswer;
    if (answer != question.correctAnswer) {
      _incorrectAns = answer;
    } else {
      _correctAnswers++;
      _incorrectAns = -1;
    }
    update();

    _animationController.stop();
    Future.delayed(Duration(seconds: 1), nextQuestion);
  }

  void nextQuestion() {
    _isAnswered = false;
    _correctAns = -1;
    _incorrectAns = -1;
    _currentPage++;
    if (_currentPage == questions.length) {
      Get.to(() => ScoreScreen());
    } else {
      pageController.nextPage(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease
      );
      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    }
  }

  void play() {
    Get.off(() => QuizScreen());
    _animationController.forward().whenComplete(nextQuestion);
  }

  void replay() {
    _isAnswered = false;
    _correctAns = -1;
    _incorrectAns = -1;
    _currentPage = 0;
    _correctAnswers = 0;
    Get.back();
    pageController.jumpToPage(0);
    _animationController.reset();
    _animationController.forward().whenComplete(nextQuestion);
  }
}