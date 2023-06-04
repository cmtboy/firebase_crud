import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/providers/to_do_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatelessWidget {
  final QueryDocumentSnapshot task;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  EditTaskScreen({super.key, required this.task})
      : titleController = TextEditingController(text: task['title']),
        descriptionController =
            TextEditingController(text: task['description']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isNotEmpty) {
                  final todoProvider =
                      Provider.of<TodoProvider>(context, listen: false);
                  todoProvider.updateTask(task.id, title, description);

                  Navigator.pop(context);
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
