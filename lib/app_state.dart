import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _showMode = false; // Digital Mode 的狀態 (預設關閉)

  bool get showMode => _showMode;

  void toggleShowMode(bool value) {
    _showMode = value;
    notifyListeners();
  } // 切換數字模式

  List<Color> backgroundGradient = [
    Colors.purple.shade400,
    Colors.blue.shade300,
  ]; // 預設背景漸層

  void setBackgroundGradient(List<Color> gradient) {
    backgroundGradient = gradient;
    notifyListeners();
  } // 更新背景漸層
}
