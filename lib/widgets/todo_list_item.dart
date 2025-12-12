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
    final theme = Theme.of(context);
    final isCompleted = todo.isCompleted;

    return Card(
      color: isCompleted ? theme.colorScheme.primary.withValues(alpha: 0.06) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: (_) {
            onToggleCompleted?.call();
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration:
                isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            color: isCompleted ? Colors.black54 : Colors.black87,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.redAccent,
          onPressed: onDelete,
        ),
      ),
    );
  }
}
