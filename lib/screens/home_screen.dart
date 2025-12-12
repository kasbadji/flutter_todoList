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
        title: Text(widget.title),
        leading: const Icon(Icons.check_circle_outline),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TodoInput(
                controller: _textController,
                onAdd: _addTodo,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _todos.isEmpty
                    ? const _EmptyState()
                    : ListView.builder(
                        itemCount: _todos.length,
                        itemBuilder: (context, index) {
                          final todo = _todos[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TodoListItem(
                              todo: todo,
                              onToggleCompleted: () => _toggleTodoCompleted(todo),
                              onDelete: () => _removeTodoAt(index),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            'No todos yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Add your first task above to get started.',
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

