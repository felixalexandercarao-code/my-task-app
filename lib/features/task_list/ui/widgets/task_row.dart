import 'package:flutter/material.dart';
import '../../models/task_model.dart';

class TaskRow extends StatelessWidget {
  final Task task;
  final bool showCheckbox;
  final bool checked;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback? onTap;

  const TaskRow({
    Key? key,
    required this.task,
    this.showCheckbox = false,
    this.checked = false,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  String _subtitleText() {
    final childCount = task.childTasks.length;
    if (childCount > 0) return '$childCount task${childCount == 1 ? '' : 's'}';
    final accomplished = task.datesAccomplished.length;
    return '$accomplished task${accomplished == 1 ? '' : 's'}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _subtitleText(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (showCheckbox)
              Checkbox(
                value: checked,
                onChanged: onChanged,
              )
            else
              const Icon(
                Icons.chevron_right,
                color: Colors.black26,
              ),
          ],
        ),
      ),
    );
  }
}