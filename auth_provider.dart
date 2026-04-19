/*import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/token_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await TokenService.getToken();
    _isAuthenticated = token != null;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final success = await AuthService.login(email, password);

    _isLoading = false;
    _isAuthenticated = success;
    notifyListeners();

    return success;
  }

  Future<bool> signup(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final success = await AuthService.signup(name, email, password);

    _isLoading = false;
    notifyListeners();

    return success;
  }

  Future<void> logout() async {
    await AuthService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }
}
*/
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;
  Map<String, dynamic>? _user;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get user => _user;

  /// Login method
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('🔐 AuthProvider: Starting login for $username');

      final result = await AuthService.login(username, password);

      if (result['success']) {
        print('✅ AuthProvider: Login successful');
        _isAuthenticated = true;

        // ✅ FIX: Fetch user info immediately after login
        await fetchCurrentUser();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        print('❌ AuthProvider: Login failed - ${result['message']}');
        _errorMessage = result['message'];
        _isAuthenticated = false;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ AuthProvider: Login error - $e');
      _errorMessage = 'Login failed: ${e.toString()}';
      _isAuthenticated = false;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Signup method
  Future<bool> signup(String username, String email, String password, String name) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('📝 AuthProvider: Starting signup for $username');

      final result = await AuthService.signup(username, email, password, name);

      if (result['success']) {
        print('✅ AuthProvider: Signup successful');
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        print('❌ AuthProvider: Signup failed - ${result['message']}');
        _errorMessage = result['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ AuthProvider: Signup error - $e');
      _errorMessage = 'Signup failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Fetch current user info from backend
  Future<void> fetchCurrentUser() async {
    try {
      print('👤 AuthProvider: Fetching current user...');

      final userData = await AuthService.getCurrentUser();

      if (userData != null) {
        _user = userData;
        _isAuthenticated = true;
        print('✅ AuthProvider: User fetched - ${userData['name']}');
        notifyListeners();
      } else {
        print('❌ AuthProvider: Failed to fetch user');
        _user = null;
        _isAuthenticated = false;
        notifyListeners();
      }
    } catch (e) {
      print('❌ AuthProvider: Fetch user error - $e');
      _user = null;
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  /// Check if user is logged in (on app start)
  Future<void> checkAuthStatus() async {
    print('🔍 AuthProvider: Checking auth status...');

    final isLoggedIn = await AuthService.isLoggedIn();

    if (isLoggedIn) {
      print('✅ AuthProvider: User has valid token');
      _isAuthenticated = true;

      // Fetch user info
      await fetchCurrentUser();
    } else {
      print('❌ AuthProvider: No valid token found');
      _isAuthenticated = false;
      _user = null;
    }

    notifyListeners();
  }

  /// Logout method
  Future<void> logout() async {
    print('🚪 AuthProvider: Logging out...');

    await AuthService.logout();

    _isAuthenticated = false;
    _user = null;
    _errorMessage = null;

    print('✅ AuthProvider: Logged out successfully');
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}