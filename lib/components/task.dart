import 'package:flutter/material.dart';
import 'package:flutter_alura/data/task_dao.dart';
import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nomeDaTarefa;
  final String foto;
  final int dificuldade;


  Task({
    Key? key,
    required this.nomeDaTarefa,
    required this.foto,
    required this.dificuldade, 
  }) : super(key: key);

  int nivel = 0;
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  bool assetOrNetwork() {
    if (widget.foto.contains("http")) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue,
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork() ? Image.asset (
                          widget.foto,
                          fit: BoxFit.cover,
                        ) : Image.network(
                          widget.foto, 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nomeDaTarefa,
                            style: const TextStyle(
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Difficulty(
                          dificultyLevel: widget.dificuldade,
                         
                        )
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onLongPress: () {
                            showDialog(
                              barrierDismissible: true,
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                title: const Text("Deseja deletar a tarefa?"), 
                                icon: const Icon(Icons.delete),
                                content: Text("A tarefa é essa ${widget.nomeDaTarefa}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Não"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      TaskDao().delete(widget.nomeDaTarefa);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Sim"),
                                  ),
                                ],
                                
                              );
                              },
                            );
                          },
                          onPressed: () {
                            setState(() {
                              widget.nivel++;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(
                                Icons.arrow_drop_up,
                              ),
                              Text(
                                "UP",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Nível: ${widget.nivel}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

