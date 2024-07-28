import 'package:flutter/material.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({super.key});

  @override
  CreateHabitScreenState createState() => CreateHabitScreenState();
}

class CreateHabitScreenState extends State<CreateHabitScreen> {
  final _formKey = GlobalKey<FormState>();

  String habitName = '';
  String habitDescription = '';
  String habitFrequency = 'Daily';
  int targetDuration = 30;
  TimeOfDay reminderTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Habit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Habit Name'),
                onSaved: (value) {
                  habitName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Habit Description'),
                onSaved: (value) {
                  habitDescription = value!;
                },
              ),
              DropdownButtonFormField(
                value: habitFrequency,
                items: ['Daily', 'Weekly', 'Monthly']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    habitFrequency = value as String;
                  });
                },
                decoration: const InputDecoration(labelText: 'Frequency'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Target Duration'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  targetDuration = int.parse(value!);
                },
              ),
              ListTile(
                title: Text('Reminder Time: ${reminderTime.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: reminderTime,
                  );
                  if (picked != null && picked != reminderTime) {
                    setState(() {
                      reminderTime = picked;
                    });
                  }
                },
              ),
              SwitchListTile(
              title: const Text('Enable Motivation Tips'),
              value: true,
              onChanged: (bool value) {},
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Reward System'),
              items: <String>['Points-based', 'Cheat-day based']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save habit details to the database or state management
                    Navigator.of(context).pushNamed('/home');
                  }
                },
                child: const Text('Save Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
