import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TaskStorage {
  static Future<void> saveTask(String taskName, int workMinutes, int restMinutes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList("tasks") ?? [];

    Map<String, dynamic> newTask = {
      "task": taskName,
      "work": workMinutes.toString(),
      "rest": restMinutes.toString()
    };

    tasks.add(jsonEncode(newTask));
    await prefs.setStringList("tasks", tasks);
  }

  static Future<void> saveTasks(List<Map<String, String>> taskList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = taskList.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList("tasks", tasks);
  }

  static Future<List<Map<String, String>>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList("tasks") ?? [];

    List<Map<String, String>> parsedTasks = tasks.map((task) {
      Map<String, dynamic> decoded = jsonDecode(task);

      // 處理舊格式數據的轉換
      if (decoded.containsKey("workMinutes") && decoded.containsKey("restMinutes")) {
        return {
          "task": "Untitled Task",
          "work": decoded["workMinutes"].toString(),
          "rest": decoded["restMinutes"].toString()
        };
      }

      // 新格式數據
      return {
        "task": decoded["task"]?.toString() ?? "Untitled Task",
        "work": decoded["work"]?.toString() ?? "25",
        "rest": decoded["rest"]?.toString() ?? "5"
      };
    }).toList();

    return parsedTasks;
  }

  static Future<void> updateTask(int index, String taskName, int workMinutes, int restMinutes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList("tasks") ?? [];

    if (index >= 0 && index < tasks.length) {
      Map<String, dynamic> updatedTask = {
        "task": taskName,
        "work": workMinutes.toString(),
        "rest": restMinutes.toString()
      };

      tasks[index] = jsonEncode(updatedTask);
      await prefs.setStringList("tasks", tasks);
    }
  }

  static Future<void> deleteTask(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList("tasks") ?? [];

    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
      await prefs.setStringList("tasks", tasks);
    }
  }

  static Future<void> clearAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("tasks");
  }
}