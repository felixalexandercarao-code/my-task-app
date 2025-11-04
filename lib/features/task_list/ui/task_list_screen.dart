import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import your new provider
import 'package:my_task_app/features/task_list/providers/task_list_provider.dart';
// Import your model and row widget
import 'package:my_task_app/features/task_list/models/task_model.dart';
import 'package:my_task_app/features/task_list/ui/widgets/task_row.dart';

// 1. Change to a ConsumerWidget
class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  // 2. Add 'WidgetRef ref'
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. Watch the provider. This gives you an AsyncValue
    final AsyncValue<List<Task>> myDayTasks = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text('My Day'),
        centerTitle: true,
      ),
      
      // 4. Use the .when() builder to handle all states
      body: myDayTasks.when(
        loading: () {
          // --- LOADING STATE ---
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          // --- ERROR STATE ---
          return Center(
            child: Text('Failed to load tasks: $error'),
          );
        },
        data: (tasks) {
          // --- DATA STATE ---
          
          // (Optional) Handle empty list
          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks for today!'),
            );
          }

          // Your existing ListView, now built from the 'tasks' data
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskRow(
                task: task,
              );
            },
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the floating action button
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}