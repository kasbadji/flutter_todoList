import 'package:flutter/material.dart';
import '../widgets/todo_list_item.dart';
import '../widgets/todo_input.dart';
import '../models/todo.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Todo> _todos = [];

  void _addTodo() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _todos.add(
        Todo(
          id: DateTime.now().toIso8601String(),
          title: text,
        )
      );
    });
    _textController.clear();
  }

  void _removeTodoAt(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _toggleTodoCompleted(Todo todo) {
    setState(() {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index == -1) return;

      final current = _todos[index];
      _todos[index] = current.copyWith(
         isCompleted: !current.isCompleted
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // access the prop from the widget
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TodoInput(
                    controller: _textController,
                    onAdd: _addTodo
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _todos.isEmpty
                  ? const Center(
                      child: Text(
                        'No todos yet. Add one!',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        final todo = _todos[index];
                        return TodoListItem(
                          todo: todo,
                          onToggleCompleted: () => _toggleTodoCompleted(todo),
                          onDelete: () => _removeTodoAt(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
