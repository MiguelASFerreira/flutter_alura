import 'package:flutter/material.dart';
import 'package:flutter_alura/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required Widget child}) : super(child: child);

  final List<Task> taskList =  [
    Task(
      nomeDaTarefa: 'Aprender Flutter',
      foto: "assets/images/dash.png",
      dificuldade: 5,
    ),
    Task(
      nomeDaTarefa: 'Andar de Bicicleta',
      foto: "assets/images/bike.webp",
      dificuldade: 4,
    ),
    Task(
      nomeDaTarefa: 'Meditar',
      foto: "assets/images/meditar.jpeg",
      dificuldade: 2,
    ),
    Task(
      nomeDaTarefa: 'Ler',
      foto: "assets/images/livro.jpg",
      dificuldade: 1,
    ),
    Task(
      nomeDaTarefa: 'Jogar',
      foto: "assets/images/jogar.jpg",
      dificuldade: 2,
    ),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(nomeDaTarefa: name, foto: photo, dificuldade: difficulty));
  }


  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
