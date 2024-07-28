import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display user profile information
            const Text('Email: victorongeto@chiefwebs.com'),
            const Text('Account created on: 2023-01-01'),
            const Text('Points: 100'),
            const Text('Cheat Days: 2'),
            ElevatedButton(
              onPressed: () {
                // Implement Google account linking
              },
              child: const Text('Link Google Account'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logout
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement password change
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
