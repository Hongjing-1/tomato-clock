// import 'package:flutter/material.dart';
//
// class ClockPainter extends CustomPainter
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: Text('Pomodoro Timer')),
//     body: Center(
//       child: CustomPaint(
//         painter: ClockPainter(
//           isTimerRunning
//               ? 1 - (totalDurationInSeconds / ((workDuration + breakDuration) * 60))
//               : 0,
//           workDuration,
//           breakDuration,
//         ),
//         size: Size(300, 300),
//       ),
//     ),
//   );
// }
// }