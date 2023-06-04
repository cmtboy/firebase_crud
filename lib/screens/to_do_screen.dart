import 'package:firebase_crud/providers/to_do_provider.dart';
import 'package:firebase_crud/screens/add_task_screen.dart';
import 'package:firebase_crud/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crud/widgets/bottom_nav_bar.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo List'),
      ),
      body: Provider.of<TodoProvider>(context).isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildTodoList(context, user!.uid),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoList(BuildContext context, String uid) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching tasks'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = snapshot.data?.docs ?? [];

        if (tasks.isEmpty) {
          return const Center(child: Text('No tasks found'));
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            final title = task['title'] ?? '';
            final description = task['description'] ?? '';
            final isCompleted = task['isCompleted'] ?? false;

            return Card(
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    color: isCompleted ? Colors.green : Colors.black,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text(description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Delete Task"),
                        content: Text("You want to delete this task?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('NO'),
                          ),
                          TextButton(
                            onPressed: () {
                              todoProvider.deleteTask(uid, task.id, context);
                              Navigator.pop(context);
                            },
                            child: Text("Yes"),
                          )
                        ],
                      ),
                    );
                  },
                ),
                leading: Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    todoProvider.updateTaskCompletion(
                        uid, task.id, value ?? false, context);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditTaskScreen(task: task),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
