import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'clock.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> with SingleTickerProviderStateMixin {
  bool isTimerRunning = false;
  int totalDurationInSeconds = 1500; // 25 分鐘
  int workDuration = 25;
  int breakDuration = 5;

  late AnimationController _animationController;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalDurationInSeconds),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });

    _animationController.forward(from: 0.0);

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        totalDurationInSeconds--;
      });

      if (totalDurationInSeconds <= 0) {
        timer.cancel();
        setState(() {
          isTimerRunning = false;
        });
      }
    });
  }

  void _pauseTimer() {
    _countdownTimer?.cancel();
    _animationController.stop();
    setState(() {
      isTimerRunning = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    double progress = isTimerRunning
        ? 1 - (totalDurationInSeconds / ((workDuration + breakDuration) * 60))
        : 0;

    return Scaffold(
      appBar: AppBar(title: Text('Clock Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: ClockPainter(progress, workDuration, breakDuration),
              size: Size(300, 300),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: startTimer,
              child: Text('Start'),
            ),
            ElevatedButton(
              onPressed: _pauseTimer,
              child: Text('stop'),
            )
          ],
        ),
      )
    );
  }
}
