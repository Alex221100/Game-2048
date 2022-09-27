import 'package:flutter/material.dart';

class ScoreStructure {
  int currentScore = 0;
  int bestScore = 0;

  setCurrentScore(int newValue) {
    currentScore = newValue;
  }

  setBestScore(int newValue) {
    if (newValue > bestScore) {
      bestScore = newValue;
    }
    currentScore = 0;
  }
}

class InheritedScore extends InheritedWidget {
  final ScoreStructure scoreStructure = ScoreStructure();

  InheritedScore({Key? key, required child})
      : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedScore oldWidget) =>
      oldWidget.scoreStructure.currentScore != scoreStructure.currentScore ||
      oldWidget.scoreStructure.bestScore != scoreStructure.bestScore;

  static InheritedScore of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedScore>()!;
  }

  setCurrentScore(int newValue) {
    scoreStructure.setCurrentScore(newValue);
  }

  setBestScore(int newValue) {
    scoreStructure.setBestScore(newValue);
  }
}
