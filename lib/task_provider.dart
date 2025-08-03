import 'package:flutter/material.dart';
import 'package:untitled4/task%20storage.dart';


class TaskProvider extends ChangeNotifier {

  List<Map<String, String>> _tasks = [];
  String _currentTask = "No Task Selected";

  List<Map<String, String>> get tasks => _tasks;
  String get currentTask => _currentTask;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 初始化時載入任務
  TaskProvider() {
    loadTasks();
  }

  void addTask(Map<String, String> task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(int index, Map<String, String> task) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void chooseTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _currentTask = _tasks[index]['task']!;
      notifyListeners();
    }
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await TaskStorage.loadTasks();
    } catch (e) {
      print('Error loading tasks: $e');
      _tasks = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearCurrentTask() {
    _currentTask = "No Task Selected";
    notifyListeners();
  }

  Future<void> clearAllTasks() async {
    try {
      // 保存舊任務列表以備回滾
      List<Map<String, String>> oldTasks = List.from(_tasks);

      // 先清空本地列表
      _tasks.clear();
      _currentTask = "No Task Selected";
      notifyListeners();

      // 然後清空存儲
      await TaskStorage.clearAllTasks();
    } catch (e) {
      print('Error clearing tasks: $e');
      rethrow;
    }
  }

  // 重新載入任務（用於手動刷新）
  Future<void> refreshTasks() async {
    await loadTasks();
  }
}