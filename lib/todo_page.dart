import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/api/todo_services.dart';

import 'package:todo_app/todo_view.dart';

class TodoPage extends StatefulWidget {
  final TodoServices todoServices;

  const TodoPage({Key? key, required this.todoServices}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> todos = [];

  StreamController<TodoData> todoStream = StreamController.broadcast();

  final TextEditingController _editingController = TextEditingController();

  bool hasLabel = false;

  @override
  void initState() {
    super.initState();

    widget.todoServices.todoEvents().listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Receive new event of type ${event.eventType}")));

      switch (event.eventType) {
        case EventType.Created:
          setState(() {
            todos.add(event.data!);
          });
          break;
        case EventType.Updated:
          var data = event.data!;
          setState(() {
            todos = todos.map((e) {
              if (e.id == data.id) {
                return data;
              }
              return e;
            }).toList();
          });
          break;
        case EventType.Deleted:
          setState(() {
            todos.removeWhere((todo) => todo.id == event.data!.id);
          });
          break;
        case EventType.Error:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${event.errorMessage}", style: const TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ));
          break;
      }
    });

    widget.todoServices.getAllTodos().then((result) {
      for (var todo in result) {
        setState(() {
          todos.add(todo);
        });
      }
    });

    _editingController.addListener(() {
      var label = _editingController.text;
      _editingController.value.copyWith(
        text: label,
        selection:
            TextSelection(baseOffset: label.length, extentOffset: label.length),
        composing: TextRange.empty,
      );

      setState(() {
        hasLabel = label.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO APP"),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.black87,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _editingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Todo label",
                    labelText: "Todo label",
                    suffixIcon: IconButton(
                        onPressed: saveTodo,
                        icon: Icon(Icons.send,
                            color: hasLabel ? Colors.green : Colors.grey))),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: todos
                    .map((todo) => TodoView(
                          todo: todo,
                          onStatusChanged: updateTodo,
                          onDeleted: deleteTodo,
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveTodo() {
    if (hasLabel) {
      var label = _editingController.text;
      widget.todoServices
          .createTodo(request: CreateTodoRequest(label: label))
          .then((value) {});
      _editingController.clear();
    }
  }

  updateTodo(String id, bool status) {
    widget.todoServices
        .updateTodo(
            id: id,
            request:
                UpdateTodoRequest(status: status ? Status.DONE : Status.UNDONE))
        .then((value) {});
  }

  deleteTodo(String id) {
    widget.todoServices.deleteTodo(id: id).then((value) {});
  }
}
