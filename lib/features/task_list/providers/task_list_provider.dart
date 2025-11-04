import 'package:my_task_app/features/task_list/models/task_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_list_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  Future<List<Task>> build() async {
    // This is where you'd call your API repository
    // I'll simulate a 2-second network delay
    await Future.delayed(const Duration(seconds: 2));

    // Return fake data for the example
    return [
      Task(id: '1', name: 'Grocery Shopping', isRecurring: false, hasChild: false),
      Task(id: '2', name: 'Home Cleaning', isRecurring: false, hasChild: false),
      Task(id: '3', name: 'Project Planning', isRecurring: false, hasChild: false),
      Task(id: '4', name: 'Workout Routine', isRecurring: true, hasChild: true),
    ];

    // To test the error state, uncomment this:
    // throw Exception('Failed to load tasks');
  }
}