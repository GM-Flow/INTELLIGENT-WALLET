/*import 'dart:convert';
import 'api_service.dart';
import 'token_service.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    final response = await ApiService.post(
      '/auth/login',
      {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await TokenService.saveToken(data['access_token']);
      return true;
    }
    return false;
  }

  static Future<bool> signup(
      String name, String email, String password) async {
    final response = await ApiService.post(
      '/auth/register',
      {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return response.statusCode == 201;
  }

  static Future<void> logout() async {
    await TokenService.clearToken();
  }
}
*/



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'token_service.dart';

class AuthService {
  // Login - Returns success status and message
  static Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      print('🔐 LOGIN ATTEMPT: $username');
      print('🌐 URL: ${ApiService.baseUrl}/api/v1/auth/login');

      // Backend expects form-urlencoded for OAuth2
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/api/v1/auth/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
        // ✅ FIXED: Use Map instead of manual string concatenation
        // This properly escapes special characters like & in passwords
        body: {
          'username': username,
          'password': password,
        },
      );

      print('📡 RESPONSE STATUS: ${response.statusCode}');
      print('📄 RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Save both tokens
        await TokenService.saveTokens(
          data['access_token'],
          data['refresh_token'],
        );

        print('✅ LOGIN SUCCESS! Tokens saved.');

        return {
          'success': true,
          'user': data['user'],
        };
      } else if (response.statusCode == 401) {
        final error = jsonDecode(response.body);
        print('❌ 401 UNAUTHORIZED: ${error['detail']}');
        return {
          'success': false,
          'message': error['detail'] ?? 'Invalid credentials',
        };
      } else {
        print('❌ LOGIN FAILED: ${response.statusCode}');
        final errorBody = response.body;
        print('❌ ERROR BODY: $errorBody');
        return {
          'success': false,
          'message': 'Login failed. Please try again.',
        };
      }
    } catch (e) {
      print('❌ NETWORK ERROR: $e');
      return {
        'success': false,
        'message': 'Network error. Check your connection.',
      };
    }
  }

  // Signup - Returns success status and message
  static Future<Map<String, dynamic>> signup(
      String username,
      String email,
      String password,
      String name,
      ) async {
    try {
      print('📝 SIGNUP ATTEMPT: $username ($email)');

      final response = await ApiService.post(
        '/api/v1/auth/register',
        {
          'username': username,
          'email': email,
          'password': password,
          'name': name,
        },
      );

      print('📡 SIGNUP STATUS: ${response.statusCode}');
      print('📄 SIGNUP BODY: ${response.body}');

      if (response.statusCode == 201) {
        print('✅ SIGNUP SUCCESS!');
        return {'success': true};
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        print('❌ 400 BAD REQUEST: ${error['detail']}');
        return {
          'success': false,
          'message': error['detail'] ?? 'Registration failed',
        };
      } else if (response.statusCode == 422) {
        final error = jsonDecode(response.body);
        // Extract validation error message
        String errorMsg = 'Invalid input';
        if (error['detail'] is List && error['detail'].isNotEmpty) {
          errorMsg = error['detail'][0]['msg'] ?? errorMsg;
        } else if (error['detail'] is String) {
          errorMsg = error['detail'];
        }
        print('❌ 422 VALIDATION ERROR: $errorMsg');
        return {
          'success': false,
          'message': errorMsg,
        };
      } else {
        print('❌ SIGNUP FAILED: ${response.statusCode}');
        return {
          'success': false,
          'message': 'Registration failed. Please try again.',
        };
      }
    } catch (e) {
      print('❌ NETWORK ERROR: $e');
      return {
        'success': false,
        'message': 'Network error. Check your connection.',
      };
    }
  }

  // Logout
  static Future<void> logout() async {
    await TokenService.clearTokens();
    print('✅ LOGGED OUT - Tokens cleared');
  }

  // Check if logged in
  static Future<bool> isLoggedIn() async {
    return await TokenService.isLoggedIn();
  }

  // Get current user (authenticated endpoint)
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      print('👤 FETCHING CURRENT USER...');

      final response = await ApiService.get('/api/v1/auth/me', authenticated: true);

      print('📡 GET USER STATUS: ${response.statusCode}');

      if (response.statusCode == 200) {
        final user = jsonDecode(response.body);
        print('✅ USER FETCHED: ${user['username']}');
        return user;
      }
      print('❌ FAILED TO FETCH USER');
      return null;
    } catch (e) {
      print('❌ GET USER ERROR: $e');
      return null;
    }
  }
}