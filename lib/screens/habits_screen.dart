import 'package:flutter/material.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'My Habits',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/create_habit'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHabitCard(
            'Morning Meditation',
            'Health',
            '5 day streak',
            true,
          ),
          const SizedBox(height: 12),
          _buildHabitCard(
            'Read for 30 minutes',
            'Personal',
            '3 day streak',
            true,
          ),
          const SizedBox(height: 12),
          _buildHabitCard(
            'Exercise',
            'Health',
            '7 day streak',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(
    String title,
    String category,
    String streak,
    bool isCompleted,
  ) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(category),
            Text(
              streak,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.check_circle,
          color: isCompleted ? Colors.green : Colors.grey.withOpacity(0.3),
          size: 30,
        ),
      ),
    );
  }
} 