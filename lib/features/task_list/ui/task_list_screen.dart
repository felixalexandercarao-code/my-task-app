import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_task_app/features/task_list/providers/task_list_provider.dart';
import 'package:my_task_app/features/task_list/models/task_model.dart';
import 'package:my_task_app/features/task_list/ui/widgets/task_row.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: myDayTasks.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Failed to load tasks: $error'),
          );
        },
        data: (tasks) {
          
          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks for today!'),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskRow(
                task: task,
                onTap: () {
                  ref.read(taskListProvider.notifier).toggleTask(task.id);
                },
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