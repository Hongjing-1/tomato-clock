import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'task_provider.dart';
import 'clock.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late AudioPlayer _audioPlayer;

  Timer? _countdownTimer;

  int workDuration = 25;
  int breakDuration = 5;
  int totalDurationInSeconds = 1500;
  bool isTimerRunning = false;
  bool isMusicPlaying = false;
  bool isWorkMode = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalDurationInSeconds),
    );
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _countdownTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      totalDurationInSeconds = (workDuration + breakDuration) * 60;
      isTimerRunning = true;
      _animationController.duration = Duration(seconds: totalDurationInSeconds);
      _animationController.forward(from: 0.0);
    });

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (totalDurationInSeconds > 0) {
        setState(() {
          totalDurationInSeconds--;
          _updateTimerMode();
        });
      } else {
        _countdownTimer?.cancel();
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

  Future<void> _playMusic() async {
    await _audioPlayer.play(AssetSource('birds-339196.mp3'));
    setState(() {
      isMusicPlaying = true;
    });
  }

  Future<void> _stopMusic() async {
    await _audioPlayer.stop();
    setState(() {
      isMusicPlaying = false;
    });
  }

  void _refreshTimer() {
    _countdownTimer?.cancel();
    _animationController.reset();

    setState(() {
      totalDurationInSeconds = (workDuration + breakDuration) * 60;
      isTimerRunning = false;
      isWorkMode = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade400, Colors.blue.shade300],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                // 顯示當前選擇的任務
                TextButton(
                  onPressed: _chooseTaskDialog,
                  child: Text(taskProvider.currentTask, style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                Text(
                  isWorkMode ? 'Work Time' : 'Rest Time',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // 顯示計時模式 (數字 or 圓形鐘)
                appState.showMode
                    ? Text(
                  _formatTime(totalDurationInSeconds),
                  style: const TextStyle(fontSize: 64, color: Colors.white),
                )
                    : CustomPaint(
                  painter: ClockPainter(
                    isTimerRunning
                        ? 1 - (totalDurationInSeconds / ((workDuration + breakDuration) * 60))
                        : 0,
                    workDuration,
                    breakDuration,
                  ),
                  size: const Size(300, 300),
                ),

                const SizedBox(height: 12),
                // 音樂、開始/暫停、重置按鈕
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: isMusicPlaying ? _stopMusic : _playMusic,
                        icon: Icon(isMusicPlaying ? Icons.music_note_sharp : Icons.music_off_sharp),
                        iconSize: 42,
                      ),
                      IconButton(
                        onPressed: isTimerRunning ? _pauseTimer : _startTimer,
                        icon: Icon(isTimerRunning ? Icons.stop : Icons.play_arrow),
                        iconSize: 42,
                      ),
                      IconButton(
                        onPressed: _refreshTimer,
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Refresh Timer',
                        iconSize: 42,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 任務列表
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    elevation: 8,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Text(
                              "Task List",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: taskProvider.tasks.length,
                              itemBuilder: (context, index) {
                                final task = taskProvider.tasks[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(task['task']!),
                                      subtitle: Text("Work: ${task['work']} min, Rest: ${task['rest']} min"),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                                        onPressed: () => taskProvider.deleteTask(index),
                                      ),
                                    ),
                                    if (index < taskProvider.tasks.length - 1)
                                      const Divider(height: 1, color: Colors.grey),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _chooseTaskDialog() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Task"),
          content: SizedBox(
            height: 250,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return ListTile(
                  title: Text(task['task']!),
                  subtitle: Text("Work: ${task['work']} min, Rest: ${task['rest']} min"),
                  onTap: () {
                    taskProvider.chooseTask(index);
                    setState(() {
                      workDuration = int.parse(task['work']!);
                      breakDuration = int.parse(task['rest']!);
                      _refreshTimer();
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _updateTimerMode() {
    int workTimeInSeconds = workDuration * 60;
    int elapsedSeconds = ((workDuration + breakDuration) * 60) - totalDurationInSeconds;
    setState(() {
      isWorkMode = elapsedSeconds < workTimeInSeconds;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }
}
