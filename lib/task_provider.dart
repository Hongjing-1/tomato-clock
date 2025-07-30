import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<Map<String, String>> _tasks = [];
  String _currentTask = "Please select a task";

  List<Map<String, String>> get tasks => _tasks;
  String get currentTask => _currentTask;

  void addTask(String task, String work, String rest) {
    _tasks.add({'task': task, 'work': work, 'rest': rest});
    notifyListeners();
  }

  void editTask(int index, String task, String work, String rest) {
    _tasks[index] = {'task': task, 'work': work, 'rest': rest};
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void chooseTask(int index) {
    _currentTask = "'${_tasks[index]['task']}' in progress";
    notifyListeners();
  }
}
