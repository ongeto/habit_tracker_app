import 'package:flutter/foundation.dart';
import 'package:shared_preferences.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement actual authentication
      // For now, simulate a login
      await Future.delayed(const Duration(seconds: 1));
      
      _user = User(
        id: '1',
        name: 'John Doe',
        email: email,
      );

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', email);
      await prefs.setString('user_name', 'John Doe');
      await prefs.setString('user_id', '1');

    } catch (e) {
      print('Error logging in: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signup(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement actual signup
      // For now, simulate a signup
      await Future.delayed(const Duration(seconds: 1));
      
      _user = User(
        id: '1',
        name: name,
        email: email,
      );

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', email);
      await prefs.setString('user_name', name);
      await prefs.setString('user_id', '1');

    } catch (e) {
      print('Error signing up: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      _user = null;
    } catch (e) {
      print('Error logging out: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userEmail = prefs.getString('user_email');
      final userName = prefs.getString('user_name');
      final userId = prefs.getString('user_id');

      if (userEmail != null && userName != null && userId != null) {
        _user = User(
          id: userId,
          name: userName,
          email: userEmail,
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error checking auth status: $e');
    }
  }
} 