class Task {
  final String id;
  final String name;
  final bool isRecurring;
  final int? recurrence;
  final List<String> datesAccomplished;
  final bool hasChild;
  final List<String> childTasks;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Task({
    required this.id,
    required this.name,
    required this.isRecurring,
    this.recurrence,
    List<String>? datesAccomplished,
    required this.hasChild,
    List<String>? childTasks,
    this.createdAt,
    this.updatedAt,
  })  : datesAccomplished = datesAccomplished ?? [],
        childTasks = childTasks ?? [];

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      name: (json['name'] ?? '') as String,
      isRecurring: (json['isRecurring'] ?? false) as bool,
      recurrence: json['recurrence'] != null ? (json['recurrence'] as num).toInt() : null,
      datesAccomplished: json['datesAccomplished'] != null
          ? List<String>.from(json['datesAccomplished'])
          : <String>[],
      hasChild: (json['hasChild'] ?? false) as bool,
      childTasks: json['childTasks'] != null ? List<String>.from(json['childTasks'].map((c) => c is String ? c : (c['_id'] ?? '').toString())) : <String>[],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) '_id': id,
      'name': name,
      'isRecurring': isRecurring,
      'recurrence': recurrence,
      'datesAccomplished': datesAccomplished,
      'hasChild': hasChild,
      'childTasks': childTasks,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Task copyWith({
    String? id,
    String? name,
    bool? isRecurring,
    int? recurrence,
    List<String>? datesAccomplished,
    bool? hasChild,
    List<String>? childTasks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrence: recurrence ?? this.recurrence,
      datesAccomplished: datesAccomplished ?? this.datesAccomplished,
      hasChild: hasChild ?? this.hasChild,
      childTasks: childTasks ?? this.childTasks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}