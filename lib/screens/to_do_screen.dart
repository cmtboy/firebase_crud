import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Provider.of<TodoProvider>(context).isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildTodoList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoList(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error fetching tasks'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final tasks = snapshot.data?.docs ?? [];

        if (tasks.isEmpty) {
          return Center(child: Text('No tasks found'));
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            final title = task['title'] ?? '';
            final description = task['description'] ?? '';
            final isCompleted = task['isCompleted'] ?? false;

            return ListTile(
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
                icon: Icon(Icons.delete),
                onPressed: () {
                  todoProvider.deleteTask(task.id);
                },
              ),
              leading: Checkbox(
                value: isCompleted,
                onChanged: (value) {
                  todoProvider.updateTaskCompletion(task.id, value ?? false);
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
            );
          },
        );
      },
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isNotEmpty) {
                  final todoProvider =
                      Provider.of<TodoProvider>(context, listen: false);
                  todoProvider.addTask(title, description);

                  Navigator.pop(context);
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTaskScreen extends StatelessWidget {
  final QueryDocumentSnapshot task;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  EditTaskScreen({required this.task})
      : titleController = TextEditingController(text: task['title']),
        descriptionController =
            TextEditingController(text: task['description']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
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
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoProvider with ChangeNotifier {
  bool isLoading = true;

  Future<void> addTask(String title, String description) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': title,
        'description': description,
        'isCompleted': false,
      });
    } catch (error) {
      print('Error adding task: $error');
    }
  }

  Future<void> updateTask(
      String taskId, String title, String description) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
        'title': title,
        'description': description,
      });
    } catch (error) {
      print('Error updating task: $error');
    }
  }

  Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
        'isCompleted': isCompleted,
      });
    } catch (error) {
      print('Error updating task completion: $error');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
    } catch (error) {
      print('Error deleting task: $error');
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void listenToTasks() {
    FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .listen((snapshot) {
      setLoading(true);
      // Delay the loading state to demonstrate the CircularProgressIndicator
      Future.delayed(Duration(seconds: 2), () {
        setLoading(false);
      });
    });
  }
}
