import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onToggleCompleted;
  final VoidCallback? onDelete;

  const TodoListItem({
    super.key,
    required this.todo,
    this.onToggleCompleted,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (_) {
          onToggleCompleted?.call();
        },
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration:
              todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
