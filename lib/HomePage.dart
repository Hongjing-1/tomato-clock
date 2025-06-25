import 'dart:async';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  bool isTimerRunning = false;
  int totalDurationInSeconds = 1500; // 25分鐘
  int workDuration = 25; // 單位：分鐘
  int breakDuration = 5; // 單位：分鐘

  late AnimationController _animationController;
  Timer? _countdownTimer;




  // TimePage
  // DataPage

  // 初始化資源
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalDurationInSeconds),
    );
  }

  // 釋放資源
  @override
  void dispose() {
    _animationController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}