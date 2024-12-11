import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/habit_provider.dart';
import '../models/habit.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final habits = habitProvider.habits;
    final categoryStats = _calculateCategoryStats(habits);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Statistics',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: habitProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Habit Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Pie Chart
                    habits.isEmpty
                        ? const Center(
                            child: Text(
                              'No habits yet',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: _createPieChartSections(categoryStats),
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                    
                    // Legend
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: categoryStats.entries.map((entry) {
                        return _buildLegendItem(
                          entry.key,
                          _getCategoryColor(entry.key),
                        );
                      }).toList(),
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Statistics Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Total Habits',
                            habits.length.toString(),
                            Icons.track_changes,
                            Colors.amber[700]!,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Active Days',
                            _calculateTotalActiveDays(habits).toString(),
                            Icons.calendar_today,
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Best Streak',
                            _calculateBestStreak(habits).toString(),
                            Icons.flash_on,
                            Colors.green,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Monthly Progress
                    const Text(
                      'Category Progress',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...categoryStats.entries.map((entry) {
                      final completionRate = _calculateCategoryCompletionRate(
                        habits,
                        entry.key,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildProgressCard(
                          context,
                          entry.key,
                          completionRate,
                          _getCategoryColor(entry.key),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
    );
  }

  Map<String, int> _calculateCategoryStats(List<Habit> habits) {
    final stats = <String, int>{};
    for (final habit in habits) {
      stats[habit.category] = (stats[habit.category] ?? 0) + 1;
    }
    return stats;
  }

  List<PieChartSectionData> _createPieChartSections(Map<String, int> stats) {
    final total = stats.values.fold<int>(0, (sum, count) => sum + count);
    return stats.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${percentage.round()}%',
        color: _getCategoryColor(entry.key),
        radius: 50,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'health':
        return Colors.pink[300]!;
      case 'productivity':
        return Colors.blue[300]!;
      case 'personal':
        return Colors.amber[300]!;
      case 'social':
        return Colors.green[300]!;
      case 'education':
        return Colors.purple[300]!;
      case 'finance':
        return Colors.teal[300]!;
      case 'fitness':
        return Colors.orange[300]!;
      case 'mindfulness':
        return Colors.indigo[300]!;
      default:
        return Colors.grey[300]!;
    }
  }

  int _calculateTotalActiveDays(List<Habit> habits) {
    final allDates = habits
        .expand((habit) => habit.completedDates)
        .map((date) => DateTime(date.year, date.month, date.day))
        .toSet();
    return allDates.length;
  }

  int _calculateBestStreak(List<Habit> habits) {
    return habits.fold(0, (maxStreak, habit) {
      return habit.currentStreak > maxStreak ? habit.currentStreak : maxStreak;
    });
  }

  double _calculateCategoryCompletionRate(List<Habit> habits, String category) {
    final categoryHabits = habits.where((h) => h.category == category);
    if (categoryHabits.isEmpty) return 0.0;

    int completedCount = 0;
    int totalCount = 0;

    for (final habit in categoryHabits) {
      if (habit.isCompletedToday) completedCount++;
      totalCount++;
    }

    return completedCount / totalCount;
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
    BuildContext context,
    String category,
    double progress,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }
} 