import 'package:flutter/material.dart';
import 'package:flutter_alura/components/task.dart';
import 'package:flutter_alura/data/task_dao.dart';
import 'package:flutter_alura/data/task_inherited.dart';
import 'package:flutter_alura/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          actions: [
              IconButton(
              onPressed: () {
                setState(() {});
              }, 
              icon: const Icon(Icons.refresh),
            )
          ],
          title: const Text("Tarefas"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 70), 
          child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: ((context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text("Carregando"),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text("Carregando"),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text("Carregando"),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if(items.isNotEmpty) {
                      return ListView.builder(
                      itemCount: items.length,
                      itemBuilder:(BuildContext context, int index) {
                        final Task tarefa = items[index];
                        return tarefa;
                      },
                    );
                    }
                    return Center(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.error_outline,
                            size: 128,
                          ),
                          Text(
                            "Não há nenhuma Tarefa", 
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                        ],
                        
                      ),
                    );
                  } 
                  return const Text("Erro ao carregar as Tarefas");
                  break;
              }
            })
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (contextNew) => FormScreen(taskContent: context))).then((value) => setState(() {
              print("Recarregando a tela inicial");
            }));
          },
          child: const Icon(Icons.add),
        ),
        );
      
  }
}