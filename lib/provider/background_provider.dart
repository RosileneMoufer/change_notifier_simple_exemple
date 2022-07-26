import 'package:change_notifier_simple_example/provider/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackgroundStateProvider extends ChangeNotifier {
  Background background = Background();

  changeBackground(Color color) {
    background.backgroundColor = color;

    notifyListeners();
  }
}
