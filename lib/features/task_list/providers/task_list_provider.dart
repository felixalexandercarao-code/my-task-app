import 'package:my_task_app/features/task_list/models/task_model.dart';
import 'package:my_task_app/shared/utils/helpers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_list_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  Future<List<Task>> build() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      Task(id: '1', name: 'Grocery Shopping', isRecurring: false, hasChild: false),
      Task(id: '2', name: 'Home Cleaning', isRecurring: false, hasChild: false),
      Task(id: '3', name: 'Project Planning', isRecurring: false, hasChild: false),
      Task(id: '4', name: 'Workout Routine', isRecurring: true, hasChild: true),
    ];

    // To test the error state, uncomment this:
    // throw Exception('Failed to load tasks');
  }

  // THIS IS THE KEY METHOD
  Future<void> toggleTask(String taskId) async {
    final allTasks = state.value;
    if (allTasks == null) return;
    final taskList = [
      for (final task in allTasks)
        if (task.id == taskId)
          if (task.datesAccomplished.isNotEmpty)
            task.copyWith(datesAccomplished: ([...task.datesAccomplished]..removeLast()))
          else
            task.copyWith(datesAccomplished: [DateTime.now().toString()])
        else
          task,
    ];
    state = AsyncValue.data(taskList);
    try {
      //TODO implement api
      // Call your API
      //await ref.read(apiProvider).updateTaskStatus(taskId, newStatus);
      await Helpers.simulateFailedOperation();


    } catch (e) {
      state = AsyncValue.data(allTasks);
      print("Failed to update task: $e");
      //TODO show pop up or snackbar
    }
  }
}