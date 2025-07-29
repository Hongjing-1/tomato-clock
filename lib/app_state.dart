import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _showMode = false; // Digital Mode 的狀態 (預設關閉)

  bool get showMode => _showMode;

  void toggleShowMode(bool value) {
    _showMode = value;
    notifyListeners(); // 通知所有使用 showMode 的畫面更新
  }
}
