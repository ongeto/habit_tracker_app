import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/create_habit_screen.dart';
import 'screens/calendar_view.dart';
import 'screens/profile_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/habits_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/habit_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HabitProvider()),
      ],
      child: const HabitTrackerApp(),
    ),
  );
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF4E5DE3),
          secondary: Color(0xFF4E5DE3),
        ),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/' && 
            settings.arguments == null) {
          return MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/create_habit': (context) => const CreateHabitScreen(),
        '/calendar_view': (context) => const CalendarView(),
        '/profile': (context) => const ProfileScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/stats': (context) => const StatsScreen(),
        '/habits': (context) => const HabitsScreen(),
      },
    );
  }
}