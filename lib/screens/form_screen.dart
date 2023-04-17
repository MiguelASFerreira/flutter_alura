// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_alura/components/task.dart';
import 'package:flutter_alura/data/task_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({
    Key? key,
    required this.taskContent,
  }) : super(key: key);

  final BuildContext taskContent;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value) {
    if (value != null && value.isEmpty) {
      if (int.parse(value) > 5 || int.parse(value) < 1) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Nova Tarefa"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return "Insira o nome da Tarefa";
                        }
                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: "Name",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (difficultyValidator(value)) {
                          return "Insira a dificuldade da Tarefa";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: difficultyController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: "Difficulty",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (valueValidator(value)) {
                          return "Insira a URL da imagem da Tarefa";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          text;
                        });
                      },
                      keyboardType: TextInputType.url,
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: "Image",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageController.text,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image.asset("assets/images/nophoto.png");
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          TaskDao().save(Task(
                            nomeDaTarefa: nameController.text, 
                            foto: imageController.text, 
                            dificuldade: int.parse(difficultyController.text)
                          ));

                          const snackBar = SnackBar(
                            content: Text("Criando uma nova Tarefa!")                            
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.pop(context);
                        }
            
                      },
                      child: const Text("Adicionar"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
