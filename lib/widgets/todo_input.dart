import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const TodoInput({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'New todo',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onAdd,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
