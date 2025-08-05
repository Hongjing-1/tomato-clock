import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/task_provider.dart';

class Taskpage extends StatefulWidget {
  const Taskpage({super.key});

  @override
  State<Taskpage> createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  late TextEditingController taskController;
  late TextEditingController workController;
  late TextEditingController restController;

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController();
    workController = TextEditingController();
    restController = TextEditingController();
  }

  @override
  void dispose() {
    taskController.dispose();
    workController.dispose();
    restController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/space.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Task List',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: taskProvider.tasks.isEmpty // 使用 taskProvider.tasks
                      ? const Center(
                    child: Text(
                      'No tasks yet\nTap + to add a task',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: taskProvider.tasks.length, // 使用 taskProvider.tasks
                    itemBuilder: (context, index) {
                      final task = taskProvider.tasks[index]; // 使用 taskProvider.tasks
                      return GestureDetector(
                        onTap: () => _editTaskDialog(index),
                        onLongPress: () => _confirmDelete(index),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          color: Colors.white70,
                          child: ListTile(
                            title: Text(task['task']!),
                            subtitle: Text(
                              'Rest: ${task['rest']} min\nWork: ${task['work']} min',
                            ),
                            trailing: PopupMenuButton(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  _editTaskDialog(index);
                                } else if (value == 'delete') {
                                  _confirmDelete(index);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(width: 8),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Delete', style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskDialog,
        tooltip: 'Add Task',
        backgroundColor: Colors.purple.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTaskDialog() {
    taskController.clear();
    workController.clear();
    restController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Task"),
          content: _buildInputFields(),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final task = taskController.text;
                final work = workController.text;
                final rest = restController.text;

                if (task.isNotEmpty&&work.isNotEmpty && rest.isNotEmpty) {
                  final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                  taskProvider.addTask({
                    'task': task,
                    'work': work,
                    'rest': rest,
                  });
                }

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _editTaskDialog(int index) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    // 填入原本的值，使用 taskProvider.tasks
    taskController.text = taskProvider.tasks[index]['task']!;
    workController.text = taskProvider.tasks[index]['work']!;
    restController.text = taskProvider.tasks[index]['rest']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: _buildInputFields(),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final task = taskController.text;
                final work = workController.text;
                final rest = restController.text;

                if (task.isNotEmpty && work.isNotEmpty && rest.isNotEmpty) {
                  final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                  taskProvider.updateTask(index, {
                    'task': task,
                    'work': work,
                    'rest': rest,
                  });
                }

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                taskProvider.deleteTask(index);
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputFields() {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          // 任務名稱
          TextField(
            controller: taskController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Task Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // 工作時間
          TextField(
            controller: workController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Work Time (min)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // 休息時間
          TextField(
            controller: restController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Rest Time (min)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
