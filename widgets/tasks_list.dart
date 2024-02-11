import 'package:app/widgets/task._list.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_tts/flutter_tts.dart';

import '../models/task_data.dart';

class TasksList extends StatefulWidget {
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage("en-US");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
            itemCount: taskData.tasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                isChecked: taskData.tasks[index].isDone,
                taskTitle: taskData.tasks[index].name,
                CheckboxChange: (newvalue) {
                  String text = taskData.tasks[index].name;
                  flutterTts.speak(text);
                  taskData.updateTask(taskData.tasks[index]);
                },
                listTileDelete: () {
                  taskData.deleteTask(taskData.tasks[index]);
                },
              );
            });
           
      },
    );
  }
}
