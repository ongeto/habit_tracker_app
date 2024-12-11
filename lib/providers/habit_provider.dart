import 'package:flutter/foundation.dart';
import '../models/habit.dart';
import '../services/database_helper.dart';

class HabitProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper();
  List<Habit> _habits = [];
  bool _isLoading = false;

  List<Habit> get habits => _habits;
  bool get isLoading => _isLoading;

  Future<void> loadHabits() async {
    _isLoading = true;
    notifyListeners();

    try {
      _habits = await _db.getHabits();
    } catch (e) {
      print('Error loading habits: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addHabit(Habit habit) async {
    try {
      await _db.insertHabit(habit);
      _habits.add(habit);
      notifyListeners();
    } catch (e) {
      print('Error adding habit: $e');
      rethrow;
    }
  }

  Future<void> updateHabit(Habit habit) async {
    try {
      await _db.updateHabit(habit);
      final index = _habits.indexWhere((h) => h.id == habit.id);
      if (index != -1) {
        _habits[index] = habit;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating habit: $e');
      rethrow;
    }
  }

  Future<void> deleteHabit(String id) async {
    try {
      await _db.deleteHabit(id);
      _habits.removeWhere((h) => h.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting habit: $e');
      rethrow;
    }
  }

  Future<void> toggleHabitCompletion(String id) async {
    try {
      final habitIndex = _habits.indexWhere((h) => h.id == id);
      if (habitIndex == -1) return;

      final habit = _habits[habitIndex];
      final today = DateTime.now();
      final isCompleted = habit.isCompletedToday;

      List<DateTime> newCompletedDates = [...habit.completedDates];
      if (isCompleted) {
        newCompletedDates.removeWhere((date) =>
            date.year == today.year &&
            date.month == today.month &&
            date.day == today.day);
      } else {
        newCompletedDates.add(today);
      }

      final updatedHabit = habit.copyWith(completedDates: newCompletedDates);
      await updateHabit(updatedHabit);
    } catch (e) {
      print('Error toggling habit completion: $e');
      rethrow;
    }
  }
} 