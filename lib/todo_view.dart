import 'package:flutter/material.dart';
import 'package:todo_app/api/todo_services.dart';


class TodoView extends StatefulWidget {

  final Todo todo;
  final void Function(String, bool) onStatusChanged;
  final void Function(String) onDeleted;
  const TodoView({Key? key, required this.todo, required this.onStatusChanged, required this.onDeleted}) : super(key: key);

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(color: Colors.white, blurRadius: 5)
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(value: isDone(), onChanged: (b) => widget.onStatusChanged(widget.todo.id, b!)),
              Text(
                  widget.todo.data?.label ?? "",
                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
              IconButton(onPressed: (){
                widget.onDeleted(widget.todo.id);
              }, icon: const Icon(Icons.delete, color: Colors.red,))
            ],
          ),
        ),
      ),
    );
  }

  bool isDone() {
    return (widget.todo.data?.status ?? Status.UNDONE) == Status.DONE;
  }
}
