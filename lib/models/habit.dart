import 'package:uuid/uuid.dart';

class Habit {
  final String id;
  final String title;
  final String description;
  final String category;
  final int targetDays;
  final List<DateTime> completedDates;
  final bool morningReminder;
  final bool afternoonReminder;
  final bool eveningReminder;
  final DateTime createdAt;

  Habit({
    String? id,
    required this.title,
    required this.description,
    required this.category,
    required this.targetDays,
    List<DateTime>? completedDates,
    this.morningReminder = false,
    this.afternoonReminder = false,
    this.eveningReminder = false,
  })  : id = id ?? const Uuid().v4(),
        completedDates = completedDates ?? [],
        createdAt = DateTime.now();

  int get currentStreak {
    if (completedDates.isEmpty) return 0;
    
    final sortedDates = [...completedDates]..sort();
    int streak = 1;
    
    for (int i = sortedDates.length - 1; i > 0; i--) {
      final difference = sortedDates[i].difference(sortedDates[i - 1]).inDays;
      if (difference == 1) {
        streak++;
      } else {
        break;
      }
    }
    
    return streak;
  }

  bool get isCompletedToday {
    final today = DateTime.now();
    return completedDates.any((date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'targetDays': targetDays,
      'completedDates': completedDates.map((d) => d.toIso8601String()).toList(),
      'morningReminder': morningReminder ? 1 : 0,
      'afternoonReminder': afternoonReminder ? 1 : 0,
      'eveningReminder': eveningReminder ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      targetDays: map['targetDays'],
      completedDates: (map['completedDates'] as List)
          .map((d) => DateTime.parse(d))
          .toList(),
      morningReminder: map['morningReminder'] == 1,
      afternoonReminder: map['afternoonReminder'] == 1,
      eveningReminder: map['eveningReminder'] == 1,
    );
  }

  Habit copyWith({
    String? title,
    String? description,
    String? category,
    int? targetDays,
    List<DateTime>? completedDates,
    bool? morningReminder,
    bool? afternoonReminder,
    bool? eveningReminder,
  }) {
    return Habit(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      targetDays: targetDays ?? this.targetDays,
      completedDates: completedDates ?? this.completedDates,
      morningReminder: morningReminder ?? this.morningReminder,
      afternoonReminder: afternoonReminder ?? this.afternoonReminder,
      eveningReminder: eveningReminder ?? this.eveningReminder,
    );
  }
} 